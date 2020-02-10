import axios from 'axios';

import Vue from 'vue'
import Vuex from 'vuex';

Vue.use(Vuex);

export default new Vuex.Store({

  // https://vuex.vuejs.org/guide/strict.html
  strict: process.env.NODE_ENV !== 'production',

  // https://vuex.vuejs.org/guide/state.html
  state: {
    alive: false,
    drawer: false,
    designs: [],
    active: null,
    scene: {
      stats: false,
      layers: [true, true, true],
    }
  },

  // https://vuex.vuejs.org/guide/getters.html
  getters: {

    isAt: (state) => (name) => {
      return state.route.name === name
    },

    designNum: (state) => {
      return state.designs.length
    },

    design: (state) => (id) => {
      return state.designs[id]
    },

  },

  // https://vuex.vuejs.org/guide/mutations.html
  mutations: {

    setAlive (state, b) {
      state.alive = b;
    },

    toggleDrawer (state) {
      state.drawer = !state.drawer;
    },

    toggleStats (state) {
      state.scene.stats = !state.scene.stats;
    },

    toggleLayer (state, n) {
      Vue.set(state.scene.layers, n, !state.scene.layers[n]);
    },

    addLayer (state) {
      state.scene.layers.push(true);
    },

    addDesign (state, design) {
      state.designs.push(design);
      state.active=state.designs.length-1;
    }

  },

  // https://vuex.vuejs.org/guide/actions.html
  actions: {

    checkAlive ({commit}) {
      axios.get('/api/alive')
      .then(function (r) {
        if (r.status === 200) {
          console.log('Backend API is alive:', r.data);
          commit('setAlive', true);
        } else {
          console.log('Backend API alive request failed. Returned status of ' + r.status);
          commit('setAlive', false);
        }
      })
      .catch(function (err) {
        console.log('Backend API alive check ERROR:', err)
        commit('setAlive', false);
      });
    },

    generateBitstream () {
      // TODO: send (POST) binary (encoded) stream; a tarball; instead of JSON content
      axios.get('/api/genbit')
      .then(function (r) {
        if (r.status === 200) {
          console.log('Generate bitstream SUCCESS:', r.data)
        } else {
          // TODO: open a modal to show this error to the user
          console.log('Generate bitstream request failed. Returned status of ' + r.status);
        }
      })
      .catch(function (err) {
      // TODO: open a modal to show this error to the user
      console.log('Generate bitstream ERROR:', err)
      });
    },

  }

});
