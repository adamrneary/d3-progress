module.exports =
  pages:
    options:
      flatten: true
      assets: "dist/assets"
      layout: "docs/templates/layouts/default.hbs"
      partials: "docs/templates/partials/*.hbs"
      data: "docs/data/*.{json,yml}"
    files:
      "dist/": ["docs/templates/pages/*.hbs"]