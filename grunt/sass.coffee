module.exports =
  compile:
    files: [
      expand: true
      cwd: "docs/css"
      src: [
        "**/*.{scss,sass}"
        "!**/_*.{scss,sass}"
      ]
      dest: "tmp/assets/css/"
      ext: ".css"
    ]