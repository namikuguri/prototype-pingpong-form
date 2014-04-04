module.exports = (grunt) ->
  'use strict'

  # Project configuration:
  grunt.initConfig

    # Metadata:
    pkg: grunt.file.readJSON("package.json")
    banner: "/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - " + "<%= grunt.template.today(\"yyyy-mm-dd\") %>\n" + "<%= pkg.homepage ? \"* \" + pkg.homepage + \"\\n\" : \"\" %>" + "* Copyright (c) <%= grunt.template.today(\"yyyy\") %> <%= pkg.author.name %>;" + " Licensed <%= _.pluck(pkg.licenses, \"type\").join(\", \") %> */\n"

    # Task configuration:

    # `grunt` task
    ## Reload live in the browser
    connect:
      site:
        options:
          port: 8080
          base: './'
          open: 'http://localhost:8080/'

    ## Compile Slim to HTML
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

    ## Compile SCSS to CSS
    sass:
      index:
        files: [
          expand: true
          cwd: "src/stylesheets/"
          src: ["**/*.scss"]
          dest: "stylesheets/"
          ext: ".css"
        ]
      signup:
        files: [
          expand: true
          cwd: "src/demo/signup/stylesheets/"
          src: ["**/*.scss"]
          dest: "demo/signup/stylesheets/"
          ext: ".css"
        ]

    ## Minify Javacscipt
    uglify:
      index:
        files: [
          expand: true
          cwd: "src/javascripts/"
          src: ["*.js"]
          dest: "javascripts/"
          ext: ".js"
        ]
      signup:
        files: [
          expand: true
          cwd: "src/demo/signup/javascripts/"
          src: ["*.js"]
          dest: "demo/signup/javascripts/"
          ext: ".js"
        ]

    ## Monitoring files, and Do browser live reload
    watch:
      slim:
        files: ["src/{,*/}*.slim", "src/demo/signup/*.slim"]
        tasks: ["slim"]
      sass:
          files: ["src/stylesheets/**/*.scss", "src/demo/signup/stylesheets/**/*.scss"]
          tasks: ["sass"]
      uflify:
          files: ["src/javascripts/**/*.js", "src/demo/signup/javascripts/**/*.js"]
          tasks: ["uglify"]
      options:
        livereload: true

    # `grunt deploy` task
    ## Lint HTML
    htmllint:
      index: "*.html"
      signup: "demo/signup/*.html"

    ## Lint CSS
    csslint:
      options:
        "box-model": false
        "fallback-colors": false
      index:
        src: ["stylesheets/**/*.css"]
      signup:
        src: ["demo/signup/stylesheets/**/*.css"]

    ## Parse CSS and add vendor-prefixed CSS properties
     autoprefixer:
       index:
         options:
           browsers: ["last 2 version", "ie >= 8"]
         src: ["stylesheets/**/*.css"]
       signup:
         options:
           browsers: ["last 2 version", "ie >= 8"]
         src: ["demo/signup/stylesheets/**/*.css"]

    # `grunt doc` task
    ## Make Style Guide ( StyleDocco )
    styleguide:
      dist:
        options:
          name: "Style Guide"
          framework:
            name: "styledocco"
            options:
              preprocessor: "sass"
          template:
            include: ["vendor/font-awesome/css/font-awesome.min.css",
                      "vendor/font-awesome/fonts/fontawesome-webfont.eot",
                      "vendor/font-awesome/fonts/fontawesome-webfont.svg",
                      "vendor/font-awesome/fonts/fontawesome-webfont.ttf",
                      "vendor/font-awesome/fonts/fontawesome-webfont.woff",
                      "vendor/font-awesome/fonts/FontAwesome.otf"]
        files: ["docs/styleguide": "src/stylesheets/**/*.scss", "demo/signup/docs/styleguide": "src/demo/signup/stylesheets/**/*.scss"]

  # Setting Load & Register task:
  grunt.registerTask "default", [], ->
    grunt.loadNpmTasks "grunt-contrib-connect"
    grunt.loadNpmTasks "grunt-contrib-watch"
    grunt.task.run "connect", "watch"

  grunt.registerTask "deploy", [], ->
    grunt.loadNpmTasks "grunt-autoprefixer"
    grunt.loadNpmTasks "grunt-contrib-csslint"
    grunt.loadNpmTasks "grunt-html"
    grunt.task.run "autoprefixer", "csslint", "htmllint"

  grunt.registerTask "doc", [], ->
    grunt.loadNpmTasks "grunt-styleguide"
    grunt.task.run "styleguide"

  grunt.registerTask "slim", [], ->
    grunt.loadNpmTasks "grunt-slim"
    grunt.task.run "slim"

  grunt.registerTask "sass", [], ->
    grunt.loadNpmTasks "grunt-contrib-sass"
    grunt.task.run "sass"

  grunt.registerTask "uglify", [], ->
    grunt.loadNpmTasks "grunt-contrib-uglify"
    grunt.task.run "uglify"
