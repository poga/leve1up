#!/usr/bin/env lsc -cj
author:
  name: ['Poga Po']
  email: 'poga@poga.tw'
name: 'DarePad'
description: 'SOP of everything'
version: '0.0.1'
main: \lib/index.js
bin:
  darepad: 'bin/darepad'
repository:
  type: 'git'
  url: 'git://github.com/poga/darepad.git'
scripts:
  prepublish: """
    ./node_modules/gulp/bin/gulp.js --require LiveScript
  """
  dev: "./node_modules/gulp/bin/gulp.js --require LiveScript dev"
engines: {node: '*'}
dependencies: {}
devDependencies:
  'crypto-js': \*
  express: \*
  jade: \*
  LiveScript: \*
  gulp: \*
  'gulp-util': \*
  'gulp-stylus': \*
  nib: \*
  'gulp-livescript': '~0.3.0'
  'gulp-jade': \*
  'gulp-livereload': \*
  'connect-livereload': \*
  'gulp-plumber': \*
  browserify: \~3.24.11
  "gulp-browserify": \~0.4.2
