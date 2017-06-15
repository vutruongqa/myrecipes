// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require custom
//= require typeahead.js
//= require_tree .

function scrollToBottom(){
    if($('#messages').length > 0){
        $('#messages').scrollTop($('#messages')[0].scrollHeight);
    }
}

// $.ajax({
//     type:"GET",
//     url:"recipes",
//     dataType:"json",
//     success:function(result){
//         debugger
//     }
// })



$(document).ready(function(){
    scrollToBottom();
});
$(document).on('change','#the-basics .typeahead', function() {
    /* This will be fired every time, when textbox's value changes. */
    if ($('#the-basics .typeahead').val().length > 2) {
        var id_numbers = new Array();
        $.ajax({
            type: "GET",
            url: '/recipes/autocomplete',
            dataType: "json",
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    id_numbers.push(data[i].name)
                }
            }
        });
        autosuggestion(id_numbers);
    }
} );

