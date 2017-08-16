document.addEventListener("turbolinks:load", function() {
    var Notifications;
    var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
    Notifications = (function() {
        function Notifications() {
            this.handleSuccess = bind(this.handleSuccess, this);
            this.handleClick = bind(this.handleClick, this);    this.notifications = $("[data-behavior='notifications']");
            // console.log(this.notifications.length);
            //this.setUpdateInterval();
            if (this.notifications.length > 0) {
                this.setup();
            }
        }
        Notifications.prototype.setup = function() {
            $("[data-behavior='notifications-link']").on("click", this.handleClick);
            return $.ajax({
                url: "/notifications.json",
                dataType: "JSON",
                method: "GET",
                success: this.handleSuccess
            });
        };
        Notifications.prototype.setUpdateInterval = function(notifications) {
            var callback;
            callback = this.setup.bind(this);
            return setInterval(callback, 1000);
        };
        Notifications.prototype.handleClick = function(e) {

            return $.ajax({
                url: "/notifications/mark_as_read",
                dataType: "JSON",
                method: "POST",
                success: function() {
                    return $("[data-behavior='unread-count']").text(0);
                }
            });
        };
        Notifications.prototype.handleSuccess = function(data) {
            var items;
            // console.log(data);
            items = $.map(data, function(notification) {
                return "<li ><a style='color: black;font-weight: bold' href='" + notification.url + "'>" + notification.actor + " " + notification.notifiable.type + " on your post</a></li>";
            });
            $("[data-behavior='unread-count']").text(items.length);
            return $("[data-behavior='notification-items']").html(items);
        };
        return Notifications;
    })();
    jQuery(function() {
        return new Notifications;
    });
});
