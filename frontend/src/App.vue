<template>
  <div>
    <!-- As a heading -->
    <nav
      class="navbar navbar-expand-lg fixed-top custom-color"
      style="background-color: rgb(83,134,179)"
    >
      <div class="container justify-content-center justify-content-lg-start">
        <router-link
          :to="{ name: 'home' }"
          class="nav-link active navbar-brand fs-3 la"
          aria-current="page"
        >
          <img
            src="../public/assets/logo_to_prisma-03.png"
            alt=""
            width="220"
            height="80"  
            class="image-logo"
          />
        </router-link>
      </div>
    </nav>

    <!--- render router view -->
    <router-view style="margin-top: 110px"></router-view>
  </div>
</template>

<style>
.modal-opened {
  background-color: rgba(0, 0, 0);
}

/* Separator style */
.separator {
  display: flex;
  align-items: center;
  text-align: center;
  color: black;
}

/* Separator before and after pseudo-elements */
.separator::before,
.separator::after {
  content: "";
  flex: 1;
  border-bottom: 2px solid white;
}

/* Text background style */
.text-bg {
  background-color: white;
  padding: 0 20px; /* Adjust padding for left and right */
  display: inline-block;
  border-radius: 20px;
}

@media screen and (max-width: 767px){
  .navbar-brand{
    text-align: center;
  }

  .image-logo{
    width: 130px;
    height:50px
  }
}
</style>
