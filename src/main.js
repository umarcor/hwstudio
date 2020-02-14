import Vue from 'vue';
import { sync } from 'vuex-router-sync';
import Vuetify from 'vuetify/lib';

import App from './App.vue';
import router from '@/router';
import store from '@/store';

sync(store, router);

Vue.use(Vuetify);

const vuetify = new Vuetify({});

Vue.config.productionTip = false

new Vue({
  router,
  store,
  vuetify,
  render: h => h(App)
}).$mount('#app')
