# To Do

- Improve the location of the language selector.
- Use localStorage (https://vuejs.org/v2/cookbook/client-side-storage.html) to optionally save the state of the app beteween different sessions. (dbhi)
- Define the HWD format: a zip/tarball including VHDL sources, a configuration file and a 'layout'/'three' file.
- Extend Python backend endpoints to export, simulate, synthesise, etc. HWD files.
  -  Optionally, implement the backend in a different language: JS (node, electron), go...

## User experience (UX)

## Centered layout

Currently, titles/subtitles in 'Home' and 'About are shown properly on large screens, but are not horizontaly centered on
smartphones and other small devices.

Maybe the template can be enhanced using 'v-layout' as suggested in https://vuetifyjs.com/en/introduction/frequently-asked-questions#how-to-center-vertically, instead of using 'mt-auto' and 'mb-auto'.

Alternatively, https://gist.github.com/johnleider/207f63c9d30fb77042a0bb0258c5ab32 can be tested, to see if any of those examples fits our needs.

## GitHub Pages

GitHub Pages does not resolve non-existing URLs. Hence, browsing `umarcor.github.io/hwstudio/scene` directly does not work. Users need to access the entrypoint (`umarcor.github.io/hwstudio`) for the router to work.

Static site generators based on Vue seem to either generate non-routed separate sources in each location, or they *bootstrap* the app/router from a source in each location. It would be interesting to investigate if any of the existing solution works for our use case.

Alternatively, we can generate a source in each of the expected locations, to automatically redirect the users to the entrypoing, including some URL params for the router to push straightaway.

## Documentation

It would be handy to have the documentation embedded in the app, so users don't need to access some remote site. There seem to be several possible approaches:

- Generate the documentation as a completely independent static site (with e.g. Hugo, Sphinx or Jekyll):
  - Host the documentation in a subdir, completely decoupled.
  - "Import" the result in the vuetify + vue-router app.
- Use a documentation site generation library for Vue with a theme based on Vuetify, and embed the Scene and other app-related features as a page in the site.

## Collapsible app-bar and hideable footer

The app-bar can be collapsed. We might provide an option in the settings to enable/disable it. At the same time, the footer does not provide much information at the moment. It'd be useful to make it optionally hideable too.

These options are specially interesting when working fullscreen (F11), as users might want o have the maximum usable area for the design.

# Ideas

- Use TypeScript instead of JavaScript before going too far?
- Waveform viewer (wavedrom)
- 'Reports' viewer
- Integrate a JSON/YAML/TOML viewer (both, as an interactive tree and as plain text), to allow modification of the model/design that is being shown in 3D. hint: vue-codemirror and vue-json-tree-view (anna)

# References

## Vuetify (Vue + Material Design)

- ! [vue](https://vuejs.org)
- ! [vuetify](https://vuetifyjs.com)
- [explore vuetify components](https://vuetifyjs.com/components/api-explorer)
- [vue-cli](https://github.com/vuejs/vue-cli/tree/dev/docs)
- installed CLI plugins:
  - [babel](https://github.com/vuejs/vue-cli/tree/dev/packages/%40vue/cli-plugin-babel)
  - [eslint](https://github.com/vuejs/vue-cli/tree/dev/packages/%40vue/cli-plugin-eslint)
- ecosystem:
  - ! [vue-router](https://router.vuejs.org/guide/)
  - ! [vuex](https://vuex.vuejs.org/)
  - ! [vue-resource](https://github.com/pagekit/vue-resource)
  - [vuex-router-sync](https://github.com/vuejs/vuex-router-sync)
  - [vuetify-loader](https://github.com/vuetifyjs/vuetify-loader)
  - [vue-loader](https://vue-loader.vuejs.org/en)
  - [vue-cli-plugin-electron-builder](https://nklayman.github.io/vue-cli-plugin-electron-builder/)
  - [vue-devtools](https://github.com/vuejs/vue-devtools#vue-devtools)
- community:
  - [awesome-vue](https://github.com/vuejs/awesome-vue)
  - [awesome-vuetify](https://github.com/vuetifyjs/awesome-vuetify)
  - [vue forum](https://forum.vuejs.org)
  - [vuetify FAQ](https://vuetifyjs.com/getting-started/frequently-asked-questions)
  - [made with vuetify](https://madewithvuejs.com/vuetify)
  - [vue chat](https://chat.vuejs.org)
  - [vuetify chat](https://community.vuetifyjs.com)

### Vue and Three.js

- https://github.com/sascha245/vue-threejs-composer
- https://github.com/fritx/vue-threejs
- https://github.com/vue-gl/vue-gl

### Vue and TypeScript

- https://vuejs.org/v2/guide/typescript.html
- https://github.com/microsoft/TypeScript-Vue-Starter
- https://blog.logrocket.com/how-to-write-a-vue-js-app-completely-in-typescript/
- https://github.com/vuetifyjs/vue-cli-plugins/issues/112#issuecomment-562935079

## Three.js

- [three](https://threejs.org/)
- ! [documentation](https://threejs.org/docs/)
- !!! [editor](https://threejs.org/editor/)
- [editor sources](https://github.com/mrdoob/three.js/tree/master/editor)

## JointJS

- [tutorial](https://resources.jointjs.com/tutorial)
- [demo](https://resources.jointjs.com/demos/kitchensink)
- https://jsfiddle.net/user/kumilingus/fiddles/
  - https://jsfiddle.net/kumilingus/Lznzjqmk/
  - https://jsfiddle.net/kumilingus/e0cesth7/
  - https://jsfiddle.net/kumilingus/o02p83mf/

## Documentation

- [staticgen.com](https://www.staticgen.com/)
- [docsify](https://docsify.js.org/#/)
- [gridsome](https://gridsome.org/)
- [vuepress](https://vuepress.vuejs.org/)
- [nuxtjs](https://nuxtjs.org/)
