(function(t){function e(e){for(var n,r,o=e[0],l=e[1],c=e[2],d=0,u=[];d<o.length;d++)r=o[d],Object.prototype.hasOwnProperty.call(i,r)&&i[r]&&u.push(i[r][0]),i[r]=0;for(n in l)Object.prototype.hasOwnProperty.call(l,n)&&(t[n]=l[n]);v&&v(e);while(u.length)u.shift()();return s.push.apply(s,c||[]),a()}function a(){for(var t,e=0;e<s.length;e++){for(var a=s[e],n=!0,o=1;o<a.length;o++){var l=a[o];0!==i[l]&&(n=!1)}n&&(s.splice(e--,1),t=r(r.s=a[0]))}return t}var n={},i={app:0},s=[];function r(e){if(n[e])return n[e].exports;var a=n[e]={i:e,l:!1,exports:{}};return t[e].call(a.exports,a,a.exports,r),a.l=!0,a.exports}r.m=t,r.c=n,r.d=function(t,e,a){r.o(t,e)||Object.defineProperty(t,e,{enumerable:!0,get:a})},r.r=function(t){"undefined"!==typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},r.t=function(t,e){if(1&e&&(t=r(t)),8&e)return t;if(4&e&&"object"===typeof t&&t&&t.__esModule)return t;var a=Object.create(null);if(r.r(a),Object.defineProperty(a,"default",{enumerable:!0,value:t}),2&e&&"string"!=typeof t)for(var n in t)r.d(a,n,function(e){return t[e]}.bind(null,n));return a},r.n=function(t){var e=t&&t.__esModule?function(){return t["default"]}:function(){return t};return r.d(e,"a",e),e},r.o=function(t,e){return Object.prototype.hasOwnProperty.call(t,e)},r.p="/hwstudio/vue-three/";var o=window["webpackJsonp"]=window["webpackJsonp"]||[],l=o.push.bind(o);o.push=e,o=o.slice();for(var c=0;c<o.length;c++)e(o[c]);var v=l;s.push([0,"chunk-vendors"]),a()})({0:function(t,e,a){t.exports=a("56d7")},"078e":function(t,e,a){t.exports=a.p+"img/logo_light.efd1be0c.svg"},"56d7":function(t,e,a){"use strict";a.r(e);a("e260"),a("e6cf"),a("cca6"),a("a79d"),a("a4d3"),a("e01a");var n=a("2b0e"),i=a("31bd"),s=a("f309"),r=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("v-app",{attrs:{id:"inspire"}},[a("Drawer"),a("AppBar"),a("v-content",[a("router-view")],1),a("Foot")],1)},o=[],l=a("5530"),c=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("v-navigation-drawer",{attrs:{"mini-variant":t.drawerMini,"disable-route-watcher":!0,app:"","overlay-color":"primary"},scopedSlots:t._u([t.drawerMini?null:{key:"append",fn:function(){return[a("v-alert",{staticClass:"ml-2 mr-2 caption text-center",attrs:{type:"warning",prominent:"",dense:"",outlined:""}},[t._v(" This tool is a proof of concept; expect breaking changes! ")])]},proxy:!0}],null,!0),model:{value:t.$store.state.drawer,callback:function(e){t.$set(t.$store.state,"drawer",e)},expression:"$store.state.drawer"}},[a("v-list",{staticClass:"pt-0 pb-0",attrs:{dense:""}},[t.drawerMini?a("v-tooltip",{attrs:{right:""},scopedSlots:t._u([{key:"activator",fn:function(e){var n=e.on;return[a("v-list-item",t._g({attrs:{link:""},on:{click:t.toggleDrawer}},n),[a("v-list-item-action",[a("v-icon",[t._v("mdi-close")])],1),a("v-list-item-content")],1)]}}],null,!1,2931725044)},[a("span",[t._v(t._s(t.$t("closeMenu")))])]):t._e(),t.drawerMini?t._e():a("v-list-item",{attrs:{link:""},on:{click:t.toggleDrawer}},[a("v-list-item-action",[a("v-icon",[t._v("mdi-close")])],1),a("v-list-item-content",[a("v-list-item-title",[t._v(t._s(t.$t("closeMenu")))])],1)],1),a("v-divider"),t.drawerMini?a("v-tooltip",{attrs:{right:""},scopedSlots:t._u([{key:"activator",fn:function(e){var n=e.on;return[a("v-list-item",t._g({attrs:{link:""},on:{click:t.newDesign}},n),[a("v-list-item-action",[a("v-icon",[t._v("mdi-file-outline")])],1),a("v-list-item-content")],1)]}}],null,!1,1592091714)},[a("span",[t._v(t._s(t.$t("newDesign")))])]):t._e(),t.drawerMini?t._e():a("v-list-item",{attrs:{link:""},on:{click:t.newDesign}},[a("v-list-item-action",[a("v-icon",[t._v("mdi-file-outline")])],1),a("v-list-item-content",[a("v-list-item-title",[t._v(t._s(t.$t("newDesign")))])],1)],1),t.drawerMini?a("v-tooltip",{attrs:{right:""},scopedSlots:t._u([{key:"activator",fn:function(e){var n=e.on;return[a("v-list-item",t._g({attrs:{link:""},on:{click:t.uploadTrigger}},n),[a("v-list-item-action",[a("v-icon",[t._v("mdi-upload")])],1),a("v-list-item-content")],1)]}}],null,!1,2322897503)},[a("span",[t._v(t._s(t.$t("loadImport")))])]):t._e(),t.drawerMini?t._e():a("v-list-item",{attrs:{link:""},on:{click:t.uploadTrigger}},[a("v-list-item-action",[a("v-icon",[t._v("mdi-upload")])],1),a("v-list-item-content",[a("v-list-item-title",[t._v(t._s(t.$t("loadImport")))])],1)],1),a("v-divider"),a("v-list-item",{attrs:{link:"",disabled:""}},[a("v-list-item-action",[a("v-icon",{attrs:{disabled:""}},[t._v("mdi-content-save")])],1),a("v-list-item-content",[a("v-list-item-title",[t._v("Save")])],1)],1),a("v-list-item",{attrs:{link:"",disabled:""}},[a("v-list-item-action",[a("v-icon",{attrs:{disabled:""}},[t._v("mdi-content-save-all")])],1),a("v-list-item-content",[a("v-list-item-title",[t._v("Save As...")])],1)],1),a("v-list-item",{attrs:{link:"",disabled:""}},[a("v-list-item-action",[a("v-icon",{attrs:{disabled:""}},[t._v("mdi-download")])],1),a("v-list-item-content",[a("v-list-item-title",[t._v("Download... | Export...")])],1)],1),a("v-divider"),t.drawerMini&&t.alive?a("v-tooltip",{attrs:{right:""},scopedSlots:t._u([{key:"activator",fn:function(e){var n=e.on;return[a("v-list-item",t._g({attrs:{link:""},on:{click:t.generateBitstream}},n),[a("v-list-item-action",[a("v-icon",[t._v("mdi-package")])],1),a("v-list-item-content")],1)]}}],null,!1,691347381)},[a("span",[t._v("Generate bitstream")])]):t._e(),!t.drawerMini&&t.alive?a("v-list-item",{attrs:{link:""},on:{click:t.generateBitstream}},[a("v-list-item-action",[a("v-icon",[t._v("mdi-package")])],1),a("v-list-item-content",[a("v-list-item-title",[t._v("Generate bitstream")])],1)],1):t._e(),t.alive?a("v-divider"):t._e(),a("v-list-item",{attrs:{link:"",disabled:""}},[a("v-list-item-action",[a("v-icon",{attrs:{disabled:""}},[t._v("mdi-settings")])],1),a("v-list-item-content",[a("v-list-item-title",[t._v("Settings")])],1)],1),a("v-divider"),t.drawerMini?a("v-tooltip",{attrs:{right:""},scopedSlots:t._u([{key:"activator",fn:function(e){var n=e.on;return[a("v-list-item",t._g({attrs:{link:""},on:{click:function(e){t.drawerMini=!t.drawerMini}}},n),[a("v-list-item-action",[a("v-icon",[t._v("mdi-arrow-expand-right")])],1),a("v-list-item-content")],1)]}}],null,!1,1516895657)},[a("span",[t._v("Expand")])]):t._e(),t.drawerMini?t._e():a("v-list-item",{attrs:{link:""},on:{click:function(e){t.drawerMini=!t.drawerMini}}},[a("v-list-item-action",[a("v-icon",[t._v("mdi-arrow-collapse-left")])],1),a("v-list-item-content",[a("v-list-item-title",[t._v("Collapse")])],1)],1)],1),a("input",{directives:[{name:"show",rawName:"v-show",value:!1,expression:"false"}],ref:"finput",attrs:{type:"file",multiple:""},on:{change:t.uploadFile}})],1)},v=[],d=(a("159b"),a("2f62")),u={name:"Drawer",data:function(){return{drawerMini:!0}},computed:Object(l["a"])({},Object(d["e"])(["alive"])),methods:Object(l["a"])(Object(l["a"])({},Object(d["d"])(["toggleDrawer"])),{},{uploadTrigger:function(){this.$refs["finput"].click()},uploadFile:function(t){var e=this;t.target.files.forEach((function(t){console.log(t);var a=new FileReader;a.onload=function(e){console.log(e),this.$store.commit("addDesign",{file:t,content:e.target.result})}.bind(e),a.readAsText(t)}))},newDesign:function(){this.$router.push("/scene")}},Object(d["b"])(["generateBitstream"]))},m=u,p=a("2877"),h=a("6544"),f=a.n(h),g=a("0798"),_=a("ce7e"),b=a("132d"),w=a("8860"),y=a("da13"),k=a("1800"),j=a("5d23"),V=a("f774"),C=a("3a2f"),O=Object(p["a"])(m,c,v,!1,null,null,null),S=O.exports;f()(O,{VAlert:g["a"],VDivider:_["a"],VIcon:b["a"],VList:w["a"],VListItem:y["a"],VListItemAction:k["a"],VListItemContent:j["a"],VListItemTitle:j["b"],VNavigationDrawer:V["a"],VTooltip:C["a"]});var M=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("v-app-bar",{attrs:{app:"",dense:""}},[t.drawer?t._e():[a("v-app-bar-nav-icon",{on:{click:function(e){return e.stopPropagation(),t.toggleDrawer(e)}}}),a("v-divider",{attrs:{vertical:""}})],t.isAt("home")?t._e():a("v-tooltip",{attrs:{bottom:""},scopedSlots:t._u([{key:"activator",fn:function(e){var n=e.on;return[a("v-btn",t._g({attrs:{icon:"",to:"/",exact:""}},n),[a("v-icon",[t._v("mdi-view-dashboard")])],1)]}}],null,!1,2847780636)},[a("span",[t._v("Dashboard")])]),1!=t.designs.length||t.isAt("scene")?t._e():a("v-tooltip",{attrs:{bottom:""},scopedSlots:t._u([{key:"activator",fn:function(e){var n=e.on;return[a("v-btn",t._g({attrs:{icon:"",to:"/scene"}},n),[a("v-icon",[t._v("mdi-cube-outline")])],1)]}}],null,!1,1060133831)},[a("span",[t._v("3D editor")])]),t.designs.length>1?a("v-menu",{attrs:{"close-on-content-click":!0,"offset-y":!0,right:"",bottom:""},scopedSlots:t._u([{key:"activator",fn:function(e){var n=e.on;return[a("v-btn",t._g({attrs:{icon:""}},n),[a("v-badge",{attrs:{overlap:"",content:t.designs.length}},[a("v-icon",[t._v("mdi-cube-outline")])],1)],1)]}}],null,!1,1569469276)},[a("v-list",t._l(t.designs,(function(e,n){return a("v-list-item",{key:n,attrs:{link:""}},[a("v-list-item-content",[a("v-list-item-title",[t._v(t._s(e.file.name))])],1)],1)})),1)],1):t._e(),a("v-spacer"),a("v-select",{attrs:{items:Object.keys(t.$i18n.messages),label:"Language"},model:{value:t.$i18n.locale,callback:function(e){t.$set(t.$i18n,"locale",e)},expression:"$i18n.locale"}}),t.isAt("scene")?[a("v-tooltip",{attrs:{bottom:""},scopedSlots:t._u([{key:"activator",fn:function(e){var n=e.on;return[a("v-btn",t._g({attrs:{icon:"",color:t.stats?"blue":""},on:{click:t.toggleStats}},n),[a("v-icon",[t._v("mdi-chart-histogram")])],1)]}}],null,!1,3136053969)},[a("span",[t._v("Toggle render stats")])]),a("v-menu",{attrs:{"close-on-content-click":!1,"offset-y":!0,left:"",bottom:""},scopedSlots:t._u([{key:"activator",fn:function(e){var n=e.on;return[a("v-btn",t._g({attrs:{icon:""}},n),[a("v-badge",{attrs:{overlap:"",content:t.layers.length}},[a("v-icon",[t._v("mdi-layers-triple")])],1)],1)]}}],null,!1,199037466)},[a("v-list",[t._l(t.layers,(function(e,n){return a("v-list-item",{key:n},[a("v-list-item-content",[a("v-list-item-title",[t._v(t._s(t.$t("layer",{n:n})))])],1),a("v-list-item-action",[a("v-btn",{class:e?"primary--text":"",attrs:{icon:"",small:""},on:{click:function(e){return t.toggleLayer(n)}}},[a("v-icon",[t._v("mdi-eye"+t._s(0==e?"-off":""))])],1)],1)],1)})),a("v-list-item",[a("v-list-item-content",[a("v-list-item-title",[t._v(t._s(t.$t("addLayer")))])],1),a("v-list-item-action",[a("v-btn",{attrs:{icon:"",small:""},on:{click:function(e){return t.addLayer()}}},[a("v-icon",[t._v("mdi-plus")])],1)],1)],1)],2)],1)]:t._e()],2)},$=[],x={name:"AppBar",computed:Object(l["a"])(Object(l["a"])(Object(l["a"])({},Object(d["e"])(["drawer","designs"])),Object(d["e"])({stats:"scene.stats",layers:function(t){return t.scene.layers}})),Object(d["c"])(["isAt"])),methods:Object(l["a"])({},Object(d["d"])(["toggleDrawer","toggleStats","toggleLayer","addLayer"]))},A=x,I=a("40dc"),L=a("5bc1"),D=a("4ca6"),E=a("8336"),P=a("e449"),B=a("b974"),R=a("2fa4"),T=Object(p["a"])(A,M,$,!1,null,null,null),N=T.exports;f()(T,{VAppBar:I["a"],VAppBarNavIcon:L["a"],VBadge:D["a"],VBtn:E["a"],VDivider:_["a"],VIcon:b["a"],VList:w["a"],VListItem:y["a"],VListItemAction:k["a"],VListItemContent:j["a"],VListItemTitle:j["b"],VMenu:P["a"],VSelect:B["a"],VSpacer:R["a"],VTooltip:C["a"]});var F=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("v-footer",{attrs:{app:""}},[t.isAt("home")||t.isAt("about")?t._e():[t._v(" Hardware Studio ")],a("v-spacer"),a("v-btn",{attrs:{icon:"",small:"",disabled:t.isAt("about"),color:"red",to:"/about"}},[a("v-icon",[t._v("mdi-heart")])],1),a("v-btn",{attrs:{icon:"",small:""},on:{click:function(e){t.$vuetify.theme.dark=!t.$vuetify.theme.dark}}},[a("v-icon",[t._v("mdi-lightbulb"+t._s(t.$vuetify.theme.dark?"":"-on-outline"))])],1)],2)},z=[],H={name:"Foot",computed:Object(l["a"])({},Object(d["c"])(["isAt"]))},G=H,W=a("553a"),J=Object(p["a"])(G,F,z,!1,null,null,null),q=J.exports;f()(J,{VBtn:E["a"],VFooter:W["a"],VIcon:b["a"],VSpacer:R["a"]});var U={name:"App",components:{Drawer:S,AppBar:N,Foot:q},created:function(){this.$vuetify.theme.dark=!0,this.checkAlive()},methods:Object(l["a"])({},Object(d["b"])(["checkAlive"]))},K=U,Q=a("7496"),X=a("a75b"),Y=Object(p["a"])(K,r,o,!1,null,null,null),Z=Y.exports;f()(Y,{VApp:Q["a"],VContent:X["a"]});var tt=a("8c4f"),et=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("v-container",{attrs:{"fill-height":"",fluid:""}},[a("v-row",{staticClass:"mt-auto flex-column",attrs:{"no-gutters":""}},[a("v-col",[a("h1",{staticClass:"display-3 font-weight-bold mb-5",attrs:{align:"center"}},[t._v(" Hardware Studio ")])]),a("v-col",[a("h2",{staticClass:"title mb-5",attrs:{align:"center"}},[t._v(" "+t._s(t.$t("description"))+" ")])])],1),a("v-row",{staticClass:"mb-auto",attrs:{justify:"center","no-gutters":""}},[a("v-col",{staticClass:"shrink"},[a("v-tooltip",{attrs:{right:""},scopedSlots:t._u([{key:"activator",fn:function(e){var n=e.on;return[a("v-btn",t._g({attrs:{href:"https://github.com/umarcor/hwstudio",icon:"",large:"",target:"_blank"}},n),[a("v-icon",{attrs:{large:""}},[t._v("mdi-code-tags")])],1)]}}])},[a("span",[t._v("Source: github.com/umarcor/hwstudio")])]),a("v-tooltip",{attrs:{right:""},scopedSlots:t._u([{key:"activator",fn:function(e){var n=e.on;return[a("v-btn",t._g({attrs:{icon:"",large:"",to:"/scene"}},n),[a("v-icon",{attrs:{large:""}},[t._v("mdi-cube-outline")])],1)]}}])},[a("span",[t._v("Open demo scene")])])],1)],1)],1)},at=[],nt={name:"Home"},it=nt,st=a("62ad"),rt=a("a523"),ot=a("0fd9"),lt=Object(p["a"])(it,et,at,!1,null,null,null),ct=lt.exports;f()(lt,{VBtn:E["a"],VCol:st["a"],VContainer:rt["a"],VIcon:b["a"],VRow:ot["a"],VTooltip:C["a"]});var vt=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("v-container",{attrs:{"fill-height":"",fluid:""}},[n("v-row",{staticClass:"mt-auto",attrs:{"no-gutters":""}},[n("v-img",{attrs:{src:t.$vuetify.theme.dark?a("078e"):a("a70b"),contain:"",height:"200"}})],1),n("v-row",{staticClass:"mb-auto",attrs:{justify:"center","no-gutters":""}},[n("h1",{staticClass:"display-3 font-weight-bold mt-10",attrs:{align:"center"}},[t._v(" Hardware Studio ")])])],1)},dt=[],ut={name:"About"},mt=ut,pt=a("adda"),ht=Object(p["a"])(mt,vt,dt,!1,null,null,null),ft=ht.exports;f()(ht,{VContainer:rt["a"],VImg:pt["a"],VRow:ot["a"]});var gt=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("v-layout",{attrs:{"fill-height":""}},[a("v-layout",{ref:"scene",attrs:{"fill-height":""}}),a("div",{directives:[{name:"show",rawName:"v-show",value:t.$store.state.scene.stats,expression:"$store.state.scene.stats"}],ref:"stats"})],1)},_t=[],bt=a("5a89"),wt=a("23ee"),yt=a("ef20"),kt={name:"Scene",data:function(){return{camera:null,renderer:new bt["p"]({antialias:!0}),scene:new bt["l"],objects:[],stats:new yt["a"],controls:null}},computed:Object(l["a"])({},Object(d["e"])({layers:function(t){return t.scene.layers}})),mounted:function(){var t,e=this,a=this.$refs.scene;for(this.camera=new bt["i"](70,a.clientWidth/a.clientHeight,1,1e4),this.camera.position.set(0,0,900),t=0;t<=this.layers.length;t++)this.camera.layers.enable(t);this.scene.add(this.camera),this.renderer.setSize(a.clientWidth,a.clientHeight),this.renderer.shadowMap.enabled=!0,this.renderer.shadowMap.type=bt["h"],a.appendChild(this.renderer.domElement),this.scene.background=new bt["c"](1184274),this.scene.add(new bt["a"](5263440));var n=new bt["m"](16777215,1.5);n.layers.enable(0),n.position.set(0,500,2e3),n.angle=Math.PI/9,n.castShadow=!0,n.shadow.camera.near=1e3,n.shadow.camera.far=4e3,n.shadow.mapSize.width=1024,n.shadow.mapSize.height=1024,this.scene.add(n);var i=new bt["b"](40,40,40);for(t=0;t<50;t++){var s=new bt["f"](i,new bt["g"]({color:16777215*Math.random()}));s.position.set(1e3*Math.random()-500,600*Math.random()-300,800*Math.random()-400),s.rotation.set(2*Math.random()*Math.PI,2*Math.random()*Math.PI,2*Math.random()*Math.PI),s.scale.set(2*Math.random()+1,2*Math.random()+1,2*Math.random()+1),s.castShadow=!0,s.receiveShadow=!0,s.layers.set(t%this.layers.length+1),this.scene.add(s),this.objects.push(s)}var r=new wt["a"](this.objects,this.camera,this.renderer.domElement);r.addEventListener("dragstart",(function(t){t.object.material.emissive.set(11184810)})),r.addEventListener("dragend",(function(t){t.object.material.emissive.set(0)})),this.$refs.stats.appendChild(this.stats.dom);var o=function t(){requestAnimationFrame(t);for(var a=0;a<5;a++)e.objects[a].rotation.x+=.025,e.objects[a].rotation.y+=.025;e.renderer.render(e.scene,e.camera),e.$store.state.scene.stats&&e.stats.update()};o(),window.addEventListener("resize",this.onWindowResize,!1)},methods:{layerAll:function(t){t?this.camera.layers.enableAll():this.camera.layers.disableAll()},onWindowResize:function(){var t=this.$refs.scene;if(void 0!=t){var e=t.clientWidth,a=window.innerHeight;this.camera.aspect=e/a,this.camera.updateProjectionMatrix(),this.renderer.setSize(e,a)}}},watch:{layers:function(t){var e=this;t.forEach((function(t,a){e.camera.layers[t?"enable":"disable"](a+1)}))}}},jt=kt,Vt=a("a722"),Ct=Object(p["a"])(jt,gt,_t,!1,null,null,null),Ot=Ct.exports;f()(Ct,{VLayout:Vt["a"]});var St=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",[a("v-container",[a("v-row",[a("v-col",[a("v-sheet",{staticClass:"pa-3"},[t._v("v-col in v-row")])],1),a("v-col",[a("v-sheet",{staticClass:"pa-3"},[t._v("v-col in v-row")])],1)],1)],1),a("v-container",[a("v-row",{attrs:{dense:""}},[a("v-col",[a("v-sheet",{staticClass:"pa-3"},[t._v("v-col in v-row dense")])],1),a("v-col",[a("v-sheet",{staticClass:"pa-3"},[t._v("v-col in v-row dense")])],1)],1)],1),a("v-container",[a("v-row",{attrs:{"no-gutters":""}},[a("v-col",[a("v-sheet",{staticClass:"pa-3"},[t._v("v-col in v-row no-gutters")])],1),a("v-col",[a("v-sheet",{staticClass:"pa-3"},[t._v("v-col in v-row no-gutters")])],1)],1)],1),a("v-divider",{staticClass:"mt-3 mb-3"}),a("v-container",[a("v-row",[a("v-col",{attrs:{cols:"12",md:"6"}},[a("v-sheet",{attrs:{height:"100"}},[a("v-container",{attrs:{"fill-height":""}},[a("v-row",{attrs:{align:"center",justify:"center"}},[a("v-col",{attrs:{cols:"auto"}},[t._v(" v-col ")])],1)],1)],1)],1)],1)],1),a("v-container",[a("v-row",{attrs:{"no-gutters":""}},[a("v-col",{attrs:{cols:"12",sm:"8",md:"6",lg:"4",xl:"2"}},[a("v-sheet",{staticClass:"pa-3"},[t._v(" v-col ")])],1)],1)],1),a("v-divider",{staticClass:"mt-3 mb-3"}),a("v-container",[a("v-row",[a("v-col",{attrs:{xs12:"",md6:""}},[a("v-row",{staticClass:"ma-n3"},[a("v-col",{attrs:{xs12:"",md6:""}},[a("v-sheet",{staticClass:"pa-3"},[t._v(" v-col ")])],1),a("v-col",{attrs:{xs12:"",md6:""}},[a("v-sheet",{staticClass:"pa-3"},[t._v(" v-col ")])],1)],1)],1),a("v-col",{attrs:{xs12:"",md6:""}},[a("v-sheet",{staticClass:"pa-3"},[t._v(" v-col ")])],1),a("v-col",{attrs:{cols:"12"}},[a("v-row",{staticClass:"ma-n3"},[a("v-col",{attrs:{cols:"12",md:"4"}},[a("v-row",{staticClass:"ma-n3"},[a("v-col",{attrs:{cols:"12",md:"6"}},[a("v-sheet",{staticClass:"pa-3"},[t._v(" v-col ")])],1),a("v-col",{attrs:{cols:"12",md:"6"}},[a("v-sheet",{staticClass:"pa-3"},[t._v(" v-col ")])],1)],1)],1),a("v-col",{attrs:{cols:"12",md:"8"}},[a("v-row",{staticClass:"ma-n3"},[a("v-col",{attrs:{cols:"12",md:"6"}},[a("v-sheet",{staticClass:"pa-3"},[t._v(" v-col ")])],1),a("v-col",{attrs:{cols:"12",md:"6"}},[a("v-sheet",{staticClass:"pa-3"},[t._v(" v-col ")])],1)],1)],1)],1)],1)],1)],1)],1)},Mt=[],$t={data:function(){return{}}},xt=$t,At=a("8dd9"),It=Object(p["a"])(xt,St,Mt,!1,null,null,null),Lt=It.exports;f()(It,{VCol:st["a"],VContainer:rt["a"],VDivider:_["a"],VRow:ot["a"],VSheet:At["a"]});var Dt=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("v-container",{attrs:{"fill-height":"",fluid:""}},[a("v-row",{attrs:{align:"center",justify:"center"}},[a("v-alert",{attrs:{type:"error"}},[a("strong",[t._v("404")]),t._v(" Page Not Found ")])],1)],1)},Et=[],Pt={name:"NotFound"},Bt=Pt,Rt=Object(p["a"])(Bt,Dt,Et,!1,null,null,null),Tt=Rt.exports;f()(Rt,{VAlert:g["a"],VContainer:rt["a"],VRow:ot["a"]}),n["a"].use(tt["a"]);var Nt=new tt["a"]({mode:"history",base:"/hwstudio/vue-three/",routes:[{path:"/",name:"home",component:ct},{path:"/about",name:"about",component:ft},{path:"/scene",name:"scene",component:Ot},{path:"/grid",name:"grid",component:Lt},{path:"*",name:"notfound",component:Tt}]}),Ft=(a("b0c0"),a("bc3a")),zt=a.n(Ft);n["a"].use(d["a"]);var Ht=new d["a"].Store({strict:!1,state:{alive:!1,drawer:!1,designs:[],scene:{stats:!1,layers:[!0,!0,!0]}},getters:{isAt:function(t){return function(e){return t.route.name===e}},designNum:function(t){return t.designs.length}},mutations:{setAlive:function(t,e){t.alive=e},toggleDrawer:function(t){t.drawer=!t.drawer},toggleStats:function(t){t.scene.stats=!t.scene.stats},toggleLayer:function(t,e){n["a"].set(t.scene.layers,e,!t.scene.layers[e])},addLayer:function(t){t.scene.layers.push(!0)},addDesign:function(t,e){t.designs.push(e)}},actions:{checkAlive:function(t){var e=t.commit;zt.a.get("/api/alive").then((function(t){200===t.status?(console.log("Backend API is alive:",t.data),e("setAlive",!0)):(console.log("Backend API alive request failed. Returned status of "+t.status),e("setAlive",!1))})).catch((function(t){console.log("Backend API alive check ERROR:",t),e("setAlive",!1)}))},generateBitstream:function(){zt.a.get("/api/genbit").then((function(t){200===t.status?console.log("Generate bitstream SUCCESS:",t.data):console.log("Generate bitstream request failed. Returned status of "+t.status)})).catch((function(t){console.log("Generate bitstream ERROR:",t)}))}}}),Gt=a("a925"),Wt=a("edd4"),Jt=a("a306");n["a"].use(s["a"]),n["a"].use(Gt["a"]);var qt={en:Wt,es:Jt};console.log(qt.es.description);var Ut=new Gt["a"]({locale:"en",messages:qt}),Kt=new s["a"]({});Object(i["sync"])(Ht,Nt),n["a"].config.productionTip=!1,new n["a"]({router:Nt,store:Ht,vuetify:Kt,i18n:Ut,render:function(t){return t(Z)}}).$mount("#app")},a306:function(t){t.exports=JSON.parse('{"description":"Editor gráfico para diseños de descripción hardware","closeMenu":"Cerrar menú","newDesign":"Nuevo diseño","loadImport":"Cargar... | Importar...","layer":"Capa {n}","addLayer":"Añadir nueva capa"}')},a70b:function(t,e,a){t.exports=a.p+"img/logo.05f24824.svg"},edd4:function(t){t.exports=JSON.parse('{"description":"GUI editor for hardware description design","closeMenu":"Close menu","newDesign":"New design","loadImport":"Load... | Import...","layer":"Layer {n}","addLayer":"Add new layer"}')}});
//# sourceMappingURL=app.cf03fe9f.js.map