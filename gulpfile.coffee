gulp = require('gulp')
del = require('del')
path = require('path')
# Load plugins
$ = require('gulp-load-plugins')()
browserify = require('browserify')
watchify = require('watchify')
buffer = require('vinyl-buffer')
source = require('vinyl-source-stream')

jade = require('gulp-react-jade')

sourceFile = './client/scripts/index.coffee'
destFolder = './app/public/scripts'
destFileName = 'app.js'

bundle = ->
  bundler
  .bundle()
  .on('error', $.util.log.bind($.util, 'error'))
  .pipe(source('bundle.js'))
  .pipe(buffer())
  .pipe(sourcemaps.init(loadMaps: true))
  .pipe(sourcemaps.write('app/public/scripts/'))
  .pipe(gulp.dest('app/public/scripts/'))

bundler = watchify(browserify(sourceFile, watchify.args))
bundler.on 'update', bundle

gulp.task 'watch', [
  'build:styles'
  'images'
  'jade'
], -> do bundle

# Bundle
gulp.task 'bundle', [
  'images'
  'jade'
  'build:styles'
  'bower'
  'extras'
], ->
  browserify(sourceFile, watchify.args)
    .bundle()
    .pipe(source('bundle.js'))
    .pipe(buffer())
    .pipe($.streamify($.uglify()))
    .pipe(gulp.dest('app/public/scripts/'))


# Styles
gulp.task 'build:styles', ->
  gulp.src([
    'client/styles/**/*.styl'
    'client/styles/**/*.css'
  ])
  .pipe($.stylus())
  .pipe(gulp.dest('app/public/styles'))
  .pipe($.size())

gulp.task 'jade', ->
  gulp.src('client/scripts/template/**/*.jade')
  .pipe(do jade)
  .pipe(gulp.dest('client/scripts/template'))

# Images
gulp.task 'images', ->
  gulp.src('client/images/**/*')
  .pipe($.cache($.imagemin(
    optimizationLevel: 3
    progressive: true
    interlaced: true)))
  .pipe(gulp.dest('app/public/images'))
  .pipe $.size()

# Clean
gulp.task 'clean', (callback)->
  del.sync([
    'app/public'
    'client/scripts/template/**/*.js'
  ])
  do callback

# Bower helper
gulp.task 'bower', ->
  gulp.src(
    'client/bower_components/**/*.js',
    base: 'client/bower_components')
  .pipe gulp.dest('public/bower_components/')

# Robots.txt and favicon.ico
gulp.task 'extras', ->
  gulp.src([
    'client/*.txt'
    'client/*.ico'
  ])
  .pipe(gulp.dest('app/public/'))
  .pipe $.size()

# Default task
gulp.task 'default', [
  'clean'
  'build'
]
