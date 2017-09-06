$(document).on('turbolinks:load', function() {


  $( ".map" ).each(function( index ) {
    console.log("Mapping")
    var livret_id = $(this).data('livret');
    var map_file_name = $(this).data('map');
    console.log(livret_id);
    console.log(map_file_name);
    $.ajax({
           url:'/mappath',
           type:'GET',
           dataType:'json',
           context: $(this),
           data:{
               livret: livret_id,
               map: map_file_name
           },
           success:function(data){
              this.append("<img src='" + data['path'] + "' class='img-responsive img-center'></img>");
              return false
           },
           error:function(data){
               console.log('error : no answer from map_path');
               console.log(data);
               return false
           }
        });
  });

}); //$ready function ending
