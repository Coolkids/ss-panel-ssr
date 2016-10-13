var vue = require("vue");
var router = require("vue-router");
var resource = require("vue-resource");

var home  = require('./vue/home.vue');
var about = require('./vue/about.vue');
var app = require('./vue/app.vue');
var sign = require('./vue/sign.vue')
require('./views/style.css');
require('./views/sass.scss');

vue.use(router);
vue.use(resource);

var route = new router({
	hashbang : false,
	history : false,
	saveScrollPosition: true,
	transitionOnLoad : true,
	transition:true,
	transitionMode: 'out-in'
});
route.mode = "html5";
route.map({
	'/home':{
		component: home
	},
	'/about':{
		component: about
	},
	'/sign':{
		component: sign
	}
});

route.redirect({
    '*': '/home'
})

route.afterEach(function(transition){
	console.log("成功浏览到：" + transition.to.path);
})

route.start(app,"#app");