<p align="center">
  <a title="DevDependency Status" href="https://david-dm.org/umarcor/hwstudio?type=dev"><img src="https://img.shields.io/david/dev/umarcor/hwstudio.svg?longCache=true&style=flat-square&label=devdeps&logo=npm"></a><!--
  -->
  <a title="Dependency Status" href="https://david-dm.org/umarcor/hwstudio"><img src="https://img.shields.io/david/umarcor/hwstudio.svg?longCache=true&style=flat-square&label=deps&logo=npm"></a><!--
  -->
</p>

<p align="center">
  <a title="Online demo" href="https://umarcor.github.io/hwstudio"><img width="550px" src="./public/img/banner.png"/></a>
</p>

<p align="center">
  <a title="Site" href="https://umarcor.github.io/hwstudio"><img src="https://img.shields.io/website.svg?label=umarcor.github.io%2Fhwstudio&longCache=true&style=flat-square&url=http%3A%2F%2Fumarcor.github.io%2Fhwstudio%2Findex.html"></a><!--
  -->
  <a title="'dev' workflow status" href="https://github.com/umarcor/hwstudio/actions?query=workflow%3Adev"><img alt="'dev' workflow status" src="https://img.shields.io/github/workflow/status/umarcor/hwstudio/dev?longCache=true&style=flat-square&label=dev&logo=github"></a><!--
  -->
  <a title="'push' workflow status" href="https://github.com/umarcor/hwstudio/actions?query=workflow%3Apush"><img alt="'push' workflow status" src="https://img.shields.io/github/workflow/status/umarcor/hwstudio/push?longCache=true&style=flat-square&label=push&logo=github"></a><!--
  -->
</p>

# Usage

Since this repository is a proof of concept, no regular/tagged releases are available yet. However, after each commit is pushed, CI workflows produce *nightly* builds:

- The frontend is deployed to [umarcor.github.io/hwstudio](https://umarcor.github.io/hwstudio). Hence, GUI editor features are ready-to-use without any additional dependency! Note that features related to integration with tools on the host are disabled by default, since GitHub Pages is limited to serving files.

- Users can pick the artifacts from any of the successful jobs in ['push' workflow](https://github.com/umarcor/hwstudio/actions?query=workflow%3Apush):
  - `hwstudio`: frontend along with a [Python](https://www.python.org/) backend.
  - `hwstudio_desktop`: frontend packaged as an [Electron](https://www.electronjs.org/) application.

## Python backend

This CLI allows to start a [Flask](https://www.palletsprojects.com/p/flask/) web server. On top of serving the frontend, a HTTP API is provided as a bridge between the frontend and other tools available on the host.

To start the server after extracting the artifact named `hwstudio`:

```py
# Install dependencies
pip3 install -r requirements.txt

# Start the server
cli.py serve -d ../
```

Run `cli.py` (without args) to see all available options.

# Development

Use `yarn` (or `npm`) to install dependencies to subdir `node_modules`.

```sh
yarn
```

Then:

```sh
# start a server with watch and live-reloading
yarn serve

# or run an electron instance
yarn electron:serve
```

Last, package for distribution:

```bash
# build the frontend only (output to subdir 'dist')
yarn build

# or package it as an Electron application (output to subdir 'dist_electron')
yarn electron:build
```

## Docker images

Use a `hwstudio/vuethreejs:dev` container to package as an electron application:

```sh
./dev.sh -d
```

Start a `hwstudio/vuethreejs:run` container with runx and x11docker, to test the packaged application:

```sh
./dev.sh -d -i
...
~# cd /dist
~# ...
```
