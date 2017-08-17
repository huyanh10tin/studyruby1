$(document).on('turbolinks:load', function() {
    jQuery(function() {});
    return $("[data-behavior='autocomplete']").atwho({
        at: "@",
        'data': "/users.json"
    });
});