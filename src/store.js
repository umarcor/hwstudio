import Vue from 'vue'
import Vuex from 'vuex';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    alive: false,
    designs: [],
    scene: {
      stats: false,
      layers: [true, true, true],
    }
  },
  mutations: {},
  actions: {},
});
