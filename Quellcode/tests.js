process.env.ODATA_USER = "user"
process.env.ODATA_PASSWD = "123"
process.env.GEN_INT = 1000

var server = require('../mockserver')
var assert = require('assert')
var tools = require('../tools/toolbox.js')

describe('Tests for Orderroutine', () => {
	before(() => {
		server.initWithOrderroutine()
	})

	it('look if WarehouseOrderSet is initial', async () => {
		let res = await tools.getEntity("WarehouseOrderSet", {})
		assert.deepStrictEqual(res.body.d.results.length, 1)
	})

	it('wait for intervall', function (done) {
		setTimeout(() => {
			done()
		}, 2000)
	}).timeout(3000)

	it('check if intervall creates an order', async () => {
		let res = await tools.getEntity("WarehouseOrderSet", {})
		assert.deepStrictEqual(res.body.d.results.length > 1, true)
	})

	after(() => {
		server.stop()
		setTimeout(() => {
			process.exit()
		}, 1500)
	})
})