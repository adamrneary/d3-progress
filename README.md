# D3-Progress

> **A simple, reusable progress component**
> For those times when a horizontal progress meter just won't cut it.

This is a simple abstraction of [http://bl.ocks.org/mbostock/3750941](http://bl.ocks.org/mbostock/3750941) that is also useful in thinking about how to build reusable components from [D3](http://d3js.org/) examples.

## API Documentation
### Javascript API

#### Constructor

```javascript
meter = new D3Progress.Meter(attributes)
```

The following attributes can be set on initialization:

* **selector**: A valid d3 selector (similar to css selectors) that exists in the DOM. _Note:_ The meter automatically clears the html for the selector on initialization.
* **width and height**: These are the constraints for the svg object itself and will clip long status text.
* **innerRadius and outerRadius**: These define the track and animated arc, which can be as thick or thin as you like.
* **formatPercent**: A valid d3 format to be applied to the percentage text below the meter.

The meter is build on initialization. A number of our libraries wait until `render()` is called, but this is not the case for something as simple as the progress meter.

#### Methods

```javascript
meter.updateProgress(percentage, status)
```

Updates the status text to the message provided, then animates the meter along the background track to the percentage provided.

This method can be bound to subscribed progress events, or it can be fired when specific steps in a process have been completed.

```javascript
meter.kill(callback)
```

This function should be called once the progress is entirely complete. The function removes the progress meter itself and then optionally calls a provided callback function.

Since we use the progress meter for long-running initial app load steps, the callback function then initializes the single page app and hands over control.

### CSS API

```scss
// The outer-most class, which can impact overall positioning
.loader-content {
  // …

  // Appended inside the loader-content div
  .loader-body {
    // …

    // The SVG object is an easy place to add background images & custom styles
    svg {
      // …

      .progress-meter {
        // …
      }

      // The "track" on which the progress arc is rendered
      .background {
        // …
      }

      // The progress arc itself
      .foreground {
        // …
      }

      // Applies to percentage and status alike
      text {
        // …
      }

      // The status text appears above the meter
      .status {
        // …
      }

      // The percentage text appears below the meter
      .percentage {
        // …
      }
    }
  }
}
```