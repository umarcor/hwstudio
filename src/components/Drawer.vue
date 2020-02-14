
<template>
<v-navigation-drawer
  v-model="$store.state.drawer"
  :mini-variant="drawerMini"
  :disable-route-watcher="true"
  app
  overlay-color="primary"
>
  <v-list dense class="pt-0 pb-0">

    <!-- TODO:
      It feels that there is too much duplication. This should be refactored.
    -->

    <!-- CLOSE -->

    <v-tooltip right
      v-if="drawerMini"
    >
      <template v-slot:activator="{ on }">
        <v-list-item link
          v-on="on"
          @click="toggleDrawer"
        >
          <v-list-item-action><v-icon>mdi-close</v-icon></v-list-item-action>
          <v-list-item-content></v-list-item-content>
        </v-list-item>
      </template>
      <span>{{$t("closeMenu")}}</span>
    </v-tooltip>

    <v-list-item link
      v-if="!drawerMini"
      @click="toggleDrawer"
    >
      <v-list-item-action><v-icon>mdi-close</v-icon></v-list-item-action>
      <v-list-item-content><v-list-item-title>{{$t("closeMenu")}}</v-list-item-title></v-list-item-content>
    </v-list-item>

    <v-divider/>

    <!-- NEW DESIGN -->

    <v-tooltip right
      v-if="drawerMini"
    >
      <template v-slot:activator="{ on }">
        <v-list-item link
          v-on="on"
          @click="newDesign"
        >
          <v-list-item-action><v-icon>mdi-file-outline</v-icon></v-list-item-action>
          <v-list-item-content></v-list-item-content>
        </v-list-item>
      </template>
      <span>{{$t("newDesign")}}</span>
    </v-tooltip>

    <v-list-item link
      v-if="!drawerMini"
      @click="newDesign"
    >
      <v-list-item-action><v-icon>mdi-file-outline</v-icon></v-list-item-action>
      <v-list-item-content><v-list-item-title>{{$t("newDesign")}}</v-list-item-title></v-list-item-content>
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
      <span>{{$t("loadImport")}}</span>
    </v-tooltip>

    <v-list-item link
      v-if="!drawerMini"
      @click="uploadTrigger"
    >
      <v-list-item-action><v-icon>mdi-upload</v-icon></v-list-item-action>
      <v-list-item-content><v-list-item-title>{{$t("loadImport")}}</v-list-item-title></v-list-item-content>
    </v-list-item>

    <v-divider/>

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

    <v-divider/>

    <!-- GENERATE BITSTREAM -->

    <v-tooltip right
      v-if="drawerMini && alive"
    >
      <template v-slot:activator="{ on }">
        <v-list-item link
          v-on="on"
          @click="generateBitstream"
        >
          <v-list-item-action><v-icon>mdi-package</v-icon></v-list-item-action>
          <v-list-item-content></v-list-item-content>
        </v-list-item>
      </template>
      <span>Generate bitstream</span>
    </v-tooltip>

    <v-list-item link
      v-if="!drawerMini && alive"
      @click="generateBitstream"
    >
      <v-list-item-action><v-icon>mdi-package</v-icon></v-list-item-action>
      <v-list-item-content><v-list-item-title>Generate bitstream</v-list-item-title></v-list-item-content>
    </v-list-item>

    <v-divider v-if="alive" />

    <!-- SETTINGS -->

    <v-list-item link disabled>
      <v-list-item-action><v-icon disabled>mdi-settings</v-icon></v-list-item-action>
      <v-list-item-content><v-list-item-title>Settings</v-list-item-title></v-list-item-content>
    </v-list-item>

    <v-divider/>

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

  <template v-slot:append v-if="!drawerMini">
    <v-alert type="warning" prominent class="ml-2 mr-2 caption text-center" dense outlined>
      This tool is a proof of concept; expect breaking changes!
    </v-alert>
  </template>

</v-navigation-drawer>
</template>

<script>
import { mapState, mapMutations, mapActions } from 'vuex';

export default {
  name: 'Drawer',
  data: () => ({
    // TODO: use localStorage to remember user preference with regard to having the drawer expanded/collapsed
    drawerMini: true,
  }),
  computed: {
    ...mapState([
      'alive'
    ]),
  },
  methods: {
    ...mapMutations([
      'toggleDrawer'
    ]),
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
          this.$store.commit('addDesign', {
            file: file,
            content: e.target.result
          });
        }.bind(this);
        reader.readAsText(file);
      });
    },
    newDesign () {
      /* FIXME:
         This item should clean the scene before calling '$router.push'.
         The comments are an example about how to call an action in the store,
         and wait for it to finish before pushing to the router
      */
      //this.$store.dispatch('submitLoginDetails', userDetails).then(() => {
        //if(!this.$store.getters.error){
          this.$router.push('/scene')
        //}
      //})
    },
    ...mapActions([
      'generateBitstream'
    ]),
  }
};
</script>
