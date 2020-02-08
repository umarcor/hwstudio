<template>
<v-container fluid class="fill-height">
  <!-- FIXME
    The logo and the content should be shown in the center and
    'flex white space' should be added above and below only,
    not in-between
  -->
  <v-row>
    <v-img
      :src="$vuetify.theme.dark?require('../../public/img/logo_light.svg'):require('../../public/img/logo.svg')"
      contain
      height="200"
  ></v-img>
  </v-row>
  <v-row
    align="center"
    justify="center"
  >
    <h1 class="display-2 font-weight-bold mb-3">
      Hardware Studio
    </h1>
  </v-row>
</v-container>
</template>

<script>
export default {
  name: 'About',
};
</script>
