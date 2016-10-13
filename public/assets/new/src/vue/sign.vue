<template>
	<div class="sign center">I am {{ name }}</div>
</template>


<script>
//js

export default{
	name: 'about',

	data(){
		return{
			name : 'sign' 
		}
	}
}
</script>


<style>
.sign{
	background-color: blue;
	height: 12.5rem;
}
</style>