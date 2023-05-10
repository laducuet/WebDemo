<?php
  ob_start();
  $pageTitle = 'Home Page';
  require "init.php";
  $categories = getCategories($db);
  $itemImages = getItemsImages($db);
  $categories = array_reverse($categories);
  
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
			</div> <!-- End of Breadcrumb-->

			<div class="new-product-section shop">
				<div class="sidebar">
					<div class="sidebar-widget">
						<h3>Category</h3>
						<ul>
							<?php foreach($categories as $cat): ?>
								<li><a href="<?php echo "childcat.php?cat=".urlencode($cat['categoryId']); ?>"><?php echo $cat['categoryName'] ?></a></li>
							<?php endforeach; ?>
						</ul>
					</div>
					<!-- <div class="sidebar-widget">
						<h3>Range Filter</h3>
						<p>
						  <label for="amount"></label>
						  <input type="text" id="amount" readonly style="border:0; color:#F0E68C;  margin-bottom: 5px;">
						</p>						 
						<div id="slider-range"></div>
					</div> -->
				</div>
				<div class="product-content">
					<?php foreach($categories as $cat): ?>
							<div class="product">
								<a href="<?php echo "childcat.php?cat=".urlencode($cat['categoryId']); ?>">
									<img src="<?php
										$image_path = "layout/images/" . $cat['categoryName'] . ".png";
										echo $image_path;
									?>">
								</a>
								<div class="product-detail">
									<h3><?php echo $cat['categoryName'] ?></h3>
									<a href="<?php echo "childcat.php?cat=".urlencode($cat['categoryId']); ?>">VIEW MORE</a>
								</div>
							</div>
					<?php endforeach; ?>
				</div>	
			</div> <!-- New Product Section -->	
			<div class="load-more">
				<a href="#">Load More</a>
			</div>		
		</main> <!-- Main Area -->
	</div>
<?php
include $tpl . "footer.php";
ob_end_flush(); ?>	