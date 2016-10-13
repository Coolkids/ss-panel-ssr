<template>
	<div class="home">
		<div class="width home-banner blue center"></div>
		<div class="home-row">
			<div class="home-user down-shadow">
				<p class="twe">A secure socks5 proxy, designed to protect your Internet traffic.</p>
				<p class="six center">
					<i>If you want to keep a secret, you must also hide it from yourself.</i>
				</p>
				<p class="four">
					I am <a href="#" class="ten red">VIP</a>
				</p>
			</div>
			<div class="home-user down-shadow">
				<div class="bor-bot pad-ten">
					快速链接 / Quick Links
				</div>
				<div class="fast-link-btn pad-ten">
					<ul class="ul">
						<li class="fl-li">
							<a href="#" class="btn-sml blue">登陆/LOGIN</a>
						</li>
						<li class="fl-li">
							<a href="#" class="btn-sml green">注册/SIGNUP</a>
						</li>
						<li class="fl-li">
							<a href="#" class="btn-sml orange">用户协议/TOS</a>
						</li>
						<li class="fl-li">
							<a href="#" class="btn-sml redbg">GITHUB</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="home-user down-shadow">
				<p class="six pad-ten">
					邀请码/Invitation code
				</p>
				<div class="invi-list">
					<div class="invi-row twe bor-bot font-9a hid padt-ten">
						<div class="col-1">###</div>
						<div class="col-9 text-hidden center">邀请码 (点击邀请码进入注册页面)</div>
						<div class="col-2 center">状态</div>
					</div>
					<div class="invi-row four bor-bot hid padt-ten">
						<div class="col-1">sdfsdf</div>
						<div class="col-9 text-hidden center red">sdfssfssdfsdfsfsfsdfswdfsdfsdfswdfsdfsdfsdfsfsdfdsdfsdfsdfsdfsdfdf</div>
						<div class="col-2 center">sdfsfsfddf</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>


<script>
//js
import { getInvi } from '../service/service.js'
export default{
	name: 'home',
	
	data(){
		return{
			name : 'home',
		}
	},
	methods:  {
		
	},
	created(){
		this.$loadingRouteData = false;
		console.log(this.name);
		getInvi().then(res => {
			console.log(res);
		})
	}

}

</script>

<style lang="sass">
.home-banner{
	height: 200px;
}
.home-row{
	width: 750px;
	margin:0 auto;
	position: relative;
	top: -1.25rem;
	background: #fff;
	z-index: 1;
	div[class*="home-"]{
		padding:.625rem 3%;
		margin-bottom: 1.25rem;
	}
}
.fast-link-btn{
	padding-top:1.25rem;
	ul{
		li{
			margin-right: .625rem;
			margin-bottom: 0.625rem;
		}
	}
}
.invi-row{
	div{
		float: left;
	}
}
.invi-list{
	min-width: 31.25rem;
}
</style>