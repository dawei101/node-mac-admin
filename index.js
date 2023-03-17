const permissions = require('bindings')('permissions.node')

function askForAdminPrivilege(appId) {
  if (typeof appId !== 'string') {
    throw new TypeError('appId must be a string')
  }
  return permissions.askForAdminPrivilege.call(this, appId)
}

module.exports = {
  ask: askForAdminPrivilege,
}
