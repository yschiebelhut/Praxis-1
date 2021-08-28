const basicAuth = require('express-basic-auth')

if (process.env.ODATA_USER && process.env.ODATA_PASSWD) {
	var auth = (basicAuth({
		authorizer: (username, password) => {
			const userMatches = basicAuth.safeCompare(username, process.env.ODATA_USER)
			const passwordMatches = basicAuth.safeCompare(password, process.env.ODATA_PASSWD)
			return userMatches & passwordMatches
		}
	}))
} else {
	logger.warn("credentials not set correctly - aborting")
	process.exit()
}