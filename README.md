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

# Development

Use `yarn` (or `npm`) to install dependencies to subdir `node_modules`.

```sh
yarn install
```

Then:

```sh
# start a server
yarn serve
# or build the artifacts
yarn build
# or run the artifacts in an electron instance
yarn electron:serve
```

Last, package for distribution:

```bash
yarn electron:build
```

## Docker images

Build a package in a `umarcor/hwstudio:dev` container::

```sh
./dev.sh -d
```

Start a `umarcor/hwstudio:run` container with runx and x11docker, to test the package:

```sh
./dev.sh -d -i
...
~# cd /dist
~# ...
```
