var SetRobotStatus = function (oXhr, sUrlParams) {
	logger.debug("invoking SetRobotStatus")
	logger.debug("sUrlParams: " + sUrlParams)
	var oUrlParams = sUrlParams.split("&").reduce(function (prev, curr, i, arr) {
		var p = curr.split("=")
		prev[decodeURIComponent(p[0])] = decodeURIComponent(p[1]).replace(/\`'`/g, '')
		return prev
	}, {})
	logger.debug("oUrlParams: " + JSON.stringify(oUrlParams))
	var uri = ""
	var abort = false


	// 1. Check if the robot resource exists in EWM
	// yes: continue
	// no: return business_error: ROBOT_NOT_FOUND
	uri = "/odata/SAP/ZEWM_ROBCO_SRV/RobotSet(Lgnum='" + oUrlParams.Lgnum + "',Rsrc='" + oUrlParams.Rsrc + "')"
	logger.debug("checking if robot resource exists at: " + uri)
	jQuery.ajax({
		url: uri,
		dataType: 'json',
		async: false,
		success: function (res) {
			logger.debug("found that robot resource " + oUrlParams.Rsrc + " exists")
		},
		error: function (err) {
			logger.debug(JSON.stringify(err))
			logger.debug("robot resource " + oUrlParams.Rsrc + " does not exist")
			oXhr.respondJSON(404, {}, { "error": { "code": "ROBOT_NOT_FOUND" } })
			abort = true
		}
	})
	if(abort)
		return true


	// 2. Check if parameter "ExccodeOverall" has the right length
	// yes: set status for robot (and return robot?)
	// no: return business_error: ROBOT_STATUS_NOT_SET
	if (oUrlParams.ExccodeOverall) {
		if (oUrlParams.ExccodeOverall.length <= 4) {
			jQuery.ajax({
				url: uri, // set at 1.
				method: 'PUT',
				data: JSON.stringify(oUrlParams),
				async: false,
				success: function (res) {
					oXhr.respondJSON(200, {}, res)
					abort = true
				},
				error: function (err) {
					logger.debug(JSON.stringify(err))
					oXhr.respondJSON(404, {}, { "error": { "code": "ROBOT_STATUS_NOT_SET" } })
					abort = true
				}
			})
		}
	}
	if(abort)
		return true

	// else respond with error
	oXhr.respondJSON(404, {}, { "error": { "code": "ROBOT_STATUS_NOT_SET" } })
}


var aRequests = ms.getRequests()
aRequests.push({
	method: "POST",
	path: "SetRobotStatus\\?(.*)",
	response: SetRobotStatus
})
ms.setRequests(aRequests)