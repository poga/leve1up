#!/usr/bin/env lsc -cj
author:
  name: ['Poga Po']
  email: 'poga@poga.tw'
name: 'leve1up'
description: 'declarative tutorial writing with markdown and angularjs'
version: '0.0.1'
main: \lib/index.js
bin:
  pgrest: 'bin/leve1up'
repository:
  type: 'git'
  url: 'git://github.com/poga/leve1up.git'
scripts:
  prepublish: """
    lsc -cj package.ls &&
    lsc -bc -o lib src
    lsc -bc -o assets/javascript assets/ls/leve1up.ls
  """
engines: {node: '*'}
dependencies:
  htmlparser2: \3.4.0
  marked: \0.3.0
  jade: \1.1.5
devDependencies:
  LiveScript: \1.2.x
