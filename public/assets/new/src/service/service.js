import Vue from 'vue'

export function getInvi(){
	const url = '//183.233.190.177:53178/getcode/';
	return Vue.http.get(url);
}