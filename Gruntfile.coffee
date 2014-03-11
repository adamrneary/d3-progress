# http://www.thomasboyt.com/2013/09/01/maintainable-grunt.html
# http://www.html5rocks.com/en/tutorials/tooling/supercharging-your-gruntfile/
module.exports = (grunt) ->

  # What gets measured gets managed
  require("time-grunt") grunt

  # Load config from grunt dir
  require("load-grunt-config") grunt,

    # package.json is made available automatically as `package`
    config:
      # Add the process env to config to allow for run time magicsauce
      env: process.env

    # Automatically load grunt tasks and assemble
    loadGruntTasks:
      pattern: [
        "grunt-*"
        "assemble"
      ]