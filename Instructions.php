<?php
  ob_start();
  $pageTitle = 'Home Page';
  require "init.php";

  
?>



	<div class="container">
		<main>
			<div class="about">
				<h2 class="heading">Instructions</h2>
				<p>Instructions for registration, login, product posting, purchase ...</p>
			</div>
		</main> <!-- Main Area -->
	</div>

	

</body>
<?php
include $tpl . "footer.php";
ob_end_flush(); ?>	
</html>

