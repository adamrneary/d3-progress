module.exports =
  pages:
    options:
      flatten: true
      assets: "tmp/assets"
      layout: "docs/templates/layouts/default.hbs"
      partials: "docs/templates/partials/*.hbs"
      data: "docs/data/*.{json,yml}"
    files:
      "tmp/": ["docs/templates/pages/*.hbs"]