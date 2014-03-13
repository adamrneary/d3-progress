(function() {
  var D3Progress, d3;

  if (typeof exports !== "undefined" && exports !== null) {
    D3Progress = exports;
  } else {
    D3Progress = this.D3Progress = {};
  }

  D3Progress.VERSION = '0.0.1';

  d3 = !d3 && (typeof require !== "undefined" && require !== null) ? require('d3').d3 : this.d3;

  D3Progress.Meter = (function() {
    function Meter(args) {
      if (args == null) {
        args = {};
      }
      this.existingPercentage = 0;
      this.selector = args.selector || '#loader';
      this.width = args.width || 960;
      this.height = args.height || 500;
      this.innerRadius = args.innerRadius || 180;
      this.outerRadius = args.outerRadius || 240;
      this.formatPercent = d3.format(args.formatPercent || ".0%");
      this._build();
    }

    Meter.prototype._build = function() {
      this.arc = d3.svg.arc().startAngle(this.existingPercentage).innerRadius(this.innerRadius).outerRadius(this.outerRadius);
      this.svg = d3.select(this.selector).attr("class", "loader-wrapper").html('').append('div').attr("class", "loader-content").append('div').attr("class", "loader-body").append("svg").attr("width", this.width).attr("height", this.height).append("g").attr("transform", "translate(" + (this.width / 2) + "," + (this.height / 2) + ")");
      this.meter = this.svg.append("g").attr("class", "progress-meter");
      this.meter.append("path").attr("class", "background").attr("d", this.arc.endAngle(2 * Math.PI));
      this.foreground = this.meter.append("path").attr("class", "foreground");
      this.status = this.meter.append("text").attr("class", "status").attr("text-anchor", "middle").text('Getting started…').attr("dy", "-4em");
      return this.percentage = this.meter.append("text").attr("class", "percentage").attr("text-anchor", "middle").text(this.formatPercent(this.existingPercentage)).attr("dy", "2.5em");
    };

    Meter.prototype.updateProgress = function(percentage, status) {
      var i,
        _this = this;
      this.status.text(status);
      this.percentage.text(this.formatPercent(percentage));
      i = d3.interpolate(this.existingPercentage, percentage);
      d3.transition().duration(500).tween("progress", function() {
        return function(t) {
          var progress;
          progress = i(t);
          return _this.foreground.attr("d", _this.arc.endAngle(2 * Math.PI * percentage));
        };
      });
      return this.existingPercentage = percentage;
    };

    Meter.prototype.kill = function(callback) {
      this.updateProgress(1, 'Complete.');
      this.status.text('');
      this.percentage.text('');
      this.meter.transition().delay(250).attr("transform", "scale(0)");
      if (callback(typeof callback === 'function')) {
        return callback();
      }
    };

    return Meter;

  })();

}).call(this);
