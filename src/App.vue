<template>
<!-- QUESTION: what is this id="inspire" used for? Is it required? -->
<v-app id="inspire">

  <Drawer/>

  <AppBar/>

  <v-content>
    <router-view/>
  </v-content>

  <Foot/>

</v-app>
</template>

<script>
import Drawer from '@/components/Drawer';
import AppBar from '@/components/AppBar';
import Foot from '@/components/Foot';

import { mapActions } from 'vuex';

export default {
  name: 'App',
  components: {
    Drawer,
    AppBar,
    Foot
  },
  created () {
    this.$vuetify.theme.dark = true;
    this.checkAlive();
  },
  methods: {
    ...mapActions([
      'checkAlive'
    ]),
  }
};
</script>
