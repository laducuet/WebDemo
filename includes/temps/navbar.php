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
							<p class="big-logo">Software Engineering</p>
							<p class="small-logo">Team 9</p>
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
          <?php if($unSeenFlag): ?>
            <img src="img/icons/heart_fill.png">
            <?php else: ?>
              <img src="img/icons/heart.png">
            <?php endif; ?>
						<ul class="dropdown-menu dropdown-menu-notification" aria-labelledby="navbarDropdown11" style="right: 0;">
           
      <?php foreach($Notifications as $noti): ?>
      <?php if($noti['seen']===0): ?>
      <?php $_SESSION['noOfNewNotification'] = $_SESSION['noOfNewNotification'] +1; ?>
      <li><a class="dropdown-item add-red noti-items-red" href="notification.php"><?php echo
       "Notification From ". $noti['fName']." ".$noti['lName']; ?></a>
      </li>
      <?php endif; ?>
      <?php endforeach; ?>
      <?php if($_SESSION['noOfNewNotification']!=0): ?>
      <li>
        <hr class="dropdown-divider">
      </li>
      <?php endif; ?>
      <?php foreach($Notifications as $noti): ?>
      <?php if($noti['seen']===1): ?>
      <?php $_SESSION['noOfOldNotification'] = $_SESSION['noOfOldNotification'] +1; ?>
      <li><a class="dropdown-item" href="notification.php"><?php echo
       "Notification From ". $noti['fName']." ".$noti['lName']; ?></a></li>
      <?php endif; ?>
      <?php endforeach; ?>
    </ul>

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
					<a href="index.php">
						<img src="img/icons/online_shopping.png">
						<div class="logo-text">
							<p class="big-logo">Software Engineering</p>
							<p class="small-logo">Team 9</p>
						</div>
					</a>
				</div> <!-- logo -->
        <div class="menu-bar">
				<div class="search-bar">
					<form>
						<div class="form-group">
							 <input type="text" class="form-control" name="keyword" placeholder="Search">
							<img src="img/icons/search.png">
						</div>
					</form>
				</div>
			</div> <!-- menu -->
				<div class="shop-icon">
          <div class="dropdown">
          <a href="signin.php">
						<img src="img/icons/signin.png">
          </a>
					</div>
					<div class="dropdown">
          <a href="signup.php">
						<img src="img/icons/signup.png">
          </a>
					</div>
          <div class="dropdown">
          <a href="about.php">
						<img src="img/icons/aboutus.png">
            </a>
					</div>
          
				</div> <!-- shop icons -->
        
			</div> <!-- brand -->
		</div> <!-- container -->
	</header> <!-- header -->
<?php endif;
ob_end_flush();
?>