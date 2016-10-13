<template>
	<div class="nav-view">
		<div class="nav-btn">
			<a href="javascript:void(0)" class="nav-link" @click="show = !show"></a>
		</div>
	</div>
	<div class="nav-content height" :class="{'nav-show':show,'nav-hide':!show}" @click="show = false">
		<div class="nav-list height">
			<ul>	
				<li v-link="{path:'/home'}">
					<a href="">首页</a>
				</li>
				<li v-link="{path:'/sign'}">
					<a href="">注册</a>
				</li>
				<li v-link="{path:'/about'}">
					<a href="">关于</a>
				</li>
			</ul>
		</div>
		<div class="nav-mask">
			
		</div>
	</div>
</template>

<script>

export default{
	name : 'Navbar',

	data(){
		return{
			show:false
		}
	},
	methods:  {

	},
	created(){
		
	},
}
</script>

<style lang="sass">
.nav-view,.nav-content{
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	z-index: 99;
}
.nav-btn{
	width: 1.875rem;
	height: 1.0rem;
	position: absolute;
	top: .625rem;
	left: .625rem;
	.nav-link{
		display: block;
		height: 100%;
		border-top:0.125rem solid #fff;
		border-bottom:0.125rem solid #fff;
		&:after{
			position: absolute;
			content:"";
			width: 100%;
			height: .125rem;
			background-color: #fff;
			top:.5rem;
		}
	}
}
.nav-content{
	transition: all .2s ease;
	overflow: hidden;
	background-color:rgba(#000, .2)
}
.nav-show{
	transform: translate(0,0)
}
.nav-hide{
	transform: translate(-100%,0)
	
}
.nav-list{
	float:left;
	width: 250px;
	background-color:#fff;
	ul{
		margin-top: 10%;
	}
	li{
		width: 100%;
		padding: 5px	 0;
		text-align: center;
		&:hover{
			background-color:#ccc;
			transition: all .2s ease;
		}
		a{
			color: #666;
		}
	}
}
</style>