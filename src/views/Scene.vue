<template>
<v-layout fill-height>
  <v-layout fill-height ref="scene"/>
  <!-- FIXME:
    This is a workaround because Stats are positioned absolutely on the top-left
    Ideally, Stats would be attached to "scene"; hence this level of indentation would
    be removed, and the "ref" attribute would be applied to the parent 'v-layout'
  -->
  <div ref="stats" v-show="$store.state.scene.stats"></div>
</v-layout>
</template>

<script>
/* TODO:
  - Add multiple smaller views (side and top).
     ________ ____
    |  top   |side|
    |-------------|
    |     main    |
    |_____________|
*/

import * as THREE from "three";
import { DragControls } from 'three/examples/jsm/controls/DragControls';
//import { MapControls } from 'three/examples/jsm/controls/OrbitControls.js';
import Stats from 'three/examples/jsm/libs/stats.module';

// TODO: https://threejs.org/examples/?q=spl#webgl_geometry_spline_editor

//import { GUI } from 'three/examples/jsm/libs/dat.gui.module.js';
//import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';
//import { TransformControls } from 'three/examples/jsm/controls/TransformControls.js';

import { mapState } from 'vuex';

export default {
  name: 'Scene',
  data: () => ({
    camera: null,
    renderer: new THREE.WebGLRenderer( { antialias: true } ),
    scene: new THREE.Scene(),
    objects: [],
    stats: new Stats(),
    controls: null,
  }),
  computed: {
    ...mapState([
      'active'
    ]),
    ...mapState({
      layers: state => state.scene.layers,
    })
  },
  mounted() {
    var i;

    const el = this.$refs.scene;

    this.camera = new THREE.PerspectiveCamera(70, el.clientWidth / el.clientHeight,1, 10000);
    this.camera.position.set( 0, 2, 5 );
    // Layer 0 is for lights and other ambient objects; hence actual objects are placed in layers 1 and higher
    for ( i = 0; i <= this.layers.length; i ++ ) {
      this.camera.layers.enable( i );
    }
    // NOTE: 0 is enabled by default

    this.scene.add( this.camera );

    //?? this.renderer.setPixelRatio( window.devicePixelRatio );
    //?? renderer.setSize( window.innerWidth, window.innerHeight );

    this.renderer.setSize(el.clientWidth, el.clientHeight);
    this.renderer.shadowMap.enabled = true;
    this.renderer.shadowMap.type = THREE.PCFShadowMap;

    el.appendChild(this.renderer.domElement);

/*
    this.controls = new MapControls( this.camera, this.renderer.domElement );
    this.controls.screenSpacePanning = false;
    this.controls.minDistance = 100;
    this.controls.maxDistance = 1000;
    this.controls.maxPolarAngle = Math.PI / 2;
*/

    // FIXME:
    // The current background color is a trick to conceal the height mismatch;
    // it should be replaced with 0x808080 (or any other) when the issue with 'el.clientWidth'
    // is solved (see below)
    this.scene.background = new THREE.Color( 0x121212 );
    this.scene.add( new THREE.AmbientLight( 0x505050 ) );

    var light = new THREE.SpotLight( 0xffffff, 1.5 );
    light.layers.enable( 0 );

    light.position.set( 0, 500, 2000 );
    light.angle = Math.PI / 9;

    light.castShadow = true;
    light.shadow.camera.near = 1000;
    light.shadow.camera.far = 4000;
    light.shadow.mapSize.width = 1024;
    light.shadow.mapSize.height = 1024;

    this.scene.add( light );

    var geometry = new THREE.BoxBufferGeometry( 40, 40, 40 );

    for ( i = 0; i < 3; i ++ ) {
      var object = new THREE.Mesh(
        geometry,
        new THREE.MeshLambertMaterial( { color: Math.random() * 0xffffff } )
      );

      object.position.set(
        Math.random() * 10 - 5,
        Math.random() * 5 - 2.5,
        Math.random() * 4 - 2
      );

      object.rotation.set(
        Math.random() * 2 * Math.PI,
        Math.random() * 2 * Math.PI,
        Math.random() * 2 * Math.PI
      );

      object.scale.set(
        Math.random() * .049 + .001,
        Math.random() * .049 + .001,
        Math.random() * .049 + .001
      );

      object.castShadow = true;
      object.receiveShadow = true;
      object.layers.set((i % this.layers.length)+1);

      this.scene.add( object );
      this.objects.push( object );
    }

    // FIXME: objects in non-visible layer can be dragged! Those should not be viewable/pickable with DragControls!
    var controls = new DragControls( this.objects, this.camera, this.renderer.domElement );

    controls.addEventListener( 'dragstart', function ( event ) {
      event.object.material.emissive.set( 0xaaaaaa );
    });

    controls.addEventListener( 'dragend', function ( event ) {
      event.object.material.emissive.set( 0x000000 );
    });

    this.$refs.stats.appendChild( this.stats.dom );

    const animate = () => {
      requestAnimationFrame(animate);
      for ( var i = 0; i < 3; i ++ ) {
        this.objects[i].rotation.x += 0.025;
        this.objects[i].rotation.y += 0.025;
      }
      this.renderer.render(this.scene, this.camera);
      if ( this.$store.state.scene.stats ) {
        this.stats.update();
      }
    };

    animate();

    // TODO: is the a more idiomatic way to do this in Vue?
    window.addEventListener( 'resize', this.onWindowResize, false );
  },
  methods: {
    loadJSON (jobj) {
      var loader = new THREE.ObjectLoader();
      this.scene.add(loader.parse(jobj));
    },
    layerAll (bool) {
      if (bool) {
        this.camera.layers.enableAll();
      } else {
        this.camera.layers.disableAll();
      }
    },
    onWindowResize () {
      const el = this.$refs.scene;
      if ( el != undefined ) {
      const w = el.clientWidth;
      /* FIXME:
         With el.clientWidth, the Scene grows vertically non-stop
         however, window.innerHeight seems to be larger than required
      */
      //const h = el.clientWidth;
      const h = window.innerHeight;

      this.camera.aspect = w / h;
      this.camera.updateProjectionMatrix();
      this.renderer.setSize( w, h );
      }
    }
  },
  watch: {
    active: function(v, o) {
      console.log('active', v, o);
      this.loadJSON(JSON.parse(this.$store.getters.design(v).content));
    },
    layers: function (v) {
      /*
        https://vuejs.org/v2/api/#vm-watch
        Note: when mutating (rather than replacing) an Object or an Array, the old value will be the same as new value...

        There might be some other mechanism to toggle the desired layer only ('this.camera.layers.toggle(num+1)'),
        instead of looping through all of them. Meanwhile, this works.
      */
      v.forEach((b, i) => {
        this.camera.layers[b?'enable':'disable'](i+1);
      });
    }
  }

}
</script>
