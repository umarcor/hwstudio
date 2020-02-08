<template>
<v-app-bar
  app
>
  <!-- TODO:
    Add the (fancy) logo; can the hamburguer icon be replaced?
  -->
  <template v-if="!$store.state.drawer">
  <v-app-bar-nav-icon
    @click.stop="$store.state.drawer = !$store.state.drawer"
  />

  <v-divider vertical></v-divider>
  </template>

  <!-- DASHBOARD -->

  <v-tooltip bottom
    v-if="!$store.getters.isAt('home')"
  >
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

  <v-tooltip bottom
    v-if="$store.getters.designNum==1 && !$store.getters.isAt('scene')"
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

  <!-- FIXME:
    This button/menu jumps to the right when changing to a different section.
    Instead, the location (on the left of the spacer) shoul be preserved.
  -->
  <v-menu
    v-if="$store.getters.designNum>1"
    :close-on-content-click="true"
    :offset-y="true"
    right
    bottom
  >
    <template v-slot:activator="{ on }">
      <v-btn icon v-on="on">
        <v-badge
          overlap
          :content="$store.getters.designNum"
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

  <template v-if="$store.getters.isAt('scene')">
    <v-tooltip bottom>
      <template v-slot:activator="{ on }">
        <v-btn
          icon
          v-on="on"
          @click="$store.state.scene.stats=!$store.state.scene.stats"
          :color="$store.state.scene.stats?'blue':''"
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
          <v-badge
            overlap
            :content="$store.state.scene.layers.length"
          >
            <v-icon>mdi-layers-triple</v-icon>
          </v-badge>
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
          <v-list-item-action>
            <v-btn
              :class="v ? 'primary--text' : ''"
              icon
              @click="$set($store.state.scene.layers, n, !v); $emit('layerToggle', n)"
            >
              <v-icon>mdi-eye{{ (v==false)?'-off':''}}</v-icon>
            </v-btn>
          </v-list-item-action>
        </v-list-item>
      </v-list>
    </v-menu>
  </template>
</v-app-bar>
</template>

<script>
export default {
  name: 'AppBar',
};
</script>