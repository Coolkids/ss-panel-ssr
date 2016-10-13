<template>
	<div>
		<Navbar></Navbar>
		<router-view
		transition="route"
		transition-mode="out-in">	
		</router-view>
	</div>
</template>


<script>
import Navbar from './nav.vue'
//js
export default{
	name: 'app',

	components: [Navbar],

	data(){
		return{
			name : 'app',
		}
	},
	created(){
		this.$loadingRouteData = false;
		console.log(this.name);
	},

}
</script>

<style lang="sass">
.bor-bot{
	position: relative;
	&:after{
		content:"";
		position: absolute;
		width: 100%;
		bottom: 0;
		left: -3%;
		padding: 0 3%;
		height: 0.0625rem;
		background-color: rgba(0,0,0,.12);
		transform:scale(1,-1);
	}
}
.flex{
	display: flex;
	div{
		flex: 1;
	}
}
@media only screen and (max-width: 750px){
	.home-row{
		width: 90%;
		div[class*="home-"]{
			overflow-y:scroll;
			overflow-scrolling: touch;
		}
	}
}
</style>