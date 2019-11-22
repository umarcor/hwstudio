<template>
  <v-app>
    <v-app-bar
      app
      color="primary"
      dark
    >
      <div class="d-flex align-center">
        <v-img
          alt="Vuetify Logo"
          class="shrink mr-2"
          contain
          src="https://cdn.vuetifyjs.com/images/logos/vuetify-logo-dark.png"
          transition="scale-transition"
          width="40"
        />

        <v-img
          alt="Vuetify Name"
          class="shrink mt-1 hidden-sm-and-down"
          contain
          min-width="100"
          src="https://cdn.vuetifyjs.com/images/logos/vuetify-name-dark.png"
          width="100"
        />
      </div>

      <v-spacer></v-spacer>

      <v-btn
        href="https://github.com/vuetifyjs/vuetify/releases/latest"
        target="_blank"
        text
      >
        <span class="mr-2">Latest Release</span>
        <v-icon>mdi-open-in-new</v-icon>
      </v-btn>
    </v-app-bar>

    <v-content>
      <joint-paper
        :background="background"
        width="auto"
        :grid-size="gridSize"
        :draw-grid="drawGrid"
        @init="setupGraph"
      />
      <HelloWorld/>
    </v-content>

  </v-app>
</template>

<script>
import * as joint from 'jointjs';

import JointPaper from '@/components/JointPaper';
import HelloWorld from '@/components/HelloWorld';

export default {
  name: 'App',

  components: {
    HelloWorld,
    JointPaper
  },

  data: () => ({
    background: {
      color: 'antiquewhite'
    },
    gridSize: 1,
    //drawGrid: {
    //  name: 'mesh'
    //}
    drawGrid: false
  }),

  methods: {
    setupGraph(graph) {

      const rect = new joint.shapes.standard.Rectangle();
      rect.position(100, 30);
      rect.resize(100, 40);
      rect.attr({
        body: {
          fill: 'blue'
        },
        label: {
          text: 'Hello',
          fill: 'white'
        }
      });
      rect.addTo(graph);
      const rect2 = rect.clone();
      rect2.translate(300, 0);
      rect2.attr('label/text', 'World!');
      rect2.addTo(graph);
      const link = new joint.shapes.standard.Link();
      link.source(rect);
      link.target(rect2);
      link.addTo(graph);

      console.log(JSON.stringify(graph.toJSON()));

      //graph.fromJSON(graph.toJSON());

      graph.fromJSON({
        cells: [{
          //id: 1,
          type: 'standard.Rectangle',
          position: {
            x: 100,
            y: 100
          },
          size: {
            width: 100,
            height: 100
          },
          angle: 0,
          id: "29f8c4ab-9a42-42d3-a408-37a44c44c59c",
          z: 1,
          attrs: {
            body: {
              fill: "blue"
            },
            label: {
              fill: "white",
              text: "Hello"
            }
          }
        }]
      });

    }
  }
};
</script>
