if exports?
  D3Progress = exports
else
  D3Progress = @D3Progress = {}

D3Progress.VERSION = '0.0.1'
d3 = if not d3 and require? then require('d3').d3 else @d3

class D3Progress.Meter

  constructor: (args = {}) ->
    @selector = args.selector or '#loader'
    @width = args.width or 960
    @height = args.height or 500
    @innerRadius = args.innerRadius or 180
    @outerRadius = args.outerRadius or 240
    @formatPercent = d3.format(args.formatPercent or ".0%")
    @existingPercentage = 0
    @_build()

  _build: ->
    # Define a d3 arc that we can use below
    @arc = d3.svg
      .arc()
      .startAngle(@existingPercentage)
      .innerRadius(@innerRadius)
      .outerRadius(@outerRadius)

    # Create the SVG object and canvas onto which we will build our meter
    @svg = d3.select(@selector)
        .attr("class", "loader-wrapper")
        .html('')
      .append('div')
        .attr("class", "loader-content")
      .append('div')
        .attr("class", "loader-body")
      .append("svg")
        .attr("width", @width)
        .attr("height", @height)
      .append("g")
        .attr("transform", "translate(#{@width / 2},#{@height / 2})")

    # Append the meter canvas itself (allows specific styles for that class)
    @meter = @svg.append("g")
      .attr("class", "progress-meter")

    # Create a path for the meter (that will not change) classed "background"
    @meter.append("path")
      .attr("class", "background")
      .attr "d", @arc.endAngle(2 * Math.PI)

    # Create a path for the meter (that will change) classed "foreground"
    @foreground = @meter.append("path")
      .attr("class", "foreground")

    # Add text for the status message
    @status = @meter.append("text")
      .attr("class", "status")
      .attr("text-anchor", "middle")
      .text('Getting started…')
      .attr("dy", "-4em")

    # Add text for the percentage
    @percentage = @meter.append("text")
      .attr("class", "percentage")
      .attr("text-anchor", "middle")
      .text(@formatPercent(@existingPercentage))
      .attr("dy", "2.5em")

  # Handle progress event by updating text and transitioning the arc
  updateProgress: (percentage, status) ->
    @status.text status
    @percentage.text @formatPercent(percentage)

    i = d3.interpolate(@existingPercentage, percentage)
    d3.transition().duration(500).tween "progress", =>
      (t) =>
        progress = i(t)
        @foreground.attr "d", @arc.endAngle(2 * Math.PI * percentage)

    @existingPercentage = percentage

  kill: (callback) ->
    @updateProgress(1, 'Complete.')
    @status.text ''
    @percentage.text ''

    # Once complete, kill the progress meter entirely by shrinking to nothing
    @meter.transition()
      .delay(250)
      .attr "transform", "scale(0)"

    callback() if callback typeof callback is 'function'