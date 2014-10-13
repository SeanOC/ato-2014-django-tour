module.exports = function(grunt) {

  grunt.initConfig({

    dirTmp: '.tmp/',
    dirRelease: 'build/release/',
    dirDebug: 'build/debug/',

    uglify: {
      prod: {
        files: {
          '<%= dirRelease %>app.js': '<%= dirTmp %>app.js'
        }
      }
    },

    browserify: {
      dev: {
        files: {
          '<%= dirDebug %>app.js': 'src/index.coffee'
        },
        options: {
          debug: true
        },
        browserifyOptions: {
           debug: true
        }
      },
      prod: {
        files: {
          '<%= dirTmp %>app.js': 'src/index.coffee'
        },
        options: {}
      }
    },



    watch: {
      dev: {
        files: [
          './lib/**/*.js',
          './src/**/*.js',
          './lib/**/*.coffee',
          './src/**/*.coffee',
          './lib/**/*.hbs',
          './src/**/*.hbs'
        ],
        tasks: [
          'browserify:dev'
        ],
        options: {
          livereload: true,
          spawn: false,
          atBegin: true
        }
      }
    },




    connect: {
      dev: {
        options: {
          port: 3000,
          base: '.'
        }
      }
    }
  });



  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-browserify');
  grunt.loadNpmTasks('grunt-contrib-connect');

  grunt.registerTask('debug', [
    'browserify:dev'
  ]);

  grunt.registerTask('server', [
    'connect:dev',
    'watch:dev'
  ]);

  grunt.registerTask('release', [
    'browserify:prod',
    'uglify:prod'
  ]);

  grunt.registerTask('default', [
    'debug'
  ]);
};
