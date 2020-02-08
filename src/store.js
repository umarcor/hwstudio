import Vue from 'vue'
import Vuex from 'vuex';
//import HelloWorld from '@/components/HelloWorld';

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
