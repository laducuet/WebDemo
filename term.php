<?php
  ob_start();
  $pageTitle = 'Home Page';
  require "init.php";
?>


<div class="container">
		<main>
			<div class="about">
				<h2 class="heading">Terms and Conditions</h2>
				<p>Terms and Conditions of Website</p>
			</div>
		</main> <!-- Main Area -->
	</div>

<?php
include $tpl . "footer.php";
ob_end_flush(); ?>	
</html>
