# hwstudio

<p align="center">
  <a title="'dev' workflow status" href="https://github.com/umarcor/hwstudio/actions?query=workflow%3Adev"><img alt="'dev' workflow status" src="https://github.com/umarcor/hwstudio/workflows/dev/badge.svg"></a><!--
  -->
  <a title="'push' workflow status" href="https://github.com/umarcor/hwstudio/actions?query=workflow%3Apush"><img alt="'push' workflow status" src="https://github.com/umarcor/hwstudio/workflows/push/badge.svg"></a><!--
  -->
  <a title="'doc' workflow status" href="https://github.com/umarcor/hwstudio/actions?query=workflow%3Adoc"><img alt="'doc' workflow status" src="https://github.com/umarcor/hwstudio/workflows/doc/badge.svg"></a><!--
  -->
</p>

<p align="center">
  <a title="Dependency Status" href="https://david-dm.org/umarcor/hwstudio"><img src="https://img.shields.io/david/umarcor/hwstudio.svg?longCache=true&style=flat-square&label=deps"></a><!--
  -->
  <a title="DevDependency Status" href="https://david-dm.org/umarcor/hwstudio?type=dev"><img src="https://img.shields.io/david/dev/umarcor/hwstudio.svg?longCache=true&style=flat-square&label=devdeps"></a><!--
  -->
</p>

# Installation requirements

# Development

```sh
yarn install

yarn serve
# or
yarn build
# or
yarn electron:serve
```

## Docker images for development

For live watching and reloading:

```sh
./docker -d -i
...
~# cd /src
~# yarn ...
```

For testing a release tarball:

```sh
./docker -d
./docker -t bash
```

## Build the docs

```bash
cd docs
pip3 install -r requirements.txt
make html
```

## Package for distribution

```bash
yarn electron:build
```
