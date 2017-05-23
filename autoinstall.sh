#!/bin/bash
set -e
if ! [ -e package.json ]
then
    echo "Please run autoinstall in the directory with your package.json"
    exit 1
fi

npm install --save-dev https://github.com/BaronaGroup/background-eslint-hook-impl.git#master post-commit
node <<EOF

var package = require('./package.json')
if (!package.scripts) package.scripts = {}
if (!package.scripts.eslint) package.scripts.eslint = 'eslint'
package.scripts['background-eslint-hook-impl'] = 'background-eslint-hook-impl'
if (!package['post-commit']) package['post-commit'] = []
if (package['post-commit'].indexOf('background-eslint-hook-impl') === -1) package['post-commit'].push('background-eslint-hook-impl')

fs.writeFileSync('./package.json', JSON.stringify(package, null, 2), 'UTF-8')

EOF

