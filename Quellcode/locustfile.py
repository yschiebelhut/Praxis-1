from locust import HttpUser, task, between
import time
import json

odataUser = "root"
odataPasswd = "123"

class ODataUser(HttpUser):
    wait_time = between(0.25, 15)
    @task(1)
    def getHealthz(self):
        self.client.get("/healthz")

    @task(10)
    def getWhoSet(self):
        self.client.get(
            "/odata/SAP/ZEWM_ROBCO_SRV/WarehouseOrderSet/?$top=20", auth=(odataUser, odataPasswd))

    @task(10)
    def getRobotSet(self):
        self.client.get("/odata/SAP/ZEWM_ROBCO_SRV/RobotSet/?$top=20",
                        auth=(odataUser, odataPasswd))

    @task(5)
    def createRobot(self):
        robot = {"Lgnum": "0815", "Rsrc": "Isaac"}
        self.client.post("/odata/SAP/ZEWM_ROBCO_SRV/RobotSet",
                         auth=(odataUser, odataPasswd), json=robot)

    @task(6)
    def deleteRobot(self):
        count = self.client.get("/odata/SAP/ZEWM_ROBCO_SRV/RobotSet/$count",
                                auth=(odataUser, odataPasswd)).json()
        if (int(count) > 0):
            robot = self.client.get("/odata/SAP/ZEWM_ROBCO_SRV/\
                RobotSet/?$top=1",
                                    auth=(odataUser, odataPasswd)).json()
            robot = json.loads(json.dumps(robot))['d']['results'][0]
            self.client.delete("/odata/SAP/ZEWM_ROBCO_SRV/\
            RobotSet(Lgnum='0815',Rsrc='Isaac')",
                               auth=(odataUser, odataPasswd), json=robot)