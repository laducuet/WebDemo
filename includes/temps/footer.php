<?php $images = "layout/images/"; ?>
<div class="bg-white">
  <div class="container">
    <li style="list-style:none">
      <hr class="dropdown-divider  my-3">
    </li>
    <footer class="row row-cols-5 py-2 my-3  justify-content-between class-for-footer">
      <div class="col-8 col-lg-4 col-xl-3">
        <a href="index.php" class="align-items-center  mb-3 link-dark text-decoration-none ">
          <img class="navbar-icon" src="<?php echo $images."Logo2.png" ?>" alt=" Logo">
        </a>
        <p class=" text-muted">&copy; 2023 Team 9 , CNPM.</p>
      </div>

      <div class="col-8 col-lg-4 col-xl-3">
        <h5>Developed By</h5>
        <ul class="nav flex-column">
          <li class="nav-item mb-2"><a target="_blank" href="https://www.facebook.com/profile.php?id=100013649135598"
              class="nav-link p-0 text-muted">Le Anh Duc</a></li>
          <li class="nav-item mb-2"><a href="https://www.facebook.com/nguyentutrung.10122003" target="_blank"
              class="nav-link p-0 text-muted">Nguyen Tu Trung</a></li>
          <li class="nav-item mb-2"><a target="_blank" href="https://www.facebook.com/tap.hoc.3910"
              class="nav-link p-0 text-muted">Nguyen Quang Thanh</a></li>
          <li class="nav-item mb-2"><a target="_blank" href="https://www.facebook.com/profile.php?id=100044245673749"
              class="nav-link p-0 text-muted">Le Hai Nam</a></li>
        </ul>
      </div>

    </footer>
  </div>
</div>
<script src="<?php echo $js; ?>popper.min.js"></script>
<script src="<?php echo $js; ?>bootstrap.min.js"></script>
<script src="<?php echo $js; ?>frontend.js"></script>
</body>

</html>