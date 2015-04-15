$(document).ready(function() {
  $('[data-unit="create"]').on('submit', function(event) {
    event.preventDefault();
    $form = $(event.currentTarget);
    $.ajax({
      type: "POST",
      url: $form.attr('action'),
      data: $($form).serialize(),
      dataType: 'json',
      success: function(unit) {
        action = '/units/'+ unit.id;
        $newForm = $('<form>').attr({
          action: action,
          method: 'delete',
          'data-unit': 'delete'
        });
        $unitButton = $('<input>').attr({type: 'submit', value: 'Delete Unit'});
        $newForm.append($unitButton);
        //Line 20 now makes seven list items. WHY SEVEN?!?!?
        var $unitListing = $('li').addClass('unit').attr('data-unit-id', unit.id).html(unit.name);
        $unitListing.append($newForm)
        $("#contents").append($unitListing);
        }
        });
      });

  $('[data-unit-id]').on('submit', '[data-unit="delete"]', function(event) {
    event.preventDefault();

    $form = $(event.currentTarget);

    $.ajax({
      type: "DELETE",
      url: $form.attr('action'),
      dataType: 'json',
      success: function() {
        $form.closest('[data-unit-id]').remove();
      }
    });
  })
});
