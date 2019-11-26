<template>
<!-- TODO:
  - Use localStorage (https://vuejs.org/v2/cookbook/client-side-storage.html) to optionally save
    the state of the app beteween different sessions
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
      app
      clipped
    >
      <!-- PROPOSAL:
        Add buttons/items/commands to 'Load', 'Import', 'Save', 'Export', etc. here;
        place a <v-divider></v-divider> between those and the Settings
      -->
      <v-list dense>
        <v-list-item link v-for="(value, key) in drawerItems" :key="key">
          <v-list-item-action>
            <v-icon>{{value.icon}}</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>{{key}}</v-list-item-title>
          </v-list-item-content>
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

      <v-btn alt="Toggle stats" title="Toggle stats" icon v-on:click.native="toggleStats" :color="sw_stats?'blue':''">
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

            <!-- FIXME:
              Currently, this is not reponsive;
              the class and the icon should be updated on toggle
            -->
            <v-list-item-action>
              <v-btn
                :class="v ? 'primary--text' : ''"
                icon
                @click="toggleLayer(n)"
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

const drawerItems = {
  "Dashboard": {
    icon: "mdi-view-dashboard"
  },
  "Settings": {
    icon: "mdi-settings"
  }
}

export default {
  name: 'App',
  components: {
    Scene
  },
  data: () => ({
    drawer: false,
    drawerItems: drawerItems,
    sw_stats: false,
    layers: [true, true, true],
  }),
  created () {
    this.$vuetify.theme.dark = true
  },
  methods: {
    toggleStats () {
      // TODO: there might be a more idiomatic way to do this,
      // such as using a prop or describing the body of this function in the attribute above
      this.sw_stats=!this.sw_stats;
    },
    toggleLayer (n) {
      /* TODO:
         There might be a more idiomatic way to do this;
         ideally, 'layers' should be passed as a prop to Scene;
         alternatively, this might be handled by vuex, as it is expected to be a core feature
      */
      this.layers[n] = !this.layers[n];
      this.$refs.scene.layerToggle(n);
    }
  }
};
</script>
