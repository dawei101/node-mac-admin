[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)

# node-mac-admin

## Overview

```js
$ npm i node-mac-admin
```

This native Node.js module allows you to get admin privilege on macOS

## API

### `admin.ask(appId)`

* `appId` String - eg. com.google.chrome

Return Value Descriptions: 
* `throw exception` - Failed
* `not throw exception` - OK

Example:
```js
admin.ask("com.google.chrome").then(function(result){
    console.info("ok!")
}).catch(function(msg){
    console.error(msg)
})

```

