<template>
<v-container fill-height fluid>
  <v-row class="mt-auto" no-gutters>
    <v-img
      :src="$vuetify.theme.dark?require('../../public/img/logo_light.svg'):require('../../public/img/logo.svg')"
      contain
      height="200"
  ></v-img>
  </v-row>
  <v-row
    class="mb-auto"
    justify="center"
    no-gutters
  >
    <h1 class="display-3 font-weight-bold mt-10" align="center">
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
