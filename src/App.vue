<template>
<!-- QUESTION: what is this id="inspire" used for? Is it required? -->
<v-app id="inspire">

  <Drawer/>

  <AppBar/>

  <v-content>
    <router-view/>
  </v-content>

  <Foot/>

    <v-navigation-drawer>
      <v-list>
        <v-list-item link title="Generate bitstream"
          @click="rest_genbit"
          v-if="$store.state.alive"
        >
          <v-list-item-action><v-icon>mdi-cube-outline</v-icon></v-list-item-action>
          <v-list-item-content><v-list-item-title>Generate bitstream</v-list-item-title></v-list-item-content>
        </v-list-item>

        <v-divider></v-divider>

        <v-list-item link title="Settings">
          <v-list-item-action><v-icon>mdi-settings</v-icon></v-list-item-action>
          <v-list-item-content><v-list-item-title>Settings</v-list-item-title></v-list-item-content>
        </v-list-item>

        <v-divider></v-divider>

        <v-list-item link :title="drawerMini?'Expand':'Collapse'"
          @click="drawerMini=!drawerMini"
        >
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

      <v-divider vertical></v-divider>

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

      <v-tooltip bottom>
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

      <v-btn
        v-for="(v, n) in $store.state.designs"
        :key="n"
      >
        {{v.file.name}}
      </v-btn>

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
      <!-- TODO:
        Add a modal to show an 'About' content, with License, link to repo, etc.
      -->
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
    <input ref="finput" v-show="false" type="file" multiple v-on:change="uploadFile">
  </v-app>
</template>

<script>
import Drawer from '@/components/Drawer';
import AppBar from '@/components/AppBar';
import Foot from '@/components/Foot';

import { mapActions } from 'vuex';

export default {
  name: 'App',
  components: {
    Drawer,
    AppBar,
    Foot
  },
  created () {
    this.$vuetify.theme.dark = true;
    this.checkAlive();
  },
  methods: {
    ...mapActions([
      'checkAlive'
    ]),
  }
};
</script>
