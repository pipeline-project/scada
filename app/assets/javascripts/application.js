// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require AdminLTE.min
//= require jquery_nested_form
//= require jquery.fn.sortable
//= require angular
//= require_tree .

$(document).on("ready page:load", function() {
  $('.step').step();
  $('#steps').sortable({
    handle: ".drag-handle",
    onSort: function(evt) {
      $('#steps .step').each(function(index) {
        $(this).find('.order').val(index);
      });
    }
  });
});

$(document).on('nested:fieldAdded', function(event){
  var field = event.field;
  if (field.is('.step')) {
    field.step();
  }
});