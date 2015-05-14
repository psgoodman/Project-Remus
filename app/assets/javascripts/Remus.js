$(document).ready(function() {
  $('#unit_faction_id').on('change', function(event) {
    var $faction_id = this.value;
    $.ajax({
      type: "GET",
      url: //FIGURE OUT URL
    })
  });

  $('[data-unit="create"]').on('submit', function(event) {
    event.preventDefault();
    var $form = $(event.currentTarget);
    $.ajax({
      type: "POST",
      url: $form.attr('action'),
      data: $($form).serialize(),
      dataType: 'json',
      success: function(unit) {
        var action = '/units/'+ unit.unit.id;
        var $newForm = $('<form>').attr({
          action: action,
          method: 'post',
          'data-unit': 'delete'
        });
        var $unitButton = $('<input>').attr({type: 'submit',
          value: 'Delete Unit', 'data-method': 'delete'});
        var $methodField = $('<input>').attr({type: 'hidden', name: '_method',
          value: 'delete'});
        var $authentoken = $('meta[name=csrf-token]').attr('content');
        var $authentField = $('<input>').attr({type: 'hidden',
          name: 'authenticity_token', value: $authentoken});
        $newForm.append($methodField);
        $newForm.append($authentField);
        $newForm.append($unitButton);
        var $buttonDiv = $('<div>').attr({class: 'actions'});
        $buttonDiv.append($newForm);
        var $unitListing = $('<li>').addClass('unit').attr('data-unit-id',
          unit.unit.id).html(unit.faction);
        $unitListing.append(" " + unit.unit.name);
        $unitListing.append($buttonDiv);
        $("#contents").append($unitListing);
        initDeleteHandler();
      }
    });
  });
  initDeleteHandler();
});

function initDeleteHandler() {
  $('[data-unit-id]').off();

  $('[data-unit-id]').on('submit', '[data-unit="delete"]', function(event) {
    event.preventDefault();

    var $form = $(event.currentTarget);

    $.ajax({
      type: "DELETE",
      url: $form.attr('action'),
      dataType: 'json',
      success: function() {
        $form.closest('[data-unit-id]').remove();
      }
    });
  });
}
