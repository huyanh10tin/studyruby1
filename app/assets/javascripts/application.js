// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require rails-ujs
//= require turbolinks
//= require_tree .


$('document').ready(function() {
    setTimeout(function() {
        $('.alert').hide();
    }, 3000);


});
// var preview = $(".upload-preview img");
//
// $(".file").change(function(event){
//     var input = $(event.currentTarget);
//     var file = input[0].files[0];
//     var reader = new FileReader();
//     reader.onload = function(e){
//         image_base64 = e.target.result;
//         preview.attr("src", image_base64);
//     };
//     reader.readAsDataURL(file);
// });
var loadFile = function(event) {
    var output = document.getElementById('image-preview');
    output.src = URL.createObjectURL(event.target.files[0]);
};
