var ctx = document.getElementById("myBarChart");
var myBarChart = new Chart(ctx, {
  type: 'horizontalBar',
  data: {
    // labels: ['結果'],
    // datasets: [
    //   {
    //     label: gon.aa[0],
    //     data: [gon.bb[0]],
    //     backgroundColor: "rgba(219,39,91,0.5)"
    //   },{
    //     label: gon.aa[1],
    //     data: [gon.bb[1]],
    //     backgroundColor: "rgba(130,201,169,0.5)"
    //   },{
    //     label: gon.aa[2],
    //     data: [gon.bb[2]],
    //     backgroundColor: "rgba(255,183,76,0.5)"
    //   }
    // ]
    labels: [gon.aa[0],gon.aa[1],gon.aa[2]],
    datasets: [
      {
        data: [gon.bb[0],gon.bb[1],gon.bb[2]],
        backgroundColor: ["red", "yellow", "green", "blue", "purple"]
      }
    ]
  },
  options: {
    title: {
      display: true,
      text: '投票数'
    },
    scales: {
      yAxes: [{
        ticks: {
          suggestedMax: 100,
          suggestedMin: 0,
          stepSize: 10,
          callback: function(value, index, values){
            return  value
          }
        }
      }],
      xAxes: [{
        ticks: {
          min: 0
        }
      }
    ],
    },
  }
});