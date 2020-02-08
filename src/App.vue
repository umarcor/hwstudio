<template>
<!-- TODO:
  - Use localStorage (https://vuejs.org/v2/cookbook/client-side-storage.html) to optionally save
    the state of the app beteween different sessions (dbhi)
  - Understand vuex's app-level 'state', 'actions' and 'mutations'. Are those names conventions or fixed?
-->
<!-- NEXT:
  - Integrate a static site generator for section 'Docs'. Should it be external (Hugo)?
    Is there any ready-to-use JS/VueJS lib?
  - Integrate a JSON/YAML/TOML viewer (both, as an interactive tree and as plain text), to allow
    modification of the model/design that is being shown in 3D.
    hint: vue-codemirror and vue-json-tree-view (anna)
  - Extend Python backend endpoints to export, simulate, synthesise, etc.
    -  Optionally, implement the backend in a different language: JS (node, electron), go...
-->
<!-- IDEAS:
  - Use TypeScript instead of JavaScript before going too far?
  - Wavedrom JS viewer
  - 'Reports' viewer
-->

  <!--  TODO:
    https://vuejs.org/v2/guide/list.html#Caveats

    There might be a more idiomatic way to execute/trigger a method in Scene; ideally, Scene should
    watch for changes in '$store.state.scene.layers' and toggle internal fields accordingly.
  -->

  <!-- QUESTION: what is this id="inspire" used for? Is it required? -->
  <v-app id="inspire">
    <Drawer/>
    <AppBar @layerToggle="(n) => {$refs.scene.layerToggle(n)}"/>
    <router-view ref="scene"/>
    <Foot/>
  </v-app>
</template>

<script>
import Vue from 'vue'

import VueResource from 'vue-resource'
Vue.use(VueResource);

import Drawer from '@/components/Drawer';
import AppBar from '@/components/AppBar';
import Foot from '@/components/Foot';

export default {
  name: 'App',
  components: {
    Drawer,
    AppBar,
    Foot
  },
  created () {
    this.$vuetify.theme.dark = true;
    this.rest_alive();
  },
  methods: {
    rest_alive () {
      this.$http.get('/api/alive')
      .then((r) => {
        if (r.status === 200) {
          console.log('Backend API is alive:', r.body)
        } else {
          console.log('Backend API alive request failed. Returned status of ' + r.status);
          this.$store.state.alive=false;
        }
      })
      .catch((err) => {
        console.log('Backend API alive check ERROR:', err.status, err.statusText)
        this.$store.state.alive=false;
      });
    },
  }
};
</script>
