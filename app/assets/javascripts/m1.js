
//retrieve data from backend --> make an API call
$.getJSON( "/data/spell-freq", function(data) {


  //construct our data to render it as a chart
  var spellNames = []
  var spellFrequency = []

  data.sort(function(a, b) {
    var aV = a[Object.keys(a)[0]]
    var bV = b[Object.keys(b)[0]]
    if (aV === bV) { return 0; }
    return aV > bV ? 1 : -1;
  })

  //get top 50 percent of data
  data = data.slice(data.length - 15, data.length)

  //iterate through array
  data.forEach(function(spell_data) {
    for (var key in spell_data) {
      if (spell_data.hasOwnProperty(key)) {
        spellNames.push(key);
        spellFrequency.push(spell_data[key]);
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

  for (var i = 0; i < spellFrequency.length; i++) {
    colorsForData[i] = colors[i % colors.length]
    bordersForData[i] = borderColors[i % borderColors.length]
  }
  var ctx = document.getElementById("data_viz");
  var myChart = new Chart(ctx, {
      type: 'bar',
      data: {
          labels: spellNames,
          datasets: [{
              label: 'Spell Frequency',
              data: spellFrequency,
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
            text: 'Top 15 Spells'
          }
      }
  });
});
