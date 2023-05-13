<?php
ob_start();
$pageTitle = 'Orders';
$images = "layout/images/";
include "init.php";

$sellerData = getSeller($db, $_SESSION['username'])[0];

$itemIDs = getItemIDsBySellerID($_SESSION['id'], $db);
?>

    <div class="container">
        <h1 class="text-center m-5">History of <?= $sellerData["userName"] ?> </h1>
        <table class="table table-hover text-center">
            <thead class="bg-success text-light">
            <tr>
                <th scope="col">#</th>
                <th scope="col">Price</th>
                <th scope="col">Quantity</th>
                <th scope="col">Order date</th>
                <th scope="col">Buyer</th>
                <th scope="col">Details</th>
            </tr>
            </thead>
            <tbody>
                <?php
                $stt = 1;
                $cnt = count($itemIDs);
                for($i = 0; $i < $cnt; $i++){
                    $orderbyitemId = getOrdersByItemID($itemIDs[$i], $db);
                    $cntOrders = count($orderbyitemId);
                    for($j = 0; $j < $cntOrders; $j++) {
                        $buyer = getBuyerById($orderbyitemId[$j]['buyerId'], $db)[0];
                    ?>
                    <tr>
                        <th scope="row"><?= $stt ?></th>
                        <td> <?= $orderbyitemId[$j]['orderPrice'] ?> </td>
                        <td> <?= $orderbyitemId[$j]['quantity'] ?> </td>
                        <td> <?= $orderbyitemId[$j]['orderDate'] ?></td>
                        <td> <?= $buyer->userName ?> </td>
                        <?php if ($orderbyitemId[$j]['isShip']): ?>
                        <td>
                            <a href="details.php?itemid=<?=$orderbyitemId[$j]['itemId']?>&buyerId=<?=$orderbyitemId[$j]['buyerId']?>&billId=<?=$orderbyitemId[$j]['billId']?>" class="btn btn-primary">View</a>
                        </td>
                        <?php else: ?>
                        <td>
                        </td>
                    <?php endif; ?>
                    </tr>
                    <?php
                    $stt = $stt + 1;
                    }
                }
                ?>
            </tbody>
        </table>
    </div>
<?php include $tpl . "footer.php";
ob_end_flush(); ?>