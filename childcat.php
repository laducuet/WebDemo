<?php
  ob_start();
  require "init.php";
  $items = getItems($db);
  $childcategories = getChildCategories($db);
  $childcategories = array_reverse($childcategories);

  if(isset($_GET['cat'])){
    $childcategories = getChildByCategory($db,$_GET['cat']);
  }
?>

<div class="mua_acc_section">
    <div id="main_slider" class="carousel slide" data-ride="carousel">
      <div class="carousel-inner">
        <div class="carousel-item active">
          <div class="container">
            <h1 class="mua_acc_taital">DANH MỤC ACC EFOOTBALL MOBILE</h1>
            <div class="mua_acc_section_2">
              <div class="row">
                <?php foreach($childcategories as $childcat): ?>
                  <div class="col-lg-4 col-sm-4">
                    <div class="box_main">
                      <h4 class="shirt_text" ><?php echo $childcat['childcategoryName'] ?></h4>
                      <p class="price_text">
                        Số lượng: <span style="color: #262626">
                        <?php 
                          echo $childcat['totalItems'];
                        ?>
                      </span>
                      </p>
                      <p class="price_text">
                        Đã bán: <span style="color: #262626">
                        <?php 
                          $count = 0;
                          $n = count($items);
                          for($i=0;$i < $n;++$i){
                            if($items[$i]['childcategoryId']==$childcat['childcategoryId']){
                                $quantity = getQuantityFromOrdersAndItems($items[$i]['itemId'], $db);
                                $count = $count + $quantity;

                              } 
                            }
                          echo $count;
                        ?>
                        </span>
                      </p>
                      <div class="tshirt_img">s
                        <img src="images/{items['description']}.png" />
                      </div>
                      <div class="see_all">
                        <ul>
                          <li><a href="<?php echo "acc.php?childcat=".urlencode($childcat['childcategoryId']); ?>">Xem tất cả</a></li>
                        </ul>
                      </div>
                    </div>
                  </div>
                  <?php endforeach; ?>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
<?php
include $tpl . "footer.php";
ob_end_flush(); ?>