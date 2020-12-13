var ctx = document.getElementById("PieChart");
var 
var PieChart = new Chart(ctx, {
  type: 'pie',
  data: {
    labels: ["e","f"],
    datasets: [{
      backgroundColor: [
        "#FF0000",
        "#33CCFF",
      ],
      data: [100,20]
    }]
  },
  options: {
    title: {
      display: true,
      text: '勝利確率'
    }
  }
});