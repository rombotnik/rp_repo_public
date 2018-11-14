$(document).on('turbolinks:load', function(){

  var $trix = $('trix-editor');

  if ($trix.length > 0) {
    var trixEditor = $trix[0].editor;

    var regex_heart = /&lt;3/;
    var regex_ndash = /--/;

    $trix.keydown(function(e){
      var document = $trix.val();

      if (document.match(regex_heart)) {
        var range = trixEditor.getSelectedRange();
        $trix.val(document.replace(regex_heart, '&#9829;'));
        trixEditor.setSelectedRange(range[0] - 1);
      } else if (document.match(regex_ndash)) {
        var range = trixEditor.getSelectedRange();
        $trix.val(document.replace(regex_ndash, '&ndash;'));
        trixEditor.setSelectedRange(range[0] - 1);
      }
    });
  }

});
