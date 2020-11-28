for (var num = 0; num < 1; num++) {
var ctx = document.getElementById("PieChart");
var win = document.getElementsByClassName("win")[num].textContent
var lose = document.getElementsByClassName("lose")[num].textContent
var winnum = document.getElementsByClassName("win-rate")[num].textContent
var PieChart = new Chart(ctx, {
  type: 'pie',
  data: {
    labels: [win,lose],
    datasets: [{
      backgroundColor: [
        "#DC3545",
        "#0DCAF0",
      ],
      data: [winnum,100-winnum]
    }]
  },
  options: {
    title: {
      display: true,
      text: '勝利確率'
    }
  }
});
}