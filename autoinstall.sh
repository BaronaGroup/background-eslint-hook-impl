#!/bin/bash
set -e
if ! [ -e package.json ]
then
    echo "Please run autoinstall in the directory with your package.json"
    exit 1
fi

npm install --save-dev background-eslint-hook post-commit
node <<EOF
var fs = require('fs')
var package = require('./package.json')
if (!package.scripts) package.scripts = {}
if (!package.scripts.eslint) package.scripts.eslint = 'eslint .'
package.scripts['background-eslint-hook'] = 'background-eslint-hook'
if (!package['post-commit']) package['post-commit'] = []
if (package['post-commit'].indexOf('background-eslint-hook') === -1) package['post-commit'].push('background-eslint-hook')

fs.writeFileSync('./package.json', JSON.stringify(package, null, 2), 'UTF-8')

EOF

