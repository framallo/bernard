$.get("/report/spending_by_category.json",function(barChartData){
  var myLine = new Chart(document.getElementById("canvas").getContext("2d")).Bar(barChartData);
});
