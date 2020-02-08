import Vue from "vue";
import Router from "vue-router";
import Home from "@/views/Home";
import About from "@/views/About";
import Scene from "@/views/Scene";
import NotFound from "@/views/NotFound";

Vue.use(Router);

/* FIXME:
  Currently, an error is reported to the console when trying to push the same path that is active;
  for example, when clicking the 'heart' button from '/about' or the 'dashboard' button from '/home'.
  Buttons should be conditionally disabled/hidden, or the router should be configured, or...
*/

export default new Router({
  mode: "history",
  base: process.env.BASE_URL || './',
  routes: [
    {
      path: "/",
      name: "home",
      component: Home
    },
    {
      path: "/about",
      name: "about",
      component: About
    },
    {
      path: "/scene",
      name: "scene",
      component: Scene
    },
    {
      path: "*",
      name: "notfound",
      component: NotFound
    }
  ]
});
