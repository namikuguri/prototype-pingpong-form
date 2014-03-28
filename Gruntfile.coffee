module.exports = (grunt) ->
  'use strict'

  # Project configuration:
  grunt.initConfig

    # Metadata:
    pkg: grunt.file.readJSON("package.json")
    banner: "/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - " + "<%= grunt.template.today(\"yyyy-mm-dd\") %>\n" + "<%= pkg.homepage ? \"* \" + pkg.homepage + \"\\n\" : \"\" %>" + "* Copyright (c) <%= grunt.template.today(\"yyyy\") %> <%= pkg.author.name %>;" + " Licensed <%= _.pluck(pkg.licenses, \"type\").join(\", \") %> */\n"

    # Task configuration:
    # Reload live in the browser
    connect:
      site:
        options:
          port: 8080
          base: './'
          open: 'http://localhost:8080/'

    # Compile Slim to HTML
    slim:
      index:
        files: [
          expand: true
          cwd: "src/"
          src: ["*.slim"]
          dest: "./"
          ext: ".html"
        ]
      signup:
        files: [
          expand: true
          cwd: "src/demo/signup/"
          src: ["*.slim"]
          dest: "demo/signup/"
          ext: ".html"
        ]

    # Compile SCSS to CSS
    sass:
      index:
        files: [
          expand: true
          cwd: "src/assets/stylesheets/"
          src: ["**/*.scss"]
          dest: "assets/stylesheets/"
          ext: ".css"
        ]
      signup:
        files: [
          expand: true
          cwd: "src/demo/signup/assets/stylesheets/"
          src: ["**/*.scss"]
          dest: "demo/signup/assets/stylesheets/"
          ext: ".css"
        ]

    # Monitoring files, and Do browser live reload
    watch:
      slim:
        files: ["src/{,*/}*.slim", "src/demo/signup/*.slim"]
        tasks: ["slim"]
      sass:
          files: ["src/assets/stylesheets/**/*.scss", "src/demo/signup/assets/stylesheets/**/*.scss"]
          tasks: ["sass"]
      options:
        livereload: true

  # Setting Load & Register task:
  grunt.registerTask "default", [], ->
    grunt.loadNpmTasks "grunt-contrib-connect"
    grunt.loadNpmTasks "grunt-contrib-watch"
    grunt.task.run "connect", "watch"

  grunt.registerTask "slim", [], ->
    grunt.loadNpmTasks "grunt-slim"
    grunt.task.run "slim"

  grunt.registerTask "sass", [], ->
    grunt.loadNpmTasks "grunt-contrib-sass"
    grunt.task.run "sass"
