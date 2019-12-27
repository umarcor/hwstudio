<p align="center">
  <a title="'dev' workflow status" href="https://github.com/umarcor/hwstudio/actions?query=workflow%3Adev"><img alt="'dev' workflow status" src="https://github.com/umarcor/hwstudio/workflows/dev/badge.svg"></a><!--
  -->
  <a title="'push' workflow status" href="https://github.com/umarcor/hwstudio/actions?query=workflow%3Apush"><img alt="'push' workflow status" src="https://github.com/umarcor/hwstudio/workflows/push/badge.svg"></a><!--
  -->
  <a title="'doc' workflow status" href="https://github.com/umarcor/hwstudio/actions?query=workflow%3Adoc"><img alt="'doc' workflow status" src="https://github.com/umarcor/hwstudio/workflows/doc/badge.svg"></a><!--
  -->
</p>

<p align="center">
  <a title="vscode-client DevDependency Status" href="https://david-dm.org/umarcor/hwstudio/develop?type=dev"><img src="https://img.shields.io/david/dev/umarcor/hwstudio.svg?longCache=true&style=flat-square&label=devdeps"></a><!--
  -->
  <a title="app Dependency Status" href="https://david-dm.org/umarcor/hwstudio/develop?path=app"><img src="https://img.shields.io/david/umarcor/hwstudio.svg?path=app&longCache=true&style=flat-square&label=app%20deps"></a><!--
  -->
</p>

# Development

```sh
yarn install

yarn dist
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
