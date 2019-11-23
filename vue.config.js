module.exports = {
  transpileDependencies: [
    "vuetify"
  ],
  pluginOptions: {
    // https://nklayman.github.io/vue-cli-plugin-electron-builder/guide/configuration.html#table-of-contents
    electronBuilder: {
      builderOptions: {
        linux: [ "tar.gz", "7z" ]
      }
    }
  }
}