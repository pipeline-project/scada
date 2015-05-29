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
//= require angular
//= require_tree .

$(document).on("ready page:load", function() {
  $('.step select').on('change', function() {
    var options = $(this).closest('.step').find('.options');
    var current_options = step_type_options[$(this).val()];
    options.find('.form-group').filter(function() {
      return current_options.indexOf($(this).find('input').data('option')) == -1;
    }).remove();

    var filtered_options = $.grep(current_options, function(n) {
      return options.has('input[data-option="' + n + '"]').length === 0;
    });

    var template = options.find('.form-group')[0].outerHTML;

    $.each(filtered_options, function(i) {
      options.append(template.replace(/field/ig, filtered_options[i]));
    });
  });
});