<template>
<v-container
  class="fill-height"
  fluid
>
  <v-row
    align="center"
    justify="center"
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

