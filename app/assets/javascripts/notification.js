// デスクトップ通知
// [JavaScriptでデスクトップ通知を行うためのライブラリ. showメソッドにiconも追加しておきたいところ. #JavaScript - Qiita](http://qiita.com/items/36a01aff73f755a9045d)
Notification = {
    initialized : false,
    NOT_ALLOWED: 1,
    NOT_SUPPORTED: 2,

    // 初期化. 利用前に必ず実行すること
    init: function() {
        if( typeof webkitNotifications === 'undefined' ) {
            return false;
        }
        this.initialized = true;
        if( typeof webkitNotifications.PERMISSION_ALLOWED === 'undefined' ) {
            webkitNotifications.PERMISSION_ALLOWED = 0;
            webkitNotifications.PERMISSION_NOT_ALLOWED = 1;
            webkitNotifications.PERMISSION_DENIED = 2;
        }
        if( typeof webkitNotifications.permissionLevel === 'undefined' ) {
            webkitNotifications.__defineGetter__('permissionLevel', function() {
                return this.checkPermission();
            });
            webkitNotifications.__defineSetter__('permissionLevel', function() {
            });
        }
        if( !webkitNotifications.createWebNotification ) {
            webkitNotifications.createWebNotification = webkitNotifications.createHTMLNotification;
        }
        return true;
    },

    // 作成したNotificationオブジェクトを返す
    create: function(icon, title, message) {
                if( !this.initialized ) {
                    if( !this.init() ) {
                        // ブラウザがNotification APIに対応していない.
                        throw Notification.NOT_SUPPORTED;
                    }
                }
                if( webkitNotifications.permissionLevel !== webkitNotifications.PERMISSION_ALLOWED ) {
                    //許可されていない
                    throw Notification.NOT_ALLOWED;
                } else {
                    return webkitNotifications.createNotification(icon, title, message);
                }
            },

    // ユーザにダイアログを表示する許可をもらう.
    // この関数はユーザが発生させたマウスイベント等の中でのみ正しく実行される.
    ask: function(f) {
             console.log("デスクトップ通知の許可をユーザに求めます。");
             webkitNotifications.requestPermission(f||function(){});
         },

    // Method show Notification.
//    show: function(title, message, timeout) {
    show: function(icon, title, message, timeout) {
        console.log( "[ timeout ] : " + timeout );
        timeout = timeout || 3000;    // default timeout is 3sec(=3,000msec)
        try {
            var notification = Notification.create(icon, title, message);
            notification.ondisplay = function() {
                setTimeout(function(){
                    notification.cancel();
                    console.log("Notification close because timeout");
                }, timeout);
            };
            notification.show();
            console.log("Notification showing");
        } catch(e) {
            switch(e) {
                case Notification.NOT_ALLOWED:
                    Notification.ask();
                    break;
            }
        }
    }
};
