/*! For license information please see 552.d129f97b.chunk.js.LICENSE.txt */
(self.webpackChunkcustom_connect_starter=self.webpackChunkcustom_connect_starter||[]).push([[552],{35552:function(t,i,e){var n=e(83256).default,o=e(56425).default;!function(i,n){t.exports?t.exports=n(i,e(523),e(46502)):i.Draggabilly=n(i,i.getSize,i.Unidragger)}("undefined"!=typeof window?window:this,(function(t,i,e){var r=t.jQuery;function s(t,i){this.element="string"==typeof t?document.querySelector(t):t,r&&(this.$element=r(this.element)),this.options={},this.option(i),this._create()}var a=s.prototype=Object.create(e.prototype);a.option=function(t){this.options=o(o({},this.options),t)};var h=["relative","absolute","fixed"];a._create=function(){this.position={},this._getPosition(),this.startPoint={x:0,y:0},this.dragPoint={x:0,y:0},this.startPosition=o({},this.position);var t=getComputedStyle(this.element);h.includes(t.position)||(this.element.style.position="relative"),this.on("pointerDown",this.handlePointerDown),this.on("pointerUp",this.handlePointerUp),this.on("dragStart",this.handleDragStart),this.on("dragMove",this.handleDragMove),this.on("dragEnd",this.handleDragEnd),this.setHandles(),this.enable()},a.setHandles=function(){var t=this.options.handle;"string"==typeof t?this.handles=this.element.querySelectorAll(t):"object"==typeof t&&t.length?this.handles=t:t instanceof HTMLElement?this.handles=[t]:this.handles=[this.element]};var d=["dragStart","dragMove","dragEnd"],c=a.emitEvent;function u(t,i,e){return i?(e=e||"round",Math[e](t/i)*i):t}a.emitEvent=function(i,e){if(!(!this.isEnabled&&d.includes(i))){c.call(this,i,e);var o=t.jQuery;if(o&&this.$element){var r,s=e;if(e&&e[0]instanceof Event){var a=n(e);r=a[0],s=a.slice(1)}var h=o.Event(r);h.type=i,this.$element.trigger(h,s)}}},a._getPosition=function(){var t=getComputedStyle(this.element),i=this._getPositionCoord(t.left,"width"),e=this._getPositionCoord(t.top,"height");this.position.x=isNaN(i)?0:i,this.position.y=isNaN(e)?0:e,this._addTransformPosition(t)},a._getPositionCoord=function(t,e){if(t.includes("%")){var n=i(this.element.parentNode);return n?parseFloat(t)/100*n[e]:0}return parseInt(t,10)},a._addTransformPosition=function(t){var i=t.transform;if(i.startsWith("matrix")){var e=i.split(","),n=i.startsWith("matrix3d")?12:4,o=parseInt(e[n],10),r=parseInt(e[n+1],10);this.position.x+=o,this.position.y+=r}},a.handlePointerDown=function(t,i){this.isEnabled&&(this.pointerDownPointer={pageX:i.pageX,pageY:i.pageY},t.preventDefault(),document.activeElement.blur(),this.bindActivePointerEvents(t),this.element.classList.add("is-pointer-down"))},a.handleDragStart=function(){this.isEnabled&&(this._getPosition(),this.measureContainment(),this.startPosition.x=this.position.x,this.startPosition.y=this.position.y,this.setLeftTop(),this.dragPoint.x=0,this.dragPoint.y=0,this.element.classList.add("is-dragging"),this.animate())},a.measureContainment=function(){var t=this.getContainer();if(t){var e=i(this.element),n=i(t),o=n.borderLeftWidth,r=n.borderRightWidth,s=n.borderTopWidth,a=n.borderBottomWidth,h=this.element.getBoundingClientRect(),d=t.getBoundingClientRect(),c=o+r,u=s+a,p=this.relativeStartPosition={x:h.left-(d.left+o),y:h.top-(d.top+s)};this.containSize={width:n.width-c-p.x-e.width,height:n.height-u-p.y-e.height}}},a.getContainer=function(){var t=this.options.containment;if(t)return t instanceof HTMLElement?t:"string"==typeof t?document.querySelector(t):this.element.parentNode},a.handleDragMove=function(t,i,e){if(this.isEnabled){var n=e.x,o=e.y,r=this.options.grid,s=r&&r[0],a=r&&r[1];n=u(n,s),o=u(o,a),n=this.containDrag("x",n,s),o=this.containDrag("y",o,a),n="y"==this.options.axis?0:n,o="x"==this.options.axis?0:o,this.position.x=this.startPosition.x+n,this.position.y=this.startPosition.y+o,this.dragPoint.x=n,this.dragPoint.y=o}},a.containDrag=function(t,i,e){if(!this.options.containment)return i;var n="x"==t?"width":"height",o=u(-this.relativeStartPosition[t],e,"ceil"),r=this.containSize[n];return r=u(r,e,"floor"),Math.max(o,Math.min(r,i))},a.handlePointerUp=function(){this.element.classList.remove("is-pointer-down")},a.handleDragEnd=function(){this.isEnabled&&(this.element.style.transform="",this.setLeftTop(),this.element.classList.remove("is-dragging"))},a.animate=function(){var t=this;this.isDragging&&(this.positionDrag(),requestAnimationFrame((function(){return t.animate()})))},a.setLeftTop=function(){var t=this.position,i=t.x,e=t.y;this.element.style.left="".concat(i,"px"),this.element.style.top="".concat(e,"px")},a.positionDrag=function(){var t=this.dragPoint,i=t.x,e=t.y;this.element.style.transform="translate3d(".concat(i,"px, ").concat(e,"px, 0)")},a.setPosition=function(t,i){this.position.x=t,this.position.y=i,this.setLeftTop()},a.enable=function(){this.isEnabled||(this.isEnabled=!0,this.bindHandles())},a.disable=function(){this.isEnabled&&(this.isEnabled=!1,this.isDragging&&this.dragEnd(),this.unbindHandles())};var p=["transform","left","top","position"];return a.destroy=function(){var t=this;this.disable(),p.forEach((function(i){t.element.style[i]=""})),this.unbindHandles(),this.$element&&this.$element.removeData("draggabilly")},a._init=function(){},r&&r.bridget&&r.bridget("draggabilly",s),s}))},97830:function(t,i,e){var n,o,r=e(30851).default;n="undefined"!=typeof window?window:this,o=function(){function t(){}var i=t.prototype;return i.on=function(t,i){if(!t||!i)return this;var e=this._events=this._events||{},n=e[t]=e[t]||[];return n.includes(i)||n.push(i),this},i.once=function(t,i){if(!t||!i)return this;this.on(t,i);var e=this._onceEvents=this._onceEvents||{};return(e[t]=e[t]||{})[i]=!0,this},i.off=function(t,i){var e=this._events&&this._events[t];if(!e||!e.length)return this;var n=e.indexOf(i);return-1!=n&&e.splice(n,1),this},i.emitEvent=function(t,i){var e=this._events&&this._events[t];if(!e||!e.length)return this;e=e.slice(0),i=i||[];var n,o=this._onceEvents&&this._onceEvents[t],s=r(e);try{for(s.s();!(n=s.n()).done;){var a=n.value;o&&o[a]&&(this.off(t,a),delete o[a]),a.apply(this,i)}}catch(h){s.e(h)}finally{s.f()}return this},i.allOff=function(){return delete this._events,delete this._onceEvents,this},t},t.exports?t.exports=o():n.EvEmitter=o()},523:function(t){!function(i,e){t.exports?t.exports=e():i.getSize=e()}(window,(function(){function t(t){var i=parseFloat(t);return-1==t.indexOf("%")&&!isNaN(i)&&i}var i=["paddingLeft","paddingRight","paddingTop","paddingBottom","marginLeft","marginRight","marginTop","marginBottom","borderLeftWidth","borderRightWidth","borderTopWidth","borderBottomWidth"];i.length;return function(e){if("string"==typeof e&&(e=document.querySelector(e)),e&&"object"==typeof e&&e.nodeType){var n=getComputedStyle(e);if("none"==n.display)return function(){var t={width:0,height:0,innerWidth:0,innerHeight:0,outerWidth:0,outerHeight:0};return i.forEach((function(i){t[i]=0})),t}();var o={};o.width=e.offsetWidth,o.height=e.offsetHeight;var r=o.isBorderBox="border-box"==n.boxSizing;i.forEach((function(t){var i=n[t],e=parseFloat(i);o[t]=isNaN(e)?0:e}));var s=o.paddingLeft+o.paddingRight,a=o.paddingTop+o.paddingBottom,h=o.marginLeft+o.marginRight,d=o.marginTop+o.marginBottom,c=o.borderLeftWidth+o.borderRightWidth,u=o.borderTopWidth+o.borderBottomWidth,p=t(n.width);!1!==p&&(o.width=p+(r?0:s+c));var f=t(n.height);return!1!==f&&(o.height=f+(r?0:a+u)),o.innerWidth=o.width-(s+c),o.innerHeight=o.height-(a+u),o.outerWidth=o.width+h,o.outerHeight=o.height+d,o}}}))},46502:function(t,i,e){var n=e(30851).default;!function(i,n){t.exports?t.exports=n(i,e(97830)):i.Unidragger=n(i,i.EvEmitter)}("undefined"!=typeof window?window:this,(function(t,i){function e(){}var o,r,s=e.prototype=Object.create(i.prototype);s.handleEvent=function(t){var i="on"+t.type;this[i]&&this[i](t)},"ontouchstart"in t?(o="touchstart",r=["touchmove","touchend","touchcancel"]):t.PointerEvent?(o="pointerdown",r=["pointermove","pointerup","pointercancel"]):(o="mousedown",r=["mousemove","mouseup"]),s.touchActionValue="none",s.bindHandles=function(){this._bindHandles("addEventListener",this.touchActionValue)},s.unbindHandles=function(){this._bindHandles("removeEventListener","")},s._bindHandles=function(i,e){var n=this;this.handles.forEach((function(r){r[i](o,n),r[i]("click",n),t.PointerEvent&&(r.style.touchAction=e)}))},s.bindActivePointerEvents=function(){var i=this;r.forEach((function(e){t.addEventListener(e,i)}))},s.unbindActivePointerEvents=function(){var i=this;r.forEach((function(e){t.removeEventListener(e,i)}))},s.withPointer=function(t,i){i.pointerId===this.pointerIdentifier&&this[t](i,i)},s.withTouch=function(t,i){var e,o,r=n(i.changedTouches);try{for(r.s();!(o=r.n()).done;){var s=o.value;s.identifier===this.pointerIdentifier&&(e=s)}}catch(a){r.e(a)}finally{r.f()}e&&this[t](i,e)},s.onmousedown=function(t){this.pointerDown(t,t)},s.ontouchstart=function(t){this.pointerDown(t,t.changedTouches[0])},s.onpointerdown=function(t){this.pointerDown(t,t)};var a=["TEXTAREA","INPUT","SELECT","OPTION"],h=["radio","checkbox","button","submit","image","file"];return s.pointerDown=function(t,i){var e=a.includes(t.target.nodeName),n=h.includes(t.target.type),o=!e||n;!this.isPointerDown&&!t.button&&o&&(this.isPointerDown=!0,this.pointerIdentifier=void 0!==i.pointerId?i.pointerId:i.identifier,this.pointerDownPointer={pageX:i.pageX,pageY:i.pageY},this.bindActivePointerEvents(),this.emitEvent("pointerDown",[t,i]))},s.onmousemove=function(t){this.pointerMove(t,t)},s.onpointermove=function(t){this.withPointer("pointerMove",t)},s.ontouchmove=function(t){this.withTouch("pointerMove",t)},s.pointerMove=function(t,i){var e={x:i.pageX-this.pointerDownPointer.pageX,y:i.pageY-this.pointerDownPointer.pageY};this.emitEvent("pointerMove",[t,i,e]),!this.isDragging&&this.hasDragStarted(e)&&this.dragStart(t,i),this.isDragging&&this.dragMove(t,i,e)},s.hasDragStarted=function(t){return Math.abs(t.x)>3||Math.abs(t.y)>3},s.dragStart=function(t,i){this.isDragging=!0,this.isPreventingClicks=!0,this.emitEvent("dragStart",[t,i])},s.dragMove=function(t,i,e){this.emitEvent("dragMove",[t,i,e])},s.onmouseup=function(t){this.pointerUp(t,t)},s.onpointerup=function(t){this.withPointer("pointerUp",t)},s.ontouchend=function(t){this.withTouch("pointerUp",t)},s.pointerUp=function(t,i){this.pointerDone(),this.emitEvent("pointerUp",[t,i]),this.isDragging?this.dragEnd(t,i):this.staticClick(t,i)},s.dragEnd=function(t,i){var e=this;this.isDragging=!1,setTimeout((function(){return delete e.isPreventingClicks})),this.emitEvent("dragEnd",[t,i])},s.pointerDone=function(){this.isPointerDown=!1,delete this.pointerIdentifier,this.unbindActivePointerEvents(),this.emitEvent("pointerDone")},s.onpointercancel=function(t){this.withPointer("pointerCancel",t)},s.ontouchcancel=function(t){this.withTouch("pointerCancel",t)},s.pointerCancel=function(t,i){this.pointerDone(),this.emitEvent("pointerCancel",[t,i])},s.onclick=function(t){this.isPreventingClicks&&t.preventDefault()},s.staticClick=function(t,i){var e=this,n="mouseup"===t.type;n&&this.isIgnoringMouseUp||(this.emitEvent("staticClick",[t,i]),n&&(this.isIgnoringMouseUp=!0,setTimeout((function(){delete e.isIgnoringMouseUp}),400)))},e}))},56425:function(t,i,e){var n=e(96274);function o(t,i){var e=Object.keys(t);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(t);i&&(n=n.filter((function(i){return Object.getOwnPropertyDescriptor(t,i).enumerable}))),e.push.apply(e,n)}return e}t.exports=function(t){for(var i=1;i<arguments.length;i++){var e=null!=arguments[i]?arguments[i]:{};i%2?o(Object(e),!0).forEach((function(i){n(t,i,e[i])})):Object.getOwnPropertyDescriptors?Object.defineProperties(t,Object.getOwnPropertyDescriptors(e)):o(Object(e)).forEach((function(i){Object.defineProperty(t,i,Object.getOwnPropertyDescriptor(e,i))}))}return t},t.exports.__esModule=!0,t.exports.default=t.exports},83256:function(t,i,e){var n=e(53637),o=e(52452),r=e(23398),s=e(60550);t.exports=function(t){return n(t)||o(t)||r(t)||s()},t.exports.__esModule=!0,t.exports.default=t.exports}}]);