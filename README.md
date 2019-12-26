<p align="center">
  <a title="'dev' workflow status" href="https://github.com/umarcor/hwstudio/actions?query=workflow%3Adev"><img alt="'dev' workflow status" src="https://github.com/umarcor/hwstudio/workflows/dev/badge.svg"></a><!--
  -->
  <a title="'push' workflow status" href="https://github.com/umarcor/hwstudio/actions?query=workflow%3Apush"><img alt="'push' workflow status" src="https://github.com/umarcor/hwstudio/workflows/push/badge.svg"></a><!--
  -->
  <a title="'doc' workflow status" href="https://github.com/umarcor/hwstudio/actions?query=workflow%3Adoc"><img alt="'doc' workflow status" src="https://github.com/umarcor/hwstudio/workflows/doc/badge.svg"></a><!--
  -->
</p>

<p align="center">
  <a title="vscode-client DevDependency Status" href="https://david-dm.org/umarcor/hwstudio/actions?type=dev"><img src="https://img.shields.io/david/dev/umarcor/hwstudio.svg?longCache=true&style=flat-square&label=devdeps"></a><!--
  -->
  <a title="app Dependency Status" href="https://david-dm.org/umarcor/hwstudio/actions?path=app"><img src="https://img.shields.io/david/umarcor/hwstudio.svg?path=app&longCache=true&style=flat-square&label=app%20deps"></a><!--
  -->
</p>

# Installation

Requirements:

- GNU/Linux: `xclip`.
- macOS: [Homebrew](https://brew.sh).

Since this repository is a proof of concept, no regular/tagged releases are available yet. However, after each commit is pushed, CI workflows produce nightly builds for all the supported platforms. Users can pick the artifacts from any of the successful jobs in [umarcor/hwstudio/actions?query=workflow%3Apush](https://github.com/umarcor/hwstudio/actions?query=workflow%3Apush).

# Development

- [Node.js](https://nodejs.org/).

```sh
yarn install

yarn start
```

## Docker images for development

```sh
./docker -d
./docker -t bash
```

For live watching and reloading:

```sh
./docker -d -i
...
~# cd /src
~# yarn start
```

## Build the docs

```bash
cd docs
pip3 install -r requirements.txt
make html
firefox _build/html/index.html
```

## Internationalisation

Use `yarn gettext` to extract the labels from the code.

## Localisation

|  Language  | Translated strings                       |
|:----------:|:----------------------------------------:|
| English    | ![Progress](http://progress-bar.dev/100) |
| Spanish    | ![Progress](http://progress-bar.dev/92)  |
| Italian    | ![Progress](http://progress-bar.dev/89)  |
| French     | ![Progress](http://progress-bar.dev/78)  |
| Dutch      | ![Progress](http://progress-bar.dev/78)  |
| Czech      | ![Progress](http://progress-bar.dev/78)  |
| Greek      | ![Progress](http://progress-bar.dev/79)  |
| German     | ![Progress](http://progress-bar.dev/77)  |
| Russian    | ![Progress](http://progress-bar.dev/77)  |
| Chinese    | ![Progress](http://progress-bar.dev/72)  |
| Galician   | ![Progress](http://progress-bar.dev/78)  |
| Basque     | ![Progress](http://progress-bar.dev/77)  |
| Catalan    | ![Progress](http://progress-bar.dev/72)  |

`*.po` sources for localisation are located in [`app/resources/locale`](./app/resources/locale).

## Package for distribution

```bash
yarn dist
```

| Target OS | Development OS | Output files |
|:---:|:-------------:|:-----------------:|
| GNU/Linux | GNU/Linux | (linux32,linux64).zip, (linux32,linux64).AppImage |
| Windows | GNU/Linux | (win32,win64).zip, (win32,win64).exe |
| Mac OS | Mac OS | osx64.zip, osx64.dmg |
