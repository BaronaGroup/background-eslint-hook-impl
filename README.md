# background-eslint-hook

This repository contains a file that is meant to be used as a post-commit hook to automatically run 
eslint in the background.

When properly configured, upon making a commit eslint is automatically run. Instead of it being a
blocking operation, everything instead happens in the background. Once completed, a notification is
shown using OS facilities, typically in the top right corner of your primary monitor.

Whenever multiple commits happen in quick succession, an eslint run is started for each commit,
but the eslint process for the previous commit is automatically killed.

## Prerequisites

- your code bases uses npm
- you have installed `eslint`
- you have configured `eslint`

## Compatibility

- OS X
- Ubuntu
- Any other Linux environments that support `notify-send`

## Installation as a post-commit hook

### Autoinstall

    bash <<< $(curl https://raw.githubusercontent.com/BaronaGroup/background-eslint-hook-impl/master/autoinstall.sh)


### node.js


Run

    npm install --save-dev background-eslint-hook
    npm install --save-dev post-commit

Update package.json

At its simplest, the things needed in package.json look more or less like this:

     "scripts": {
        "eslint": "eslint .",
        "background-eslint-hook": "background-eslint-hook"
     },
     "post-commit": [
        "background-eslint-hook"
     ]    

The script `eslint` will be invoked by the hook, and can be modified to include whichever parameters
your code base happens to need.

You can and should of course add these scripts and post-commit hooks to your existing configuration,
if any exists.