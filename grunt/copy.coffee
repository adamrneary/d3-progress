module.exports =
  img:
    expand: true
    cwd: "docs/img"
    src: ['**/*.{png,jpg,gif}']
    dest: "dist/assets/img"
  css:
    expand: true
    cwd: "docs/css"
    src: ['**/*.css']
    dest: "dist/assets/css"
  js:
    expand: true
    cwd: "docs/js"
    src: ['**/*.js']
    dest: "dist/assets/js"
