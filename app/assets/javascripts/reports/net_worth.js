$.get("/report/net_worth.json",function(barChartData){
  var myLine = new Chart(document.getElementById("canvas").getContext("2d")).Bar(barChartData);
});
