<template>
<v-footer app>
  <!-- TODO:
    Add design stats and status icons on the left of the footer (a la VSC)
  -->
  <template v-if="!isAt('home') && !isAt('about')">
    Hardware Studio
  </template>
  <v-spacer></v-spacer>
  <v-btn icon small
    :disabled="isAt('about')"
    color="red"
    to="/about"
  >
    <v-icon>mdi-heart</v-icon>
  </v-btn>
  <v-btn icon small
    @click="$vuetify.theme.dark=!$vuetify.theme.dark"
  >
    <v-icon>mdi-lightbulb{{$vuetify.theme.dark?'':'-on-outline'}}</v-icon>
  </v-btn>
  <!--<span>&copy; 2020</span>-->
</v-footer>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  name: 'Foot',
  computed: {
    ...mapGetters([
      'isAt'
    ])
  },
};
</script>
