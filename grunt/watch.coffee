module.exports =
  copy_img:
    tasks: ["newer:copy:img"]
    files: ['docs/img/**/*.{png,jpg,gif}']

  sass:
    tasks: ["newer:sass:compile"]
    files: ["docs/css/**/*.{scss,sass}"]

  coffee_source:
    tasks: ["newer:coffee:source"]
    files: ["d3-progress.coffee"]

  coffee_docs:
    tasks: ["newer:coffee:docs"]
    files: ["docs/js/demo.coffee"]

  assemble:
    tasks: ["assemble"]
    files: [
      "docs/content/**/*"
      "docs/templates/**/*"
      "docs/data/**/*"
    ]

  livereload:
    options:
      livereload: true

    files: [
      "tmp/**/*"
    ]