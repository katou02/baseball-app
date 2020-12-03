for (var num = 0; num < 500; num++) {
  var ctx = document.getElementsByClassName("RaderChart")[num];
  var attack = document.getElementsByClassName("avg-attack")[num].textContent;
  var defense = document.getElementsByClassName("avg-defense")[num].textContent;
  var pitch = document.getElementsByClassName("avg-pitch")[num].textContent;
  var total = document.getElementsByClassName("avg-total")[num].textContent;
  var expec = document.getElementsByClassName("avg-expec")[num].textContent;
  var RaderChart = new Chart(ctx,{
    type: 'radar',
    data: {
      labels: ["攻撃力","守備力","投手力","総合力","期待度"],
      datasets: [{
        label: '戦力',
        data: [attack,defense,pitch,total,expec],
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
          left: 550,
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