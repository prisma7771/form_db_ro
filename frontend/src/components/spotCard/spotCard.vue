<script setup>
import { defineProps } from 'vue';

const { data } = defineProps(['data']);

const displayValue = (value) => {
  return value ? value : "-";
};

const formattedCurrency = (item) => {
  const RP = item;
  if (!isNaN(RP)) {
    return `Rp ${RP.toFixed(0).replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.")}`;
  }
  return RP;
};
</script>
<template>
     <div v-if="data">
        <section id="spot" class="mb-5 px-2">
    <div class="col-md-12">
      <div class="row">
        <div class="col-lg-8 col-sm-12">
          <div class="row align-items-center mb-3">
            <div class="col-lg-2">
              <strong>Nama Spot</strong>
            </div>
            <div class="col-1 d-none d-lg-block">:</div>
            <div class="col-lg-8 bg-white opacity-50 text-black rounded lh-lg">
              {{ data.spot_name }}
            </div>
          </div>
        </div>
        <div class="col-lg-4 col-sm-12">
          <div class="row align-items-center mb-3">
            <div class="col-lg-5">
              <strong>Kapasitas</strong>
            </div>
            <div class="col-1 d-none d-lg-block">:</div>
            <div class="col-lg-5 bg-white opacity-50 text-black rounded lh-lg">
              {{ data.kapasitas }}
            </div>
          </div>
        </div>
      </div>

      <!-- list Fasilitas -->
    </div>
    <div class="row">
      <div class="col-lg-8 col-12">
        <div class="row align">
          <div class="col-lg-2">
            <strong>Fasilitas</strong>
          </div>
          <div class="col-1 d-none d-lg-block">:</div>
          <div class="col-lg-3 col-7">
            <ul class="custom-list">
              <li>Kursi</li>
              <li>R. Meeting</li>
              <li>Genset</li>
              <li>Sound System</li>
              <li>R. Makeup</li>
              <li class="d-none d-lg-block">Modul Panggung</li>
              <li class="d-lg-none d-block">M. Panggung</li>
              <li>R. Transit</li>
              <li>Listrik</li>
            </ul>
          </div>
          <div class="col-lg-5 col-5">
            <ul class="custom-list2">
              <li class="bg-white opacity-50 text-black rounded px-2">
                {{ data.kursi }}
              </li>
              <li class="bg-white opacity-50 text-black rounded px-2">
                {{ data.r_meeting }}
              </li>
              <li class="bg-white opacity-50 text-black rounded px-2">
                {{ data.genset }}
              </li>
              <li class="bg-white opacity-50 text-black rounded px-2">
                {{ data.sound_system }}
              </li>
              <li class="bg-white opacity-50 text-black rounded px-2">
                {{ data.r_makeup }}
              </li>
              <li class="bg-white opacity-50 text-black rounded px-2">
                {{ data.m_panggung }}
              </li>
              <li class="bg-white opacity-50 text-black rounded px-2">
                {{ data.r_transit }}
              </li>
              <li class="bg-white opacity-50 text-black rounded px-2">
                {{ data.listrik }}
              </li>
            </ul>
          </div>
        </div>
        <div class="row">
          <div class="col-12">
            <div class="row align-items-center mb-3">
              <div class="col-lg-3"></div>
              <div class="col-lg-2">Lain-Lain</div>
              <div
                class="col-lg-6 bg-white opacity-50 text-black rounded px-2 lh-lg"
              >
                {{ data.other_fac }}
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-12">
            <div class="row mt-4">
              <div class="col-lg-2">
                <strong>Harga</strong>
              </div>
              <div class="col-1 d-none d-lg-block">:</div>
              <div class="col-lg-3 col-4">
                <ul class="custom-list">
                  <li>Halfday</li>
                  <li>Fullday</li>
                </ul>
              </div>
              <div class="col-lg-5 col-8">
                <ul class="custom-list2">
                  <li class="bg-white opacity-50 text-black rounded px-2">
                    {{ formattedCurrency(data.halfday) }}
                  </li>
                  <li class="bg-white opacity-50 text-black rounded px-2">
                    {{ formattedCurrency(data.fullday) }}
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-12">
            <div class="row align-items-center mb-3">
              <div class="col-lg-3"></div>
              <div class="col-lg-2">Lain-Lain</div>
              <div
                class="col-lg-6 bg-white opacity-50 text-black rounded px-2 lh-lg"
              >
                {{ displayValue(data.other_harga) }}
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="col-lg-4">
        <div class="row align-items-center mb-3">
          <div class="col-lg-5">
            <strong>Indoor/Outdoor</strong>
          </div>
          <div class="col-1 d-none d-lg-block">:</div>
          <div class="col-lg-5 bg-white opacity-50 text-black rounded lh-lg">
            {{ displayValue(data.indoor_outdoor) }}
          </div>
        </div>
      </div>
    </div>
  </section>
    </div>
 
    <div v-else>
    <!-- Optional: Show a loading indicator or message while data is being fetched -->
    Loading...
  </div>

</template>

<style>

/* Custom list style */
.custom-list {
  list-style-type: none; /* Remove the default list-style-type */
  padding-left: 0; /* Remove default left padding */
}

/* Custom list item style */
.custom-list li {
  position: relative;
  padding-left: 2em; /* Adjust padding for spacing between text and square */
  line-height: 2;
  margin: 10px 0; /* Adjust line height as needed */
}

/* Custom list item square */
.custom-list li::before {
  content: "\25A0"; /* Unicode character for a solid square */
  position: absolute;
  left: 0;
  top: 0.1em; /* Adjust this value to align the square with text */
  font-size: inherit; /* Use the same font size as the parent element */
}

/* Second custom list style */
.custom-list2 {
  list-style-type: none; /* Remove the default list-style-type */
  padding-left: 0; /* Remove default left padding */
}

/* Second custom list item style */
.custom-list2 li {
  position: relative;
  padding-left: 1em; /* Adjust padding for spacing between text and square */
  line-height: 2;
  margin: 10px; /* Adjust line height as needed */
}

</style>