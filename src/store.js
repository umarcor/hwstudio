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
    scene: {
      stats: false,
      layers: [true, true, true],
    }
  },

  // https://vuex.vuejs.org/guide/mutations.html
  mutations: {},

  // https://vuex.vuejs.org/guide/actions.html
  actions: {},

  // https://vuex.vuejs.org/guide/getters.html
  getters: {
    isAt: (state) => (name) => {
      return state.route.name === name
    },
    designNum: (state) => {
      return state.designs.length
    }
  }
});
