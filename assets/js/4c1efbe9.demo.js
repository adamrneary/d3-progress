(function() {
  window.resetMeter = function() {
    var meter;
    d3.select("#alert").html('');
    meter = new D3Progress.Meter({
      width: 300,
      height: 300,
      innerRadius: 52,
      outerRadius: 63
    });
    meter.updateProgress(.1, 'Step 1');
    return setTimeout((function() {
      meter.updateProgress(.2, 'Step 2');
      return setTimeout((function() {
        var i, timer;
        i = 0;
        timer = setInterval(function() {
          var percentage;
          percentage = 0.2 + 0.6 * i++ / 300;
          meter.updateProgress(percentage, 'Something granular');
          if (i > 300) {
            return clearInterval(timer);
          }
        }, 5);
        return setTimeout((function() {
          meter.updateProgress(.9, 'Step 4');
          return setTimeout((function() {
            return meter.kill(fireAlert);
          }), 2000);
        }), 2000);
      }), 2000);
    }), 2000);
  };

  window.fireAlert = function() {
    return d3.select("#alert").html("<div class=\"alert alert-success\"><a class=\"close\" data-dismiss=\"alert\">×</a><h4>Done!</h4><p>Use whatever callback makes sense.</p></div>");
  };

  resetMeter();

}).call(this);
