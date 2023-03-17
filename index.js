const admin = require('bindings')('admin.node')

function askForAdminPrivilege(appId) {
  if (typeof appId !== 'string') {
    throw new TypeError('appId must be a string')
  }
  return admin.askForAdminPrivilege.call(this, appId)
}

module.exports = {
  ask: askForAdminPrivilege,
}
