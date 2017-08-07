$(document).on('turbolinks:load', function() {
  //Toggle display of BUDGET div depending of range slider
  var allBudgetDiv = $('.budget-infos');
  var budgetSlider  = $('#budget-range');
  allBudgetDiv.hide();
  budgetSlider.on('change', function(){
    allBudgetDiv.hide();
    var divToShow = $('#budget' + $(this).val())
    divToShow.show();
  });
  //Toggle display of RYTHME div depending of range slider
  var allRythmeDiv = $('.rythme-infos');
  var rythmeSlider  = $('#rythme-range');
  allRythmeDiv.hide();
  rythmeSlider.on('change', function(){
    allRythmeDiv.hide();
    var divToShow = $('#rythme' + $(this).val())
    divToShow.show();
  });




}); //$ready function ending
