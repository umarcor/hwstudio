import Vue from 'vue'
import Vuex from 'vuex';
import VueResource from 'vue-resource'

Vue.use(Vuex);
Vue.use(VueResource);

export default new Vuex.Store({

  // https://vuex.vuejs.org/guide/strict.html
  strict: process.env.NODE_ENV !== 'production',

  // https://vuex.vuejs.org/guide/state.html
  state: {
    alive: false,
    drawer: false,
    designs: [],
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
    }

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
    }

  },

  // https://vuex.vuejs.org/guide/actions.html
  actions: {

    checkAlive ({commit}) {
      Vue.http.get('/api/alive')
      .then((r) => {
        if (r.status === 200) {
          console.log('Backend API is alive:', r.body);
          commit('setAlive', true);
        } else {
          console.log('Backend API alive request failed. Returned status of ' + r.status);
          commit('setAlive', false);
        }
      })
      .catch((err) => {
        console.log('Backend API alive check ERROR:', err.status, err.statusText)
        commit('setAlive', false);
      });
    },

    generateBitstream () {
      // TODO: send (POST) binary (encoded) stream; a tarball; instead of JSON content
      Vue.http.get('/api/genbit')
      .then((r) => {
        if (r.status === 200) {
          console.log('Generate bitstream SUCCESS:', r.body)
        } else {
          // TODO: open a modal to show this error to the user
          console.log('Generate bitstream request failed. Returned status of ' + r.status);
        }
      })
      .catch((err) => {
        // TODO: open a modal to show this error to the user
        console.log('Generate bitstream ERROR:', err.status, err.statusText)
      });
    }

  }

});
