var ctx = document.getElementById("myBarChart");
var myBarChart = new Chart(ctx, {
  type: 'horizontalBar',
  data: {
    labels: [gon.a[0],gon.a[1],gon.a[2],gon.a[3],gon.a[4]],
    datasets: [
      {
        data: [gon.b[0],gon.b[1],gon.b[2],gon.b[3],gon.b[4]],
        backgroundColor: ["red", "yellow", "lime", "aqua", "orange"]
      }
    ]
  },
  options: {
    title: {
      display: true,
      text: '上位5チーム',
      fontSize: 20,
      fontColor: '#000'
    },
    legend: {
      display: false
   },
    scales: {
      yAxes: [{
        ticks: {
          callback: function(value, index, values){
              return  value
          }
        }
      }],
      xAxes: [{
        ticks: {
          suggestedMax: 100,
          suggestedMin: 0,
          stepSize: 10,
        }
      }],
    },
  }
});