<template>
  <div>
    <!-- As a heading -->
    <nav
      class="navbar navbar-expand-lg fixed-top"
      style="background-color: rgba(0, 0, 0, 0.1)"
    >
      <div class="container">
        <router-link
          :to="{ name: 'home' }"
          class="nav-link active navbar-brand fs-3"
          aria-current="page"
        >
          <img
            src="../public/assets/logo_to_prisma-03.png"
            alt=""
            width="220"
            height="80"  
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
    margin-left: 100px !important;
  }
}
</style>
