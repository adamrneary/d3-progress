module.exports =
  # Note: We follow this more prescriptive approach because bower loads to the
  # vendor directory, and we do not want vendor/ cleaned
  tmp: [
    'tmp/assets'
    'tmp/**/*.html'
  ]
  dist: [
    'dist/'
  ]
