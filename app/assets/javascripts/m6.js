$.getJSON("data/pos-sent", function(data) {
  var pos = []
  var sent = []

  //sort the data array by position
  data.sort(function(a, b) {
    var aV = parseInt(Object.keys(a)[0])
    var bV = parseInt(Object.keys(b)[0])
    if (aV === bV) { return 0; }
    return aV > bV ? 1 : -1;
  });


  data.forEach(function(pos_sent_data) {
    for (var key in pos_sent_data) {
      if (pos_sent_data.hasOwnProperty(key)) {
        pos.push(parseInt(key));
        sent.push(pos_sent_data[key]);
      }
    }
  });

  console.log(data)
  console.log(pos);
  console.log(sent);

  var ctx = document.getElementById("data_viz");
  var myChart = new Chart(ctx, {
  type: 'line',
  data: {
    labels: pos,
    datasets: [{
        data: sent,
        label: "Sentiment Score",
        borderColor: 'rgba(75, 192, 192, 0.2)',
        backgroundColor:'rgba(75, 192, 192, 1)',
        fill: false,
        showLine: false
      }
    ]
  },
  options: {
    title: {
      display: true,
      text: 'Sentiment of Mention Relative to Position'
    }
  }
});


});
