<footer class="ui-footer">
	<div class="container">
		<p>{date("Y")}Panel &nbsp; {$config["version"]}</p>
	</div>
	<div style="display:none;">
	    {md5($config["version"])}
	</div	
</footer>
<div style="display:none;">
    {$analyticsCode}
</div>
</body>
</html>
