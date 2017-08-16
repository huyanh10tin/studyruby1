#class Notifications
##  alert("working")
#  constructor: ->
#    @notifications = $("[data-behavior='notifications']")
#    console.log(@notifications.length)
#    @setup() if @notifications.length > 0
#  setup: ->
#    $("[data-behavior='notifications-link']").on "click",@handleClick
#    $.ajax(
#      url: "/notifications.json"
#      dataType: "JSON"
#      method: "GET"
#      success: @handleSuccess
#    )
#  handleClick: (e) =>
#    $.ajax(
#      url:"/notifications/mark_as_read"
#      dataType: "JSON"
#      method: "POST"
#      success: ->
#        $("[data-behavior='unread-count']").text(0)
#    )
#  handleSuccess: (data) =>
#    console.log(data)
#    items = $.map data, (notification) ->
#      "<li ><a style='color: black;font-weight: bold' href='#{notification.url}'>#{notification.actor} #{notification.notifiable.type} on your post</a></li>"
#    $("[data-behavior='unread-count']").text(items.length)
#    $("[data-behavior='notification-items']").html(items)
#
#
#jQuery ->
#  new Notifications