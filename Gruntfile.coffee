lrSnippet = require('grunt-contrib-livereload/lib/utils').livereloadSnippet
mountFolder = (connect, dir) ->
  connect.static( require('path').resolve(dir) )


module.exports = (grunt) ->

  require("matchdep").filterDev("grunt-*").forEach grunt.loadNpmTasks

  projectConfig =
		src: 'src'
		temp: '.tmp'
		dev: '.dev'
		dist: 'dist'

  grunt.initConfig
    project: projectConfig
    pkg: grunt.file.readJSON 'bower.json'

    clean:
      dev: '<%= project.dev %>'
      dist: '<%= project.dist %>'

    uglify:
      dist:
        files: "<%= project.dist %>/<%= pkg.name %>-<%= pkg.version %>.min.js": "<%= project.src %>/**/*.js"

    connect:
      src:
        options:
          port: 9001
          base: "<%= project.src %>"
          keepalive: true

    open:
      src:
        path: 'http://localhost:9001/'

    watch:
      src:
        files: [
          '<%= project.src %>/*.html'
          '<%= project.src %>/**/*.js'
          '<%= project.src %>/**/*.css'
        ],
        tasks: ['livereload']


  grunt.registerTask "dev", [
    'clean:dev'
    'open:src'
    'connect:src'
  ]
  grunt.registerTask "dist", [
    'clean:dist'
    'uglify:dist'
  ]
  grunt.registerTask "default", [
    'dev'
  ]
