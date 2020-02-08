<template>
<v-container
  class="fill-height"
  fluid
>
<!-- TODO:
  Maybe this template can be enhanced using 'v-layout' as suggested in
  https://vuetifyjs.com/en/introduction/frequently-asked-questions#how-to-center-vertically
  instead of using 'mt-auto' and 'mb-auto'.
  The same modification might be applied to 'About'.
-->
  <v-row
    justify="center"
    class="mt-auto flex-column"
  >
    <v-row justify="center">
    <h1 class="display-3 font-weight-bold mb-5">
      Hardware Studio
    </h1>
    </v-row>
    <v-row justify="center">
    <h2 class="title mb-5">
      GUI editor for hardware description design
    </h2>
    </v-row>
  </v-row>
  <v-row
    justify="center"
    class="mb-auto"
  >
    <v-col class="shrink">
      <v-tooltip right>
        <template v-slot:activator="{ on }">
          <v-btn
            href="https://github.com/umarcor/hwstudio"
            icon
            large
            target="_blank"
            v-on="on"
          >
            <v-icon large>mdi-code-tags</v-icon>
          </v-btn>
        </template>
        <span>Source: github.com/umarcor/hwstudio</span>
      </v-tooltip>
      <v-tooltip right>
        <template v-slot:activator="{ on }">
          <v-btn
            icon
            large
            @click="$router.push('/scene')"
            v-on="on"
          >
            <v-icon large>mdi-cube-outline</v-icon>
          </v-btn>
        </template>
        <span>Open demo scene</span>
      </v-tooltip>
    </v-col>
  </v-row>
</v-container>
</template>

<script>
export default {
  name: 'Home'
};
</script>

