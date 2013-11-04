# Grunt: The JavaScript Task Runner (http://gruntjs.com/)
# Why use a task runner?
#     In one word: automation. The less work you have to do when performing
#     repetitive tasks like minification, compilation, unit testing, linting,
#     etc, the easier your job becomes. After you've configured it, a task
#     runner can do most of that mundane work for you—and your team—with
#     basically zero effort.
# Why use Grunt?
#     The Grunt ecosystem is huge and it's growing every day. With literally
#     hundreds of plugins to choose from, you can use Grunt to automate just
#     about anything with a minimum of effort. If someone hasn't already built
#     what you need, authoring and publishing your own Grunt plugin to npm
#     is a breeze.
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

        # grunt-contrib-watch: https://github.com/gruntjs/grunt-contrib-watch
        # Run predefined tasks whenever watched file patterns are added, changed or deleted.
        watch:
            jade:
                files: [
                    '<%= jadeStylus.mixins %>**/*.jade'
                    '<%= jadeStylus.tests %>}**/*.jade'
                    'index.jade'
                ]
                tasks: ['jade:tests', 'htmlmin:tests', 'jsbeautifier:tests']

    grunt.registerTask 'default', [
        'jade:tests'
    ]

    grunt.registerTask 'dev', [
        'jade:tests'
        'watch:jade'
    ]
