<template>
<!-- TODO:
  - Use localStorage (https://vuejs.org/v2/cookbook/client-side-storage.html) to optionally save
    the state of the app beteween different sessions (dbhi)
  - Understand vuex's app-level 'state', 'actions' and 'mutations'. Are those names conventions or fixed?
-->
<!-- NEXT:
  - Integrate a static site generator for section 'Docs'. Should it be external (Hugo)?
    Is there any ready-to-use JS/VueJS lib?
  - Integrate a JSON/YAML/TOML viewer (both, as an interactive tree and as plain text), to allow
    modification of the model/design that is being shown in 3D.
    hint: vue-codemirror and vue-json-tree-view (anna)
  - Extend Python backend endpoints to export, simulate, synthesise, etc.
    -  Optionally, implement the backend in a different language: JS (node, electron), go...
-->
<!-- IDEAS:
  - Use TypeScript instead of JavaScript before going too far?
  - Wavedrom JS viewer
  - 'Reports' viewer
-->

  <!-- QUESTION: what is this id="inspire" used for? Is it required? -->
  <v-app id="inspire">
    <Drawer :drawer="drawer"/>

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

      <v-divider vertical></v-divider>

      <!-- DASHBOARD -->

      <!-- TODO: hide when the user is in '/' (check router path) -->
      <v-tooltip bottom>
        <template v-slot:activator="{ on }">
          <v-btn
            icon
            v-on="on"
            @click="$router.push('/')"
          >
            <v-icon>mdi-view-dashboard</v-icon>
          </v-btn>
        </template>
        <span>Dashboard</span>
      </v-tooltip>

      <!-- TODO:
        - If/when reading the docs, show breadcrumbs.
        - Optionally show backend actions here, instead of in the drawer. Provide a settings switch for users to choose.
      -->

      <!-- 3D Scene (left) -->

      <!-- TODO: hide when the user is in '/scene/*' (check router path) -->
      <v-tooltip bottom
        v-if="designNum==1"
      >
        <template v-slot:activator="{ on }">
          <v-btn
            icon
            v-on="on"
            @click="$router.push('/scene')"
          >
            <v-icon>mdi-cube-outline</v-icon>
          </v-btn>
        </template>
        <span>3D editor</span>
      </v-tooltip>

      <v-menu
        v-if="designNum>1"
        :close-on-content-click="true"
        :offset-y="true"
        right
        bottom
      >
        <template v-slot:activator="{ on }">
          <v-btn icon v-on="on">
            <v-badge
              overlap
              :content="designNum"
            >
              <v-icon>mdi-cube-outline</v-icon>
            </v-badge>
          </v-btn>
        </template>

        <v-list>
          <v-list-item link
            v-for="(v, n) in $store.state.designs"
            :key="n"
          >
            <v-list-item-content>
              <v-list-item-title>{{v.file.name}}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list>
      </v-menu>

      <v-spacer></v-spacer>

      <!-- 3D Scene (right) -->
      <!-- TODO: hide all these buttons/menus when the user is NOT in '/scene/*' (check router path) -->

      <v-btn
        alt="Toggle stats"
        title="Toggle stats"
        icon
        @click="$store.state.scene.stats=!$store.state.scene.stats"
        :color="$store.state.scene.stats?'blue':''"
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
            v-for="(v, n) in $store.state.scene.layers"
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
              ideally, Scene should watch for changes in '$store.state.scene.layers' and toggle internal
              fields accordingly.
            -->
            <v-list-item-action>
              <v-btn
                :class="v ? 'primary--text' : ''"
                icon
                @click="$set($store.state.scene.layers, n, !v); $refs.scene.layerToggle(n)"
              >
                <v-icon>mdi-eye{{ (v==false)?'-off':''}}</v-icon>
              </v-btn>
            </v-list-item-action>
          </v-list-item>
        </v-list>
      </v-menu>
    </v-app-bar>

    <v-content>
      <router-view ref="scene"/>
    </v-content>

    <v-footer app>
      <!-- TODO:
        Add stats and status icons on the left of the footer (a la VSC)
      -->
      Hardware Studio
      <v-spacer></v-spacer>
      <v-btn icon color="red" small
        @click="$router.push('/about')"
      >
        <v-icon>mdi-heart</v-icon>
      </v-btn>
      <v-btn icon small @click="$vuetify.theme.dark=!$vuetify.theme.dark">
        <v-icon>mdi-lightbulb{{$vuetify.theme.dark?'':'-on-outline'}}</v-icon>
      </v-btn>
      <!--<span>&copy; 2020</span>-->
    </v-footer>
  </v-app>
</template>

<script>
import Vue from 'vue'

import VueResource from 'vue-resource'
Vue.use(VueResource);

import Drawer from '@/components/Drawer';

export default {
  name: 'App',
  components: {
    Drawer
  },
  data: () => ({
    drawer: false,
  }),
  created () {
    this.$vuetify.theme.dark = true;
    this.rest_alive();
  },
  computed: {
    designNum () {
      return this.$store.state.designs.length
    }
  },
  methods: {
    rest_alive () {
      this.$http.get('/api/alive')
      .then((r) => {
        if (r.status === 200) {
          console.log('Backend API is alive:', r.body)
        } else {
          console.log('Backend API alive request failed. Returned status of ' + r.status);
          this.$store.state.alive=false;
        }
      })
      .catch((err) => {
        console.log('Backend API alive check ERROR:', err.status, err.statusText)
        this.$store.state.alive=false;
      });
    },
  }
};
</script>
