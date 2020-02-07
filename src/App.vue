<template>
<!-- TODO:
  - Use localStorage (https://vuejs.org/v2/cookbook/client-side-storage.html) to optionally save
    the state of the app beteween different sessions (dbhi)
  - Use vuex to handle app-level state, actions and mutations
-->
<!-- NEXT:
  - Integrate a static site generator for section 'Docs'. Should it be external (Hugo)?
    Is there any ready-to-use JS/VueJS lib?
  - Integrate a JSON/YAML/TOML viewer (both, as an interactive tree and as plain text), to allow
    modification of the model/design that is being shown in 3D.
    hint: vue-codemirror and vue-json-tree-view (anna)
  - Communicate with an optional backend (node, go, python...) to export, simulate, synthesise, etc.
    hint: vue-resource
-->
<!-- IDEAS:
  - Use TypeScript instead of JavaScript before going too far?
  - Wavedrom JS viewer
-->

  <!-- QUESTION: what is this id="inspire" used for? Is it required? -->
  <v-app id="inspire">
    <!-- TODO:
      This drawer should be moved to a separate component (components/Drawer.vue)
    -->
    <v-navigation-drawer
      v-model="drawer"
      :mini-variant="drawerMini"
      app
      clipped
    >
      <v-list dense>
        <v-list-item link title="Dashboard">
          <v-list-item-action><v-icon>mdi-view-dashboard</v-icon></v-list-item-action>
          <v-list-item-content><v-list-item-title>Dashboard</v-list-item-title></v-list-item-content>
        </v-list-item>

        <v-divider></v-divider>

        <v-list-item link title="New design">
          <v-list-item-action><v-icon>mdi-file-outline</v-icon></v-list-item-action>
          <v-list-item-content><v-list-item-title>New design</v-list-item-title></v-list-item-content>
        </v-list-item>
        <v-list-item link title="Load... | Import...">
          <v-list-item-action><v-icon>mdi-upload</v-icon></v-list-item-action>
          <v-list-item-content><v-list-item-title>Load... | Import...</v-list-item-title></v-list-item-content>
        </v-list-item>

        <v-divider></v-divider>

        <v-list-item link title="Save">
          <v-list-item-action><v-icon>mdi-content-save</v-icon></v-list-item-action>
          <v-list-item-content><v-list-item-title>Save</v-list-item-title></v-list-item-content>
        </v-list-item>
        <v-list-item link title="Save As...">
          <v-list-item-action><v-icon>mdi-content-save-all</v-icon></v-list-item-action>
          <v-list-item-content><v-list-item-title>Save As...</v-list-item-title></v-list-item-content>
        </v-list-item>
        <v-list-item link title="Download... | Export...">
          <v-list-item-action><v-icon>mdi-download</v-icon></v-list-item-action>
          <v-list-item-content><v-list-item-title>Download... | Export...</v-list-item-title></v-list-item-content>
        </v-list-item>

        <v-divider></v-divider>

        <v-list-item link title="Settings">
          <v-list-item-action><v-icon>mdi-settings</v-icon></v-list-item-action>
          <v-list-item-content><v-list-item-title>Settings</v-list-item-title></v-list-item-content>
        </v-list-item>

        <v-divider></v-divider>

        <v-list-item link :title="drawerMini?'Expand':'Collapse'" @click="drawerMini=!drawerMini">
          <v-list-item-action><v-icon>mdi-arrow-{{drawerMini?'expand-right':'collapse-left'}}</v-icon></v-list-item-action>
          <v-list-item-content><v-list-item-title>{{drawerMini?'Expand':'Collapse'}}</v-list-item-title></v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>

    <!-- TODO:
      This bar should be moved to a separate component (components/AppBar.vue)
    -->
    <v-app-bar
      app
      clipped-left
    >
      <!-- TODO:
        Add the (fancy) logo; can the hamburguer icon be replaced?
      -->
      <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
      <!-- TODO:
        Move to the footer (right), taking care not to enlarge the height of it
      -->
      <v-toolbar-title>Hardware Studio</v-toolbar-title>
      <!-- TODO:
        Show title of the currently open document/section. If reading the docs, show breadcrumbs
      -->

      <!-- TODO:
        Add buttons/tabs/dropdowns to select the one of the opened projects.
        Show optional actions too (such as calling backend features, if available)
      -->

      <v-spacer></v-spacer>

      <v-btn
        alt="Toggle stats"
        title="Toggle stats"
        icon
        @click="sw_stats=!sw_stats"
        :color="sw_stats?'blue':''"
      >
        <v-icon>mdi-chart-histogram</v-icon>
      </v-btn>

      <v-menu
        :close-on-content-click="false"
        :offset-y="true"
        left
        bottom
      >
        <template v-slot:activator="{ on }">
          <v-btn icon v-on="on">
            <v-icon>mdi-layers-triple</v-icon>
          </v-btn>
        </template>

        <v-list>
          <v-list-item
            v-for="(v, n) in layers"
            :key="n"
          >
            <!--
            <v-list-item-avatar>
              <img src="https://cdn.vuetifyjs.com/images/john.jpg" alt="John">
            </v-list-item-avatar>
            -->

            <v-list-item-content>
              <v-list-item-title>Layer {{n}}</v-list-item-title>
            </v-list-item-content>

            <!--  TODO:
              https://vuejs.org/v2/guide/list.html#Caveats

              There might be a more idiomatic way to do this;
              ideally, 'layers' should be passed as a prop to Scene;
              alternatively, this might be handled by vuex, as it is expected to be a core feature
            -->
            <v-list-item-action>
              <v-btn
                :class="v ? 'primary--text' : ''"
                icon
                @click="$set(layers, n, !v); $refs.scene.layerToggle(n)"
              >
                <v-icon>mdi-eye{{ (v==false)?'-off':''}}</v-icon>
              </v-btn>
            </v-list-item-action>
          </v-list-item>
        </v-list>
      </v-menu>
    </v-app-bar>

    <!-- TODO:
      Use router to handle different sections: 'Scene', 'Home', 'Docs', 'Reports', etc.
    -->
    <v-content>
      <Scene ref="scene" :sw_stats="sw_stats"/>
    </v-content>

    <v-footer app>
      <!-- TODO:
        Add stats and status icons on the left of the footer (a la VSC)
      -->
      <v-spacer></v-spacer>
      <!-- TODO:
        Add a modal to show an 'About' content, with License, link to repo, etc.
      -->
      <v-btn icon color="red" small>
        <v-icon>mdi-heart</v-icon>
      </v-btn>
      <!--<span>&copy; 2020</span>-->
    </v-footer>
  </v-app>
</template>

<script>
import Scene from '@/components/Scene';

export default {
  name: 'App',
  components: {
    Scene
  },
  data: () => ({
    drawer: false,
    /* TODO:
      Use localStorage to remember user preference with regard to having the drawer expanded/collapsed
    */
    drawerMini: true,
    sw_stats: false,
    layers: [true, true, true],
  }),
  created () {
    this.$vuetify.theme.dark = true
  }
};
</script>
