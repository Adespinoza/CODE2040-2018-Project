$.getJSON("data/book-sent", function(data) {
  //construct our data to render it as a chart
  var bookNames = []
  var avgSent = []

  //iterate through array
  data.forEach(function(book_data) {
    for (var key in book_data) {
      if (book_data.hasOwnProperty(key)) {
        bookNames.push(key.substring(3));
        avgSent.push(book_data[key]);
      }
    }
  });

  var colors = [
      'rgba(255, 99, 132, 0.2)',
      'rgba(54, 162, 235, 0.2)',
      'rgba(255, 206, 86, 0.2)',
      'rgba(75, 192, 192, 0.2)',
      'rgba(153, 102, 255, 0.2)',
      'rgba(255, 159, 64, 0.2)'
  ]

  var borderColors = [
      'rgba(255,99,132,1)',
      'rgba(54, 162, 235, 1)',
      'rgba(255, 206, 86, 1)',
      'rgba(75, 192, 192, 1)',
      'rgba(153, 102, 255, 1)',
      'rgba(255, 159, 64, 1)'
  ]

  var colorsForData = []
  var bordersForData = []

  for (var i = 0; i < avgSent.length; i++) {
    colorsForData[i] = colors[i % colors.length]
    bordersForData[i] = borderColors[i % borderColors.length]
  }
  var ctx = document.getElementById("data_viz");
  var myChart = new Chart(ctx, {
      type: 'bar',
      data: {
          labels: bookNames,
          datasets: [{
              label: 'Spell Frequency',
              data: avgSent,
              backgroundColor: colorsForData,
              borderColor: bordersForData,
              borderWidth: 1
          }]
      },
      options: {
          scales: {
              yAxes: [{
                  ticks: {
                      beginAtZero:true
                  }
              }]
          },
          title: {
            display: true,
            text: 'Spells Per Book'
          },
          legend : {
            position: 'bottom'
          }
      }
  });
});
