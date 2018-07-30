<?php
	include("/usr/local/cpanel/php/cpanel.php");
	
	$cpanel = new CPANEL();
	print $cpanel->header( "HumCommerce - Heatmaps and Visitor Session Recording Tool" );
?>

<style>
	.humcommerce_banner
       {
               display: block;
               margin: auto;
       }
</style>

<div>
	<img class="humcommerce_banner" src="Humcommercebanner.jpg" alt="humcommerce">
</div>

<div>
</div>

<div class="callout callout-warning" aria-label="warning">
    	<h2 class="callout-heading">Record visitors on your site</h2>
	<div>
		<p class="ng-scope">
			Get started by signing up on HumCommerce.
		</p>
		<button class="btn btn-primary ng-scope" onclick='window.open("https://www.humcommerce.com")'>SignUp to HumCommerce for free</button>
    	</div>
</div>

<?php
	print $cpanel->footer();
	$cpanel->end();
?>
