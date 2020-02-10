import Vue from "vue";
import Router from "vue-router";

import Home from "@/views/Home";
import About from "@/views/About";
import Scene from "@/views/Scene";
import Grid from "@/views/Grid";
import NotFound from "@/views/NotFound";

Vue.use(Router);

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
      path: "/grid",
      name: "grid",
      component: Grid
    },
    {
      path: "*",
      name: "notfound",
      component: NotFound
    }
  ]
});
