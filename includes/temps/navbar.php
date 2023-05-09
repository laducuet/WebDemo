<?php
  ob_start();
  require 'admin/connect.php' ;
  $func = "includes/functions/";
  require $func . 'controller.php';
  $unSeenFlag = false;
  $images = "layout/images/";
  session_start();

  $_SESSION['noOfNewNotification'] = 0;
  $_SESSION['noOfOldNotification'] = 0;

  if(isset($_SESSION["typeOfUser"]) && $_SESSION["typeOfUser"]==="buyer"){
  $User = getBuyer($db,$_SESSION["username"]);
  $Notifications = getNotificationsForBuyer($db,$User[0]['ID']);
  $_SESSION['userID'] = $User[0]['ID'];
  $_SESSION['not'] = $Notifications;
  foreach($Notifications as $noti){
    if($noti['seen']==0){
      $unSeenFlag = true;
      break;
      }
    }
  }
  else if(isset($_SESSION["typeOfUser"]) && $_SESSION["typeOfUser"]==="seller"){
  $User = getSeller($db,$_SESSION["username"]);
  $Notifications = getNotificationsForSeller($db,$User[0]['ID']);
  $_SESSION['userID'] = $User[0]['ID'];
  $_SESSION['not'] = $Notifications;
  foreach($Notifications as $noti){
    if($noti['seen']==0){
      $unSeenFlag = true;
      break;
    }
  }
}
else if(isset($_SESSION["typeOfUser"]) && $_SESSION["typeOfUser"]==="admin"){
header("Location: signin.php");
}
?>
<?php if(isset($_SESSION["username"])): ?>
  <header>
		<div class="container">
			<div class="brand">
				<div class="logo">
					<a href="index.php">
						<img src="img/icons/online_shopping.png">
						<div class="logo-text">
							<p class="big-logo">Ecommerce</p>
							<p class="small-logo">online shop</p>
						</div>
					</a>
				</div> <!-- logo -->
				<div class="shop-icon">
					<div class="dropdown">
						<img src="img/icons/account.png">
						<div class="dropdown-menu">
							<ul>
                <?php if($_SESSION["typeOfUser"]==="buyer"): ?>
                  <li><a href="profileBuyer.php">PROFILE</a></li>
                <?php elseif($_SESSION["typeOfUser"]==="seller"): ?>
                  <li><a href="profileSeller.php">PROFILE</a></li>
                <?php endif; ?>
								<li><a href="logout.php">LOGOUT</a></li>
							</ul>
						</div>
					</div>
					<div class="dropdown">
            <?php if($_SESSION["typeOfUser"]==="buyer"): ?>
              <a href="<?php echo "cart.php?username=".$User[0]['userName']?>">
                <img src="img/icons/shopping_cart.png">
              </a>
            <?php endif; ?>
					</div>
          <div class="dropdown">
						<img src="img/icons/heart.png">
					</div>
				</div> <!-- shop icons -->
			</div> <!-- brand -->
		</div> <!-- container -->
	</header> <!-- header -->
<?php else: ?>
  <header>
		<div class="container">
			<div class="brand">
				<div class="logo">
					<a href="index.html">
						<img src="img/icons/online_shopping.png">
						<div class="logo-text">
							<p class="big-logo">Ecommerce</p>
							<p class="small-logo">online shop</p>
						</div>
					</a>
				</div> <!-- logo -->
				<div class="shop-icon">
					<div class="dropdown">
						<img src="img/icons/account.png">
						<div class="dropdown-menu">
							<ul>
                <li><a href="signin.php">SIGNIN</a></li>
								<li><a href="signup.php">SIGNUP</a></li>
							</ul>
						</div>
					</div>
					<div class="dropdown">
						<img src="img/icons/shopping_cart.png">
					</div>
          <div class="dropdown">
						<img src="img/icons/heart.png">
					</div>
				</div> <!-- shop icons -->
			</div> <!-- brand -->
		</div> <!-- container -->
	</header> <!-- header -->
<?php endif;
ob_end_flush();
?>