<?php
  ob_start();
  $pageTitle = 'Home Page';
  require "init.php";
  //$categories = getCategories($db);
  //$itemImages = getItemsImages($db);
 // $categories = array_reverse($categories);
  
?>

<!-- <div class="mua_acc_section">
    <div id="main_slider" class="carousel slide" data-ride="carousel">
      <div class="carousel-inner">
        <div class="carousel-item active">
          <div class="container">
            <h1 class="mua_acc_taital">DANH MỤC ACC EFOOTBALL MOBILE</h1>
            <div class="mua_acc_section_2">
              <div class="row">
                <//?php foreach($categories as $cat): ?>
                  <div class="col-lg-4 col-sm-4">
                    <div class="box_main">
                      <h4 class="shirt_text" ><//?php echo $cat['categoryName'] ?></h4>
                      <div class="tshirt_img">
                        <img src="images/accthuong.png" />
                      </div>
                      <div class="see_all">
                        <ul>
                          <li><a href="
                          <//?php echo "childcat.php?cat=".urlencode($cat['categoryId']); ?>">Xem tất cả</a></li>
                        </ul>
                      </div>
                    </div>
                  </div>
                  <//?php endforeach; ?>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div> -->
<!-- <//?php
//include $tpl . "footer.php";
//ob_end_flush(); ?> -->

<div class="container">
		<main>
			<div class="breadcrumb">
				<ul>
					<li><a href="index.html">Home</a></li>
					<li> / </li>
					<li>Shop</li>
				</ul>
			</div> <!-- End of Breadcrumb-->

			<div class="new-product-section shop">
				<div class="sidebar">
					<div class="sidebar-widget">
						<h3>Category</h3>
						<ul>
							<li><a href="">Men's Clothes</a></li>
							<li><a href="">Men's Shoes</a></li>
							<li><a href="">Men's Watches</a></li>
							<li><a href="">Women's Handbags</a></li>
							<li><a href="">Women's Glasses</a></li>

						</ul>
					</div>
					<div class="sidebar-widget">
						<h3>Range Filter</h3>
						<p>
						  <label for="amount"></label>
						  <input type="text" id="amount" readonly style="border:0; color:#F0E68C;  margin-bottom: 5px;">
						</p>						 
						<div id="slider-range"></div>
					</div>
				</div>
				<div class="product-content">
					<div class="product">
						<a href="product.html">
							<img src="img/product/img1.jpg">
						</a>
						<div class="product-detail">
							<h3>Men's / Watches</h3>
							<h2>Gray Color Men's Watch</h2>
							<a href="#">Add to Cart</a>
							<p>Rs.4500/-</p>
						</div>						
					</div>
					<div class="product">
						<a href="product.html">
							<img src="img/product/img2.jpg">
						</a>
						<div class="product-detail">
							<h3>Men's / Pants</h3>
							<h2>Levi's Jeans Pant</h2>
							<a href="#">Add to Cart</a>
							<p>Rs.2000/-</p>
						</div>
					</div>
					<div class="product">
						<a href="product.html">
							<img src="img/product/img3.jpg">
						</a>
						<div class="product-detail">
							<h3>Men's / Watches</h3>
							<h2>Black Men's Watch</h2>
							<a href="#">Add to Cart</a>
							<p>Rs.4000/-</p>
						</div>
					</div>
					<div class="product">
						<a href="product.html">
							<img src="img/product/img4.jpg">
						</a>
						<div class="product-detail">
							<h3>Men's / Shoes</h3>
							<h2>Nick Black Sneakers</h2>
							<a href="#">Add to Cart</a>
							<p>Rs.3200/-</p>
						</div>
					</div>
					<div class="product">
						<a href="product.html">
							<img src="img/product/img5.jpg">
						</a>
						<div class="product-detail">
							<h3>Glasses</h3>
							<h2>Wood Frame Sun Glass</h2>
							<a href="#">Add to Cart</a>
							<p>Rs.1200/-</p>
						</div>
					</div>
					<div class="product">
						<a href="product.html">
							<img src="img/product/img6.jpg">
						</a>
						<div class="product-detail">
							<h3>Women's / Hand Bags</h3>
							<h2>Leather Hand Bag</h2>
							<a href="#">Add to Cart</a>
							<p>Rs.3800/-</p>
						</div>
					</div>
					<div class="product">
						<a href="product.html">
							<img src="img/product/img7.jpg">
						</a>
						<div class="product-detail">
							<h3>Men's / Shoes</h3>
							<h2>Men's Sneaker</h2>
							<a href="#">Add to Cart</a>
							<p>Rs.3500/-</p>
						</div>
					</div>
					<div class="product">
						<a href="product.html">
							<img src="img/product/img8.jpg">
						</a>
						<div class="product-detail">
							<h3>Women's / Hand Bags</h3>
							<h2>Brown Leather Hand Bag</h2>
							<a href="#">Add to Cart</a>
							<p>Rs.5200/-</p>
						</div>
					</div>
				</div>				
			</div> <!-- New Product Section -->	
			<div class="load-more">
				<a href="#">Load More</a>
			</div>		
		</main> <!-- Main Area -->
	</div>

	<footer>
		<div class="container">
			<div class="footer-widget">
				<div class="widget">
					<div class="widget-heading">
						<h3>Important Link</h3>
					</div>
					<div class="widget-content">
						<ul>
							<li><a href="about.html">About</a></li>
							<li><a href="contact.html">Contact</a></li>
							<li><a href="refund.html">Refund Policy</a></li>
							<li><a href="terms.html">Terms & Conditions</a></li>
						</ul>
					</div>
				</div>
				<div class="widget">
					<div class="widget-heading">
						<h3>Information</h3>
					</div>
					<div class="widget-content">
						<ul>
							<li><a href="account.html">My Account</a></li>
							<li><a href="orders.html">My Orders</a></li>
							<li><a href="cart.html">Cart</a></li>
							<li><a href="checkout.html">Checkout</a></li>
						</ul>
					</div>
				</div>
				<div class="widget">
					<div class="widget-heading">
						<h3>Follow us</h3>
					</div>
					<div class="widget-content">
						<div class="follow">
							<ul>
								<li><a href="#"><img src="img/icons/facebook.png"></a></li>
								<li><a href="#"><img src="img/icons/twitter.png"></a></li>
								<li><a href="#"><img src="img/icons/instagram.png"></a></li>
							</ul>
						</div>						
					</div>
					<div class="widget-heading">
						<h3>Subscribe for Newsletter</h3>
					</div>
					<div class="widget-content">
						<div class="subscribe">
							<form>
								<div class="form-group">
									<input type="text" class="form-control" name="subscribe" placeholder="Email">
									<img src="img/icons/paper_plane.png">
								</div>
							</form>
						</div>						
					</div>
				</div>
			</div> <!-- Footer Widget -->