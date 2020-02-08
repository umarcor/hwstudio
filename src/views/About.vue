<template>
  <v-container
    class="fill-height"
    fluid
  >
    <v-layout
      text-center
      wrap
    >
      <v-row justify="center">
      <v-flex xs12>
        <v-img
          :src="$vuetify.theme.dark?require('../../public/img/logo_light.svg'):require('../../public/img/logo.svg')"
          class="my-3"
          contain
          height="200"
        ></v-img>
      </v-flex>
      </v-row>

      <v-row justify="center">
      <v-flex mb-4>
        <h1 class="display-2 font-weight-bold mb-3">
          Hardware Studio
        </h1>
        <p class="subheading font-weight-regular">
          GUI editor for hardware description designers
        </p>


        <p class="subheading font-weight-regular">
          Thanks to all the <a href="https://github.com/umarcor/hwstudio/graphs/contributors" target="_blank">contributors</a>!
        </p>
      </v-flex>
      </v-row>

  <v-row justify="center">
    <v-col cols="12" sm="6">
      <v-card>
        <v-list>
          <v-list-item @click="() => {}">
            <v-list-item-action>
              Version
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>v0.0.0</v-list-item-title>
            </v-list-item-content>
            <v-list-item-action>
              <v-icon>mdi-message-text</v-icon>
            </v-list-item-action>
          </v-list-item>

          <v-divider inset></v-divider>

          <v-list-item @click="() => {}">
            <v-list-item-action>
              Commit
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>00000000</v-list-item-title>
            </v-list-item-content>
            <v-list-item-action>
              <v-icon>mdi-message-text</v-icon>
            </v-list-item-action>
          </v-list-item>

          <v-divider inset></v-divider>

          <v-list-item @click="() => {}">
            <v-list-item-action>Date</v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>2020-00-00</v-list-item-title>
            </v-list-item-content>
          </v-list-item>

          <v-list-item @click="() => {}">
            <v-list-item-action>License</v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>undef</v-list-item-title>
            </v-list-item-content>
          </v-list-item>

          <v-list-item @click="() => {}">
            <v-list-item-action>Docs</v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>umarcor.github.io/hwstudio/docs</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list>
      </v-card>
    </v-col>
  </v-row>

    </v-layout>
  </v-container>
</template>

<script>
export default {
  name: 'About',
};
</script>
