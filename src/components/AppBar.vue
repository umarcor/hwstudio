<template>
<v-app-bar
  app
  dense
>
  <!-- TODO:
    Add the (fancy) logo; can the hamburguer icon be replaced?
  -->
  <template v-if="!drawer">
  <v-app-bar-nav-icon @click.stop="toggleDrawer" />
  <v-divider vertical/>
  </template>

  <!-- DASHBOARD -->

  <v-tooltip bottom v-if="!isAt('home')">
    <template v-slot:activator="{ on }">
      <v-btn icon v-on="on" to="/" exact>
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

  <v-tooltip bottom v-if="designs.length==1 && !isAt('scene')">
    <template v-slot:activator="{ on }">
      <v-btn icon v-on="on" to="/scene">
        <v-icon>mdi-cube-outline</v-icon>
      </v-btn>
    </template>
    <span>3D editor</span>
  </v-tooltip>

  <!-- FIXME:
    This button/menu jumps to the right when changing to a different section.
    Instead, the location (on the left of the spacer) shoul be preserved.
  -->
  <v-menu
    v-if="designs.length>1"
    :close-on-content-click="true"
    :offset-y="true"
    right
    bottom
  >
    <template v-slot:activator="{ on }">
      <v-btn icon v-on="on">
        <v-badge overlap :content="designs.length">
          <v-icon>mdi-cube-outline</v-icon>
        </v-badge>
      </v-btn>
    </template>
    <v-list>
      <v-list-item link v-for="(v, n) in designs" :key="n">
        <v-list-item-content>
          <v-list-item-title>{{v.file.name}}</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
  </v-menu>

  <v-spacer></v-spacer>

  <!-- Language selector -->
  <v-select
    :items="Object.keys($i18n.messages)"
    label="Language"
    v-model="$i18n.locale"
  ></v-select>

  <!-- 3D Scene (right) -->

  <template v-if="isAt('scene')">
    <v-tooltip bottom>
      <template v-slot:activator="{ on }">
        <v-btn
          icon
          v-on="on"
          @click="toggleStats"
          :color="stats?'blue':''"
        >
          <v-icon>mdi-chart-histogram</v-icon>
        </v-btn>
      </template>
      <span>Toggle render stats</span>
    </v-tooltip>

    <v-menu
      :close-on-content-click="false"
      :offset-y="true"
      left
      bottom
    >
      <template v-slot:activator="{ on }">
        <v-btn icon v-on="on">
          <v-badge overlap :content="layers.length">
            <v-icon>mdi-layers-triple</v-icon>
          </v-badge>
        </v-btn>
      </template>

      <v-list>
        <v-list-item v-for="(v, n) in layers" :key="n">
          <!--
          <v-list-item-avatar>
            <img src="https://cdn.vuetifyjs.com/images/john.jpg" alt="John">
          </v-list-item-avatar>
          -->
          <v-list-item-content>
            <v-list-item-title>{{$t("layer", {n: n})}}</v-list-item-title>
          </v-list-item-content>
          <v-list-item-action>
            <v-btn icon small
              :class="v ? 'primary--text' : ''"
              @click="toggleLayer(n)"
            >
              <v-icon>mdi-eye{{ (v==false)?'-off':''}}</v-icon>
            </v-btn>
          </v-list-item-action>
        </v-list-item>
        <v-list-item>
          <v-list-item-content>
            <v-list-item-title>{{$t("addLayer")}}</v-list-item-title>
          </v-list-item-content>
          <v-list-item-action>
            <v-btn icon small @click="addLayer()">
              <v-icon>mdi-plus</v-icon>
            </v-btn>
          </v-list-item-action>
        </v-list-item>
      </v-list>
    </v-menu>
  </template>
</v-app-bar>
</template>

<script>
import { mapState, mapGetters, mapMutations } from 'vuex';

export default {
  name: 'AppBar',
  computed: {
    ...mapState([
      'drawer',
      'designs',
    ]),
    ...mapState({
      stats: 'scene.stats',
      layers: state => state.scene.layers,
    }),
    ...mapGetters([
      'isAt'
    ])
  },
  methods: {
    ...mapMutations([
      'toggleDrawer',
      'toggleStats',
      'toggleLayer',
      'addLayer',
    ]),
  }
};
</script>
