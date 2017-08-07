$(document).on('turbolinks:load', function() {
  //Function for commercial banner:  request a random JSON theme at /commercial and change
  //banner content
  $('.download-section').each(function( index ) {
    if ($(this).data('ajax') == true ) {
      $.ajax({
        url: "/commercial",
        context: $(this),
        datatype: "json",
      }).done(function(response) {
        var overlay = this.find($('.image-overlay'));
        var title   = this.find($('.theme-title'));
        var descr   = this.find($('.theme-descr'));
        overlay.css("background", response['image']);
        overlay.css('position', 'absolute' );
        overlay.css('background-size', 'cover' );
        overlay.css('background-position', 'center center' );
        overlay.css('background-repeat', 'no-repeat' );
        title.html(response['name']);
        descr.html(response['descr']);
      });
    };
  });
}); //$ready function ending
