// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//= require Chart


$.get("/reports/income_v_expense.json",function(barChartData){
  console.log(barChartData);
  var myLine = new Chart(document.getElementById("canvas").getContext("2d")).Bar(barChartData);
});
