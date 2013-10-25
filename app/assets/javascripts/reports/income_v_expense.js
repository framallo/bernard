$.get("/report/income_v_expense.json",function(barChartData){
  var myLine = new Chart(document.getElementById("canvas").getContext("2d")).Bar(barChartData);
});
