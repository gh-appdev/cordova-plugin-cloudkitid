var cloudKitId = {
    getCloudKitId: function (arg0, successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, 'CloudKitId', 'getCloudKitId', [arg0]);
  }
}

if (!window.plugins) { window.plugins = {}; }

window.plugins.cloudKitId = cloudKitId;
return window.plugins.cloudKitId;
