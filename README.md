<p align="center">
  <a title="Online demo" href="https://umarcor.github.io/hwstudio"><img width="550px" src="./public/img/banner.png"/></a>
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
