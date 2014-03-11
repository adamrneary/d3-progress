window.resetMeter = ->
  d3.select("#alert").html ''
  meter = new D3Progress.Meter
    width: 300
    height: 300
    innerRadius: 52
    outerRadius: 63
  meter.updateProgress .1, 'Step 1'
  setTimeout (->
    meter.updateProgress .2, 'Step 2'
    setTimeout (->
      i = 0
      timer = setInterval(->
        percentage = 0.2 + 0.6 * i++ / 300
        meter.updateProgress percentage, 'Something granular'
        clearInterval(timer) if i > 300
      , 5)
      setTimeout (->
        meter.updateProgress .9, 'Step 4'
        setTimeout (->
          meter.kill(fireAlert)
        ), 2000
      ), 2000
    ), 2000
  ), 2000

window.fireAlert = ->
  d3.select("#alert").html "<div class=\"alert alert-success\"><a class=\"close\" data-dismiss=\"alert\">×</a><h4>Done!</h4><p>Use whatever callback makes sense.</p></div>"

resetMeter()