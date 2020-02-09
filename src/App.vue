<template>
  <!--  TODO:
    https://vuejs.org/v2/guide/list.html#Caveats

    There might be a more idiomatic way to execute/trigger a method in Scene; ideally, Scene should
    watch for changes in '$store.state.scene.layers' and toggle internal fields accordingly.
  -->

  <!-- QUESTION: what is this id="inspire" used for? Is it required? -->
  <v-app id="inspire">
    <Drawer/>
    <AppBar @layerToggle="(n) => {$refs.scene.layerToggle(n)}"/>
    <v-content>
      <router-view ref="scene"/>
    </v-content>
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
          console.log('Backend API is alive:', r.body);
          this.$store.state.alive=true;
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
