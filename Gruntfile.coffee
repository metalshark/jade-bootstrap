###
jade-bootstrap
https://github.com/metalshark/jade-bootstrap

Copyright (c) 2013 'Metalshark' Beech Horn
Licensed under the LGPL v3 license.
###
'use strict'

# http://gruntjs.com/api/grunt
# Grunt exposes all of its methods and properties on the grunt object that gets
# passed into the module.exports function exported in your Gruntfile.
module.exports = (grunt) ->

    # load all grunt tasks
    require('load-grunt-tasks') grunt

    # Project configuration.
    grunt.initConfig

        jadeStylus:
            mixins: 'mixins'
            temp: '.tmp'
            tests: 'tests'

        # grunt-contrib-clean: https://github.com/gruntjs/grunt-contrib-clean
        # Clear files and folders.
        clean:
            temp:
                dot: true
                src: '<%= jadeStylus.temp %>'

        # grunt-contrib-coffee: https://github.com/gruntjs/grunt-contrib-coffee
        # Compile CoffeeScript files to JavaScript.
        coffee:
            gruntfile:
                files: [
                    '<%= jadeStylus.temp %>/Gruntfile.js': 'Gruntfile.coffee'
                ]

        # grunt-coffeelint: https://github.com/vojtajina/grunt-coffeelint
        # Lint your CoffeeScript using grunt.js and coffeelint.
        coffeelint:
            options:
                indentation:
                    value: 4
                max_line_length:
                    value: 120
            all: 'Gruntfile.coffee'

        # grunt-html5compare: https://github.com/metalshark/grunt-html5compare
        # Compares HTML 5 files for equivalence.
        html5compare:
            tests:
                files: [
                    expand: true
                    nonull: true
                    cwd: '<%= jadeStylus.tests %>'
                    src: '**/*.html'
                    dest: '<%= jadeStylus.temp %>'
                    ext: '.html'
                ]

        # grunt-contrib-jade: https://github.com/gruntjs/grunt-contrib-jade
        # Compile Jade templates.
        jade:
            options:
                pretty: true

            tests:
                options:
                    compileDebug: true
                files: [
                    expand: true
                    cwd: '<%= jadeStylus.tests %>'
                    src: '**/*.jade'
                    dest: '<%= jadeStylus.temp %>'
                    ext: '.html'
                ]

        # grunt-contrib-jshint: https://github.com/gruntjs/grunt-contrib-jshint
        # Validate files with JSHint.
        jshint:
            all: '<%= jadeStylus.temp %>/Gruntfile.js'
            options:
                jshintrc: '.jshintrc'

        # grunt-contrib-watch: https://github.com/gruntjs/grunt-contrib-watch
        # Run predefined tasks whenever watched file patterns are added, changed or deleted.
        watch:
            jade:
                files: [
                    '<%= jadeStylus.tests %>}**/*.jade'
                    'index.jade'
                ]
                tasks: ['newer:jade']
            html:
                files: [
                    '<%= jadeStylus.temp %>}**/*.html'
                ]
                tasks: ['html5compare']

    grunt.registerTask 'default', [
        #'clean'
        'newer:coffeelint'
        'newer:coffee'
        'newer:jshint'
        'test'
    ]

    grunt.registerTask 'dev', [
        'newer:coffeelint'
        'newer:coffee'
        'newer:jshint'
        'newer:jade'
        'watch:jade'
    ]

    grunt.registerTask 'test', [
        #'clean'
        'newer:jade'
        'html5compare'
    ]
