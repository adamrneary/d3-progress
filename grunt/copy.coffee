module.exports =
  img:
    expand: true
    cwd: "docs/img"
    src: ['**/*.{png,jpg,gif}']
    dest: "tmp/assets/img"
  css:
    expand: true
    cwd: "docs/css"
    src: ['**/*.css']
    dest: "tmp/assets/css"
  js:
    expand: true
    cwd: "docs/js"
    src: ['**/*.js']
    dest: "tmp/assets/js"
  lib:
    src: "tmp/assets/js/d3-progress.js"
    dest: "d3-progress.js"
  dist:
    files: [
      expand: true
      cwd: "tmp"
      src: [
        # Start with everything
        "**"

        # Exclude those handled by concat
        "!vendor/**/*"
        "!**/*.{css,js}"

        # Add back in those not handled by concat
        "assets/css/demo.css"
        "assets/js/d3-progress.js"
        "assets/js/demo.js"

        # No source maps
        "!**/*.map"

      ]
      filter: "isFile"
      dest: "dist/"
    ]