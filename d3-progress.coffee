# This is a simple abstraction of
# [http://bl.ocks.org/mbostock/3750941](http://bl.ocks.org/mbostock/3750941)
# that is also useful in thinking about how to build reusable components from
# [D3](http://d3js.org/) examples.
#
# ### Initial Setup

# The top-level namespace. All public D3Progress classes and modules will
# be attached to this. Exported for both CommonJS and the browser.
if exports?
  D3Progress = exports
else
  D3Progress = @D3Progress = {}

# _Note:_ Keep this in sync with package.json, componenet.json, and bower.json
D3Progress.VERSION = '0.0.1'

# Require d3 if we're on the server and it's not already present
d3 = if not d3 and require? then require('d3').d3 else @d3

# D3Progress.Meter
# ----------------
class D3Progress.Meter

  constructor: (args = {}) ->
    @existingPercentage = 0

    # A valid d3 selector (similar to css selectors) that exists in the DOM. To
    # avoid having to pass a selector as an argument, just use a target div
    # with `id="loader"`
    @selector = args.selector or '#loader'

    # _Note:_ The meter automatically clears the html for the selector on
    # initialization.

    # Width and height are typically passed as arguments, but we provide
    # defaults if not.
    @width = args.width or 960
    @height = args.height or 500

    # The dimensions of the progress arc should be set in coordination with the
    # overall progress meter's dimensions.
    @innerRadius = args.innerRadius or 180
    @outerRadius = args.outerRadius or 240

    # As required, change the formatting of the percent text per the locale.
    @formatPercent = d3.format(args.formatPercent or ".0%")

    @_build()

  # ### Building the meter

  # The meter is build on initialization. A number of our libraries wait
  # until `render()` is called, but this is not the case for something as
  # simple as the progress meter.
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

  # ### Updating progress

  # Update the status text to the message provided, then animate the meter
  # along the background track to the percentage provided.
  #
  # This method can be bound to subscribed progress events, or it can be
  # fired when specific steps in a process have been completed.
  updateProgress: (percentage, status) ->
    @status.text status
    @percentage.text @formatPercent(percentage)

    i = d3.interpolate(@existingPercentage, percentage)
    d3.transition().duration(500).tween "progress", =>
      (t) =>
        progress = i(t)
        @foreground.attr "d", @arc.endAngle(2 * Math.PI * percentage)

    @existingPercentage = percentage

  # ### Cleaning up and moving on

  # This function should be called once the progress is entirely complete.
  # The function removes the progress meter itself and then optionally calls
  # a provided callback function.
  #
  # Since we use the progress meter for long-running initial app load steps,
  # the callback function then initializes the single page app and hands over
  # control.
  kill: (callback) ->
    @updateProgress(1, 'Complete.')
    @status.text ''
    @percentage.text ''

    # Once complete, kill the progress meter entirely by shrinking to nothing
    @meter.transition()
      .delay(250)
      .attr "transform", "scale(0)"

    callback() if callback typeof callback is 'function'