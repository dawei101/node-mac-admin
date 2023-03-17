const { expect } = require('chai')
const { ask } = require('../index')

describe('node-mac-admin', () => {

  describe('ask()', () => {
    it('should throw on invalid types', () => {
      expect(() => {
        ask(123)
      }).to.throw(/appId must be a string/)
    })
  })
})
