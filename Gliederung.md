* Einleitung
    * (Was ist der ewm-sim?)
    * (Wofür wird er eingesetzt?)
    * (Warum soll er neu gebaut werden?)
* Theoretische Grundlagen
    * Docker
        * (WSL)
        * (DockerHub)
    * Node.js
        * npm-Module
    * Postman
    * Kubernetes / Google Cloud Plattform
    * Git / GitHub
        * (GPG commit signing)
    * Travis-CI
    * Jira
    * (VMWare)
* Vorbereitung
    * Analyse der alten ewm-sim Implementierung
    * Recherche zu verschiedenen OData-Mockern
        * (Begründete Entscheidung für Arnauds Implementierung)
* Umsetzung
    * Analyse von node-ui5 und odata-mockserver-server
    * Bau eines eigenen Grundgerüsts des OData-Servers
    * Hinzufügen der Meta- und Mockdaten
    * Implementierung von Authentifizierung
        * (Entscheidungsfindung OAuth2 oder Basic Auth)
    * Wahl einer Testumgebung
        * (Begründete Entscheidung für mocha)
    * Erstellung von Unit Tests
        * (Migration der alten)
        * (Schreiben von neuen)
    * Test Coverage (nyc + coveralls.io)
    * Travis-CI/Pipeline
* Deployment auf GKE und Merge in SAP Repo
* Schluss