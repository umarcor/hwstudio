import Vue from 'vue'
import Vuex from 'vuex';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    alive: false,
    drawer: false,
    designs: [],
    scene: {
      stats: false,
      layers: [true, true, true],
    }
  },
  mutations: {},
  actions: {},
  getters: {
    isAt: (state) => (name) => {
      return state.route.name === name
    },
    designNum: (state) => {
      return state.designs.length
    }
  }
});
