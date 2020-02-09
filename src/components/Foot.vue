<template>
<v-footer app>
  <!-- TODO:
    Add design stats and status icons on the left of the footer (a la VSC)
  -->
  <template v-if="!$store.getters.isAt('home') && !$store.getters.isAt('about')">
    Hardware Studio
  </template>
  <v-spacer></v-spacer>
  <v-btn icon color="red" small
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
export default {
  name: 'Foot',
};
</script>
