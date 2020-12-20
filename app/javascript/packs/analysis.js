for (var num = 0; num < 1; num++) {
var ctx = document.getElementById("RaderChart");
// var attack = document.getElementsByClassName("attack_i")[num].textContent;
// var defense = document.getElementsByClassName("defensive_i")[num].textContent;
// var pitch = document.getElementsByClassName("pitcher_i")[num].textContent;
// var total = document.getElementsByClassName("comprehensive_i")[num].textContent;
// var expec = document.getElementsByClassName("expectations_i")[num].textContent;
var RaderChart = new Chart(ctx,{
  type: 'radar',
  data: {
    labels: ["攻撃力","守備力","投手力","総合力","期待度"],
    datasets: [{
      label: '戦力',
      data: gon.data,
      backgroundColor: 'RGBA(225,95,150, 0.5)',
      borderColor: 'RGBA(225,95,150, 1)',
      borderWidth: 1,
      pointBackgroundColor: 'RGB(46,106,177)'
    }]
  },
  options: {
    title: {
      display: true,
    },
    layout: {
      padding: {
        left: 10,
      }
    },
    scale: {
      ticks: {
        suggestedMin: 0,
        suggestedMax: 5,
        stepSize: 1,
        callback: function(value,index,values){
          return value
        }
      }
    }
  }
});
}