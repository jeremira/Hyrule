$(document).on('turbolinks:load', function() {

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
           console.log("Ajax map pather done : " + data );
            $('#map').append("<img src='" + data + "'></img>");
         },
         error:function(data){
             console.log('error : no answer from map_path');
         }
      });
}); //$ready function ending
