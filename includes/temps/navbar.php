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
<nav class="navbar navbar-expand-lg navbar-dark bg-success ">
  <div class="container-fluid ">
    <a class="navbar-brand ps-2" href="index.php" style=" order:1"><img class="navbar-icon"
        src="<?php echo $images."Logo2.png" ?>" alt="Logo"></a>
    <a class="navbar-brand ms-1 mt-3 m-lg-auto notification-icon me-lg-2" href="#" id="navbarDropdown11" role="button"
      data-bs-toggle="dropdown" aria-expanded="false" style="position: relative; display:inline-block; ">
      <i class="fa fa-bell <?php if($unSeenFlag) echo 'add-red'; else echo 'add-white'; ?>" style="font-size: 23px;"
        id='Notification-bell'></i>
    </a>
    <ul class="dropdown-menu dropdown-menu-notification" aria-labelledby="navbarDropdown11" style="right: 0;">
      <?php foreach($Notifications as $noti): ?>
      <?php if($noti['seen']==0): ?>
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
      <?php if($noti['seen']==1): ?>
      <?php $_SESSION['noOfOldNotification'] = $_SESSION['noOfOldNotification'] +1; ?>
      <li><a class="dropdown-item" href="notification.php"><?php echo
       "Notification From ". $noti['fName']." ".$noti['lName']; ?></a></li>
      <?php endif; ?>
      <?php endforeach; ?>
    </ul>

    <button class="navbar-toggler " type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
      aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div style=" order:2" class="collapse navbar-collapse justify-content-end align-center" id="navbarSupportedContent">
    <form class="m-auto  d-flex  mt-3 mt-lg-auto" action="index.php" method="GET">
        <input class="form-control me-2 search-input" name="keyword" type="search" placeholder="Search"
          aria-label="Search">
        <input class="btn btn-outline-light" value="Search" type="submit"></input>
      </form>
    <ul class="navbar-nav text-center">
        <li class="nav-item dropdown ">
          <a class="nav-link d-none d-lg-block" href="#" id="navbarDropdown1" role="button" data-bs-toggle="dropdown"
            aria-expanded="false">
            <span class="navbar-toggler-icon"></span>
          </a>
          <ul class="dropdown-menu dropdown-menu-profile mt-3 mt-lg-0 mb-2 mb-lg-0" aria-labelledby="navbarDropdown1"
            style="top: 55px; left: -50px;">
            <?php if($_SESSION["typeOfUser"]==="buyer"): ?>
            <li><a class="dropdown-item mainpage-dropdown-item" href="profileBuyer.php">Profile</a></li>
            <?php elseif($_SESSION["typeOfUser"]==="seller"): ?>
            <li><a class="dropdown-item mainpage-dropdown-item" href="profileSeller.php">Profile</a></li>
            <?php endif; ?>
            <?php if($_SESSION["typeOfUser"]==="buyer"): ?>
            <li><a class="dropdown-item mainpage-dropdown-item"
                href="<?php echo "cart.php?username=".$User[0]['userName']?>">Cart </a></li>
            <?php endif; ?>
            <li>
              <hr class="dropdown-divider">
            </li>
            <li><a class="dropdown-item mainpage-dropdown-item" href="logout.php">Log Out</a></li>
          </ul>
        </li>
        <li class="nav-item ">
          <?php if($_SESSION["typeOfUser"]==="buyer"): ?>
          <a class="nav-link active me-lg-3" aria-current="page"
            href="profileBuyer.php"><?php echo $User[0]['fName']." ". $User[0]['lName'] ?></a>
          <?php elseif($_SESSION["typeOfUser"]==="seller"): ?>
          <a class="nav-link active me-lg-3" aria-current="page"
            href="profileSeller.php"><?php echo $User[0]['fName']." ". $User[0]['lName'] ?></a>
          <?php endif; ?>
        </li>
      </ul>
    </div>
  </div>
</nav>
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
								<li><a href="signup.php">Signup</a></li>
								<li><a href="orders.html">My Orders</a></li>
							</ul>
						</div>
					</div>
					<div class="dropdown">
						<img src="img/icons/heart.png">
						<div class="dropdown-menu wishlist-item">
							<table border="1">
								<thead>
									<tr>
										<th>Image</th>
										<th>Product Name</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><img src="img/product/img1.jpg"></td>
										<td>product name</td>
									</tr>
									<tr>
										<td><img src="img/product/img2.jpg"></td>
										<td>product name</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="dropdown">
						<img src="img/icons/shopping_cart.png">
						<div class="dropdown-menu cart-item">
							<table border="1">
								<thead>
									<tr>
										<th>Image</th>
										<th>Product Name</th>
										<th class="center">Price</th>
										<th class="center">Qty.</th>
										<th class="center">Amount</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><img src="img/product/img1.jpg"></td>
										<td>product name</td>
										<td class="center">1200</td>
										<td class="center">2</td>
										<td class="center">2400</td>
									</tr>
									<tr>
										<td><img src="img/product/img2.jpg"></td>
										<td>product name</td>
										<td class="center">1500</td>
										<td class="center">2</td>
										<td class="center">3000</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div> <!-- shop icons -->
			</div> <!-- brand -->

			<div class="menu-bar">
				<div class="menu">
					<ul>
						<li><a href="index.html">Home</a></li>
						<li><a href="shop.html">Shop</a></li>
						<li><a href="about.html">About</a></li>
						<li><a href="contact.html">Contact</a></li>
					</ul>
				</div>
				<div class="search-bar">
					<form>
						<div class="form-group">
							<input type="text" class="form-control" name="search" placeholder="Search">
							<img src="img/icons/search.png">
						</div>
					</form>
				</div>
			</div> <!-- menu -->
		</div> <!-- container -->
	</header> <!-- header -->
<?php endif;
ob_end_flush();
?>