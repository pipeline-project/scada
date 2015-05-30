+function ($) {
  'use strict';

  var Step = function (element, options) {
    this.$element = $(element);
    this.options = $.extend({}, Step.DEFAULTS, options);
  };

  Step.prototype.init = function() {
    var $el = this.$element;

    this.select_control().on('change', function() {
      var options = $el.find('.options');
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
  };

  Step.prototype.select_control = function() {
    return this.$element.find('select');
  };

  Step.DEFAULTS = { };

  
  function Plugin(option) {
    return this.each(function () {
      var $this   = $(this);
      var data    = $this.data('scada.step');
      var options = typeof option == 'object' && option;

      if (!data) {
        $this.data('scada.step', (data = new Step(this, options)));
        data.init();
      }
    });
  }

  $.fn.step = Plugin;
  $.fn.step.Constructor = Step;

}(jQuery);
