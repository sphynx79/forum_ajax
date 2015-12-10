$.rails.allowAction = function(link) {
  if ( !link.attr('data-confirm') ) { return true }
  $.rails.showConfirmDialog(link);
  return false;
};

$.rails.confirmed = function(link) {
  link.removeAttr('data-confirm');
  return link.trigger('click.rails');
};

$.rails.showConfirmDialog = function(link) {
  var message = link.attr('data-confirm');
  box = bootbox.confirm(message, function(result) {
    if ( result ) { return $.rails.confirmed(link) }
  });
  return box;
};


