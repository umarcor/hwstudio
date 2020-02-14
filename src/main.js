import Vue from 'vue';
import { sync } from 'vuex-router-sync';
import Vuetify from 'vuetify/lib';

import App from './App.vue';
import router from '@/router';
import store from '@/store';

import VueI18n from 'vue-i18n';
import i18n_en from '@/locales/en.json'
import i18n_es from '@/locales/es.json'

Vue.use(Vuetify);
Vue.use(VueI18n);

const messages = {
  en: i18n_en,
  es: i18n_es,
}

console.log(messages.es.description);

const i18n = new VueI18n({
  locale: 'en',
  messages,
})

const vuetify = new Vuetify({});

sync(store, router);

Vue.config.productionTip = false

new Vue({
  router,
  store,
  vuetify,
  i18n,
   render: h => h(App)
}).$mount('#app')
