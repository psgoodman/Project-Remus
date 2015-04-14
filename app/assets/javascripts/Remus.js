$(document).ready(function() {
  $('[data-unit="create"]').on('submit', function(event) {
    debugger
    event.preventDefault();
    $form = $(event.currentTarget);
    $.ajax({
      type: "POST",
      url: $form.attr('action'),
      // data: <SOMETHING>
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
        $unitListing = "<li class=\"unit\" data-unit-id=" +
        unit.id + "> " + unit.name + "</li>"
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
