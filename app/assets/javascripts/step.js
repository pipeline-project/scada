;(function($) {
  'use strict';

  var Step = function(element, options) {
    this.$element = $(element);
    this.options = $.extend({}, Step.DEFAULTS, options);
  };

  Step.prototype.init = function() {
    this.initPanelTitle();
    this.initSelectControl();
  };

  // Set the panel title
  Step.prototype.initPanelTitle = function() {
    var $el = this.$element;
    $el.find('.step-name input').on('change', function() {
      $el.find('.panel-title .name').text($(this).val());
    });

    $el.find('.step-type select').on('change', function() {
      $el.find('.panel-title .type').text($(this).val());
    });
  };

  // Set the form up for a specifc Step
  Step.prototype.initSelectControl = function() {
    var $el = this.$element;
    this.selectControl().on('change', function() {
      var options = $el.find('.options');
      var currentOptions = stepTypeOptions[$(this).val()];
      options.find('.form-group').filter(function() {
        return currentOptions.indexOf($(this).find('input').data('option')) == -1;
      }).remove();

      var filteredOptions = $.grep(currentOptions, function(n) {
        return options.has('input[data-option="' + n + '"]').length === 0;
      });

      var template = options.find('.form-group')[0].outerHTML;

      $.each(filteredOptions, function(i) {
        options.append(template.replace(/field/ig, filteredOptions[i]));
      });
    });
  };

  Step.prototype.selectControl = function() {
    return this.$element.find('select');
  };

  Step.DEFAULTS = { };

  function Plugin(option) {
    return this.each(function() {
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

}(jQuery));
