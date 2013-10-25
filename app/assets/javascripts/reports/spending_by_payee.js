$.get("/report/spending_by_payee.json",function(barChartData){
  var myLine = new Chart(document.getElementById("canvas").getContext("2d")).Bar(barChartData);
});
