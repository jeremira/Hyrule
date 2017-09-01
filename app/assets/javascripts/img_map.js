$(document).on('turbolinks:load', function() {


      //$('.download-section').each(function( index ) {
      //change #map to .map and do for each if present


    var livret_id = $('#map').data('livret');
    var map_file_name = $('#map').data('map');
    console.log("Ajax map path ...");
    $.ajax({
           url:'/mappath',
           type:'GET',
           dataType:'json',
           data:{
               livret: livret_id,
               map: map_file_name
           },
           success:function(data){
             console.log("Ajax map pather done : " + data['path'] );
              $('#map').append("<img src='" + data['path'] + "' class='img-responsive'></img>");
              return false
           },
           error:function(data){
               console.log('error : no answer from map_path');
               console.log(data);
               return false
           }
        });


}); //$ready function ending
