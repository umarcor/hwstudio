<template>
<v-container fill-height fluid>
  <v-row
    class="mt-auto flex-column"
    no-gutters
  >
    <v-col>
    <h1 class="display-3 font-weight-bold mb-5" align="center">
      Hardware Studio
    </h1>
    </v-col>
    <v-col>
    <h2 class="title mb-5" align="center">
      {{ $t("description") }}
    </h2>
    </v-col>
  </v-row>
  <v-row
    justify="center"
    class="mb-auto"
    no-gutters
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
            to="/scene"
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

