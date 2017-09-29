$.getJSON("data/spell-in-men-sent", function(data) {
  //construct our data to render it as a chart
  var spellNames = []
  var spellSentAVG = []

  //p1 encompases ranges --> [-1, -.5)
  var p1 = 0
  //p2 encompases ranges --> [-.5, 0)
  var p2 = 0
  //p3 encompases ranges --> (0, 0.5)
  var p3 = 0
  //p4 encompases ranges --> [0.5, 1]
  var p4 = 0
  //p5 for 0
  var pZero = 0


  //calculate each grouping
  data.forEach(function(d) {
    for (var key in d) {
      if (d.hasOwnProperty(key)) {
        //check value and increment count of our partition variables
        var val = d[key]

        if (val < -.5) {
          p1++;
        }
        else if (val >= -.5 && val < 0) {
          p2++;
        }
        else if (val === 0) {
          pZero++;
        }
        else if (val > 0 && val < .5) {
          p3++;
        }
        else {
          p4++
        }
      }
    }
  });

  var ctx = document.getElementById("data_viz");
  var chart = new Chart(ctx, {
    type: 'pie',
    data: {
      datasets: [{
        data: [
          p1,
          p2,
          pZero,
          p3,
          p4,
        ],
        backgroundColor: [
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 159, 64, 0.2)',
          'rgba(75, 192, 192, 0.2)',
          'rgba(54, 162, 235, 0.2)',
          'rgba(153, 102, 255, 0.2)'
        ],
        borderColor: [
            'rgba(255,99,132,1)',
            'rgba(255, 159, 64, 1)',
            'rgba(75, 192, 192, 1)',
            'rgba(54, 162, 235, 1)',
            'rgba(153, 102, 255, 1)'
        ],
        label: 'Dataset 1'
      }],
      labels: [
        "[-1, -.5) Negative",
        "[-.5, 0) Mildly Negative",
        "0 Neutral",
        "(0, .5) Mildly Positive",
        "[.5, 1] Positive"
      ]
    },
    options: {
      responsive: true,
      legend: {
        position: 'bottom',
      },
      title: {
        display: true,
        text: 'Average Sentiment Per Spell By Mention'
      },
      animation: {
        animateScale: true,
        animateRotate: true
      }
    }
  });
});
