//make navigation responsive when the screen shrinks
$( document ).ready(function() {
  var windowWidth = $(window).width();

  if (windowWidth <= 769) {
    $(document).ready(function() {

      $("#m1").text("1");
      $("#m2").text("2");
      $("#m3").text("3");
      $("#m4").text("4");
      $("#m5").text("5");
      $("#m6").text("6");
    });
  } else {
    $(document).ready(function() {

      $("#m1").text("mod 1");
      $("#m2").text("mod 2");
      $("#m3").text("mod 3");
      $("#m4").text("mod 4");
      $("#m5").text("mod 5");
      $("#m6").text("mod 6");
    });
  }
});

$(window).on('resize', function(event) {
  var windowWidth = $(window).width();

  if (windowWidth <= 769) {
    $(document).ready(function() {

      $("#m1").text("1");
      $("#m2").text("2");
      $("#m3").text("3");
      $("#m4").text("4");
      $("#m5").text("5");
      $("#m6").text("6");
    });
  } else {
    $(document).ready(function() {

      $("#m1").text("mod 1");
      $("#m2").text("mod 2");
      $("#m3").text("mod 3");
      $("#m4").text("mod 4");
      $("#m5").text("mod 5");
      $("#m6").text("mod 6");
    });
  }
});
