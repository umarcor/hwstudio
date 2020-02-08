
<template>
<v-navigation-drawer
  v-model="$store.state.drawer"
  :mini-variant="drawerMini"
  app
  clipped
>
  <v-list dense>

    <!-- TODO:
      It feels that there is too much duplication. This should be refactored.
    -->

    <!-- NEW DESIGN -->

      <!-- FIXME
        This item should clean the scene before calling '$router.push'
      -->

    <v-tooltip right
      v-if="drawerMini"
    >
      <template v-slot:activator="{ on }">
        <v-list-item link
          v-on="on"
          @click="$router.push('/scene')"
        >
          <v-list-item-action><v-icon>mdi-file-outline</v-icon></v-list-item-action>
          <v-list-item-content></v-list-item-content>
        </v-list-item>
      </template>
      <span>New design</span>
    </v-tooltip>

    <v-list-item link
      v-if="!drawerMini"
      @click="$router.push('/scene')"
    >
      <v-list-item-action><v-icon>mdi-file-outline</v-icon></v-list-item-action>
      <v-list-item-content><v-list-item-title>New design</v-list-item-title></v-list-item-content>
    </v-list-item>

    <!-- LOAD | IMPORT -->

    <v-tooltip right
      v-if="drawerMini"
    >
      <template v-slot:activator="{ on }">
        <v-list-item link
          v-on="on"
          @click="uploadTrigger"
        >
          <v-list-item-action><v-icon>mdi-upload</v-icon></v-list-item-action>
          <v-list-item-content></v-list-item-content>
        </v-list-item>
      </template>
      <span>Load... | Import...</span>
    </v-tooltip>

    <v-list-item link
      v-if="!drawerMini"
      @click="uploadTrigger"
    >
      <v-list-item-action><v-icon>mdi-upload</v-icon></v-list-item-action>
      <v-list-item-content><v-list-item-title>Load... | Import...</v-list-item-title></v-list-item-content>
    </v-list-item>

    <v-divider></v-divider>

    <!-- SAVE -->

    <v-list-item link disabled>
      <v-list-item-action><v-icon disabled>mdi-content-save</v-icon></v-list-item-action>
      <v-list-item-content><v-list-item-title>Save</v-list-item-title></v-list-item-content>
    </v-list-item>

    <!-- SAVE AS -->

    <v-list-item link disabled>
      <v-list-item-action><v-icon disabled>mdi-content-save-all</v-icon></v-list-item-action>
      <v-list-item-content><v-list-item-title>Save As...</v-list-item-title></v-list-item-content>
    </v-list-item>

    <!-- DOWNLOAD | EXPORT -->

    <v-list-item link disabled>
      <v-list-item-action><v-icon disabled>mdi-download</v-icon></v-list-item-action>
      <v-list-item-content><v-list-item-title>Download... | Export...</v-list-item-title></v-list-item-content>
    </v-list-item>

    <v-divider></v-divider>

    <!-- GENERATE BITSTREAM -->

    <v-tooltip right
      v-if="drawerMini && $store.state.alive"
    >
      <template v-slot:activator="{ on }">
        <v-list-item link
          v-on="on"
          @click="drawerMini=!drawerMini"
        >
          <v-list-item-action><v-icon>mdi-cube-outline</v-icon></v-list-item-action>
          <v-list-item-content></v-list-item-content>
        </v-list-item>
      </template>
      <span>Generate bitstream</span>
    </v-tooltip>

    <v-list-item link
      v-if="!drawerMini && $store.state.alive"
      @click="rest_genbit"
    >
      <v-list-item-action><v-icon>mdi-cube-outline</v-icon></v-list-item-action>
      <v-list-item-content><v-list-item-title>Generate bitstream</v-list-item-title></v-list-item-content>
    </v-list-item>

    <v-divider></v-divider>

    <!-- SETTINGS -->

    <v-list-item link disabled>
      <v-list-item-action><v-icon disabled>mdi-settings</v-icon></v-list-item-action>
      <v-list-item-content><v-list-item-title>Settings</v-list-item-title></v-list-item-content>
    </v-list-item>

    <v-divider></v-divider>

    <!-- EXPAND | COLLAPSE -->

    <v-tooltip right
      v-if="drawerMini"
    >
      <template v-slot:activator="{ on }">
        <v-list-item link
          v-on="on"
          @click="drawerMini=!drawerMini"
        >
          <v-list-item-action><v-icon>mdi-arrow-expand-right</v-icon></v-list-item-action>
          <v-list-item-content></v-list-item-content>
        </v-list-item>
      </template>
      <span>Expand</span>
    </v-tooltip>

    <v-list-item link
      v-if="!drawerMini"
      @click="drawerMini=!drawerMini"
    >
      <v-list-item-action><v-icon>mdi-arrow-collapse-left</v-icon></v-list-item-action>
      <v-list-item-content><v-list-item-title>Collapse</v-list-item-title></v-list-item-content>
    </v-list-item>

  </v-list>
  <input ref="finput" v-show="false" type="file" multiple v-on:change="uploadFile">
</v-navigation-drawer>
</template>

<script>
export default {
  name: 'Drawer',
  props: {
    drawer: Boolean
  },
  data: () => ({
    // TODO: use localStorage to remember user preference with regard to having the drawer expanded/collapsed
    drawerMini: true,
  }),
  methods: {
    uploadTrigger() {
      this.$refs["finput"].click();
    },
    uploadFile (e) {
      e.target.files.forEach(file => {
        console.log(file);
        var reader = new FileReader();
        reader.onload = function(e) {
          console.log(e);
          // TODO: check that the file is of a supported format, and extract the content if required
          this.$store.state.designs.push({
            file: file,
            content: e.target.result
          });
        }.bind(this);
        reader.readAsText(file);
      });
    },
    // FIXME: this method should not be located here, but in the vuex store instead
    rest_genbit () {
      // TODO: send (POST) binary (encoded) stream; a tarball; instead of JSON content
      this.$http.get('/api/genbit')
      .then((r) => {
        if (r.status === 200) {
          console.log('Generate bitstream SUCCESS:', r.body)
        } else {
          // TODO: open a modal to show this error to the user
          console.log('Generate bitstream request failed. Returned status of ' + r.status);
        }
      })
      .catch((err) => {
        // TODO: open a modal to show this error to the user
        console.log('Generate bitstream ERROR:', err.status, err.statusText)
      });
    }
  }
};
</script>
