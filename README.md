<p align="center">
  <a title="'dev' workflow status" href="https://github.com/umarcor/hwstudio/actions?query=workflow%3Adev"><img alt="'dev' workflow status" src="https://img.shields.io/github/workflow/status/umarcor/hwstudio/dev?longCache=true&style=flat-square&label=dev"></a><!--
  -->
  <a title="'push' workflow status" href="https://github.com/umarcor/hwstudio/actions?query=workflow%3Apush"><img alt="'push' workflow status" src="https://img.shields.io/github/workflow/status/umarcor/hwstudio/push?longCache=true&style=flat-square&label=push"></a><!--
  -->
  <a title="'doc' workflow status" href="https://github.com/umarcor/hwstudio/actions?query=workflow%3Adoc"><img alt="'doc' workflow status" src="https://img.shields.io/github/workflow/status/umarcor/hwstudio/doc?longCache=true&style=flat-square&label=doc"></a><!--
  -->
  <a title="vscode-client DevDependency Status" href="https://david-dm.org/umarcor/hwstudio/develop?type=dev"><img src="https://img.shields.io/david/dev/umarcor/hwstudio.svg?longCache=true&style=flat-square&label=devdeps"></a><!--
  -->
  <a title="app Dependency Status" href="https://david-dm.org/umarcor/hwstudio/develop?path=app"><img src="https://img.shields.io/david/umarcor/hwstudio.svg?path=app&longCache=true&style=flat-square&label=app%20deps"></a><!--
  -->
</p>

# Installation

Requirements:

- GNU/Linux: `xclip`.
- macOS: [Homebrew](https://brew.sh).

Since this repository is a proof of concept, no regular/tagged releases are available yet. However, after each commit is pushed, CI workflows produce nightly builds for all the supported platforms. Users can pick the artifacts from any of the successful jobs in [umarcor/hwstudio/actions?query=workflow%3Apush](https://github.com/umarcor/hwstudio/actions?query=workflow%3Apush).

# Development

Requires `10 <=` [Node.js](https://nodejs.org/) `<= 11`.

Use `yarn` (or `npm`) to install dependencies to subdir `node_modules`.

```sh
yarn install
```

## Docker images for development

```sh
./docker -d
./docker -t bash
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

Basque, Catalan, Chinese, Czech, Dutch, English, French, Galician, German, Greek, Italian, Korean, Russian, Spanish...

`*.po` sources for localisation are located in [`app/resources/locale`](./app/resources/locale).

## Package for distribution

```bash
yarn dist
```

- GNU/Linux: (linux32,linux64).zip, (linux32,linux64).AppImage
- Windows: (win32,win64).zip
- Mac OS: osx64.zip, osx64.dmg
