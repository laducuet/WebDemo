<?php
  ob_start();
  $pageTitle = 'Home Page';
  require "init.php";

  
?>



	<div class="container">
		<main>
			<div class="about">
				<h2 class="heading">About</h2>
				<p>Description about us : ....</p>
			</div>
		</main> <!-- Main Area -->
	</div>

	

</body>
<?php
include $tpl . "footer.php";
ob_end_flush(); ?>	
</html>

