<template>
  <div ref="paper"></div>
</template>

<script>
import * as joint from 'jointjs';

export default {
  name: 'JointPaper',

  props: {
    width: {
      type: [String, Number],
      default: 800
    },
    height: {
      type: [String, Number],
      default: 600
    },
    gridSize: {
      type: Number,
      default: 1
    },
    drawGrid: {
      type: [Object, Boolean],
      default: false
    },
    background: {
      type: [Object, Boolean],
      default: false
    },
    readonly: {
      type: Boolean,
      default: false
    }
  },

  mounted() {
    console.log(`[${this.name}] Mounted:`, this.$refs.paper);

    const namespace = joint.shapes; // e.g. { standard: { Rectangle: RectangleElementClass }}
    this.graph = new joint.dia.Graph({ /* attributes of the graph */ }, { cellNamespace: namespace });
    this.paper = new joint.dia.Paper({
      el: this.$refs.paper,
      cellViewNamespace: namespace,
      model: this.graph,
      width: this.width,
      height: this.height,
      gridSize: this.gridSize,
      drawGrid: this.drawGrid,
      background: this.background,
      interactive: !this.readonly,
      preventContextMenu: false
    });

    this.$emit('init', this.graph);

    this.paper.on('blank:contextmenu', function(evt, x, y){
      console.log('blank:contextmenu', evt, x, y);
    });

    this.paper.on('cell:contextmenu', function(evt, x, y){
      console.log('cell:contextmenu', evt, x, y);
    });

    this.paper.on('element:contextmenu', function(evt, x, y){
      console.log('element:contextmenu', evt, x, y);
    });

    this.paper.on('link:contextmenu', function(evt, x, y){
      console.log('link:contextmenu', evt, x, y);
    });

  }
};
</script>

<style scoped>
</style>
