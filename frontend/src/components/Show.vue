<script setup>
import { useRoute } from "vue-router";
import { ref, onMounted, computed } from "vue";
import { offlineApi, api } from '../api';
import html2pdf from "html2pdf.js";

const route = useRoute();
const data = ref({});
const images = ref({});
const columns = ref([]);
const loading = ref(true);

let id_venue = ref(route.params.id);
let image = ref("");
let errors = ref([]);

let activeVenueId = ref();

let includeBackground = ref(false);

onMounted(() => {
  fetchData();
});

const fetchData = async () => {
  try {
    const response1 = await api.get(`/api/venues/${route.params.id}`);
    data.value = response1.data.data;
    const response2 = await api.get(`/api/images/${route.params.id}`);
    images.value = response2.data.data.images;
    columns.value = chunkArray(images.value, 3);
    loading.value = false;
  } catch (error) {
    console.error("Error fetching data:", error);
    loading.value = false;

    // If an error occurs, run an alternative request using Axios
    try {
      const axiosResponse1 = await offlineApi.get(`/api/venues/${route.params.id}`);
      data.value = axiosResponse1.data.data;
      const axiosResponse2 = await offlineApi.get(`/api/images/${route.params.id}`);
      images.value = axiosResponse2.data.data.images;
      columns.value = chunkArray(images.value, 3);
    } catch (axiosError) {
      console.error("Error fetching data with Axios:", axiosError);
    }
  }
};


const formattedCurrency = (item) => {
  const RP = item;
  if (!isNaN(RP)) {
    return `Rp ${RP.toFixed(0).replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.")}`;
  }
  return RP;
};

const generatePDF = async () => {
  includeBackground.value = true;
  console.log(includeBackground.value);
  html2pdf(document.getElementById("pdf-content"), {
    filename: "my-document.pdf",
    margin: 1,
    image: { type: "jpeg", quality: 0.98 },
    html2canvas: { scale: 2 },
    jsPDF: { unit: "mm", format: "tabloid", orientation: "portrait" },
  });
  // includeBackground.value = false;
};

const displayValue = (value) => {
  return value ? value : "-";
};

const formattedPhoneNumber = computed(() =>
  formatPhoneNumber(data.value.no_cp)
);
const whatsappLink = computed(
  () => `https://wa.me/${formattedPhoneNumber.value}`
);

const formatPhoneNumber = (phoneNumber) => {
  if (phoneNumber) {
    phoneNumber = phoneNumber.replace(/[^0-9]/g, "");
    if (phoneNumber.startsWith("0")) {
      phoneNumber = phoneNumber.substring(1);
    } else if (!phoneNumber.startsWith("62")) {
      phoneNumber = "62" + phoneNumber;
    }
  }
  return phoneNumber;
};

const handleFileChange = (e) => {
  image.value = e.target.files[0];
};

const storePost = async () => {
  let formData2 = new FormData();
  formData2.append("image", image.value);
  formData2.append("id_venue", id_venue.value);
  try {
    const response3 = await api.post("/api/images", formData2);
    const image_url = response3.data.data.image;
    const newImage = {
      id_venue: id_venue.value,
      image: image_url,
    };
    images.value.push(newImage);
    columns.value = [];
    columns.value = chunkArray(images.value, 3);
  } catch (error) {
    errors.value = error.response;

    // If an error occurs, run an alternative post request using Axios
    try {
      const axiosResponse = await offlineApi.post(
        "/api/images",
        formData2
      );
      // Handle the Axios response here as needed
      const image_url = axiosResponse.data.data.image;
      const newImage = {
        id_venue: id_venue.value,
        image: image_url,
      };
      images.value.push(newImage);
      columns.value = [];
      columns.value = chunkArray(images.value, 3);
    } catch (axiosError) {
      console.error("Error posting image with Axios:", axiosError);
    }
  }
};

const delImage = async (id) => {
  try {
    const response4 = await api.delete(`/api/images/${id}`);
    if (response4.status === 200) {
      window.alert(id + "Image Deleted");
      const updatedData = images.value.filter((image) => image.id_image !== id);
      images.value = updatedData;
      columns.value = [];
      columns.value = chunkArray(images.value, 3);
      console.log(response4);
    } else {
      console.error("Error deleting image:", response4.statusText);
    }
  } catch (error) {
    console.error("Error deleting image:", error);

    // If an error occurs, run an alternative delete request using Axios
    try {
      const axiosResponse4 = await offlineApi.delete(`/api/images/${id}`);
      if (axiosResponse4.status === 200) {
      window.alert(id + "Image Deleted");
      const updatedData = images.value.filter((image) => image.id_image !== id);
      images.value = updatedData;
      columns.value = [];
      columns.value = chunkArray(images.value, 3);
      console.log(response4);
    } else {
      console.error("Error deleting image:", response4.statusText);
    }
      // Handle the Axios response here as needed
    } catch (axiosError) {
      console.error("Error deleting image with Axios:", axiosError);
    }
  }
};


const chunkArray = (array, chunkCount) => {
  const chunkedArray = Array.from({ length: chunkCount }, () => []);

  for (let i = 0; i < array.length; i++) {
    const chunkIndex = i % chunkCount;
    chunkedArray[chunkIndex].push(array[i]);
  }

  return chunkedArray;
};

const showCarousel = (index_img) => {
  activeVenueId.value = index_img;
  const modal = document.getElementById("carouselModal");
  const modalBackdrop = document.querySelector(".modal-backdrop");
  modal.style.display = "block";
  modalBackdrop.style.display = "block";
};

const closeCarousel = () => {
  const modal = document.getElementById("carouselModal");
  const modalBackdrop = document.querySelector(".modal-backdrop");
  modal.style.display = "none";
  modalBackdrop.style.display = "none";
  activeVenueId.value = null;
};
</script>

<template>
  <div class="container">
    <div class="row pdf-bg" id="pdf-content">
      <div class="col-md-12">
        <h1 class="text-center my-4">Detail Venue</h1>
        <div
          class="card bg-dark border-0 rounded shadow text-white mb-5"
          style="--bs-bg-opacity: 0.25"
        >
          <div class="card-body">
            <div v-if="loading">Loading...</div>
            <div v-else>
              <div id="title" class="mb-5">
                <h2 class="text-center">{{ data.nama_venue }}</h2>
                <h5 class="text-center">
                  {{ data.cp_marketing }}
                  <a
                    :href="whatsappLink"
                    target="_blank"
                    style="text-decoration: none; color: aliceblue"
                  >
                    {{ data.no_cp }}
                  </a>
                </h5>
              </div>
              <section id="location" class="mb-3">
                <div class="col-md-6">
                  <div class="row align-items-center mb-3">
                    <div class="col-3"><strong>Address</strong></div>
                    <div class="col-1">:</div>
                    <div
                      class="col-8 bg-white opacity-50 text-black rounded lh-lg"
                    >
                      {{ displayValue(data.address) }}
                    </div>
                  </div>

                  <div class="row align-items-center">
                    <div class="col-3"><strong>Area</strong></div>
                    <div class="col-1">:</div>
                    <div
                      class="col-8 bg-white opacity-50 text-black rounded lh-lg"
                    >
                      {{ displayValue(data.area) }}
                    </div>
                  </div>
                </div>
              </section>
              <div class="separator my-5">
                <div class="text-bg fs-3 fw-bold">SPOT VENUE</div>
              </div>
              <!-- Start of Section Spot -->
              <section id="spot" class="mb-5">
                <div class="col-md-12">
                  <div class="row">
                    <div class="col-lg-8 col-sm-12">
                      <div class="row align-items-center mb-3">
                        <div class="col-2">
                          <strong>Nama Spot</strong>
                        </div>
                        <div class="col-1">:</div>
                        <div
                          class="col-8 bg-white opacity-50 text-black rounded lh-lg"
                        >
                          {{ data.spots[0].spot_name }}
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-4 col-sm-12">
                      <div class="row align-items-center mb-3">
                        <div class="col-lg-5 col-3">
                          <strong>Kapasitas</strong>
                        </div>
                        <div class="col-1">:</div>
                        <div
                          class="col-5 bg-white opacity-50 text-black rounded lh-lg"
                        >
                          {{ data.spots[0].kapasitas }}
                        </div>
                      </div>
                    </div>
                  </div>

                  <!-- list Fasilitas -->
                </div>
                <div class="row">
                  <div class="col-lg-8 col-12">
                    <div class="row align">
                      <div class="col-lg-2 col-3">
                        <strong>Fasilitas</strong>
                      </div>
                      <div class="col-1">:</div>
                      <div class="col-lg-3 col-5">
                        <ul class="custom-list">
                          <li>Kursi</li>
                          <li>R. Meeting</li>
                          <li>Genset</li>
                          <li>Sound System</li>
                          <li>R. Makeup</li>
                          <li>Modul Panggung</li>
                          <li>R. Transit</li>
                          <li>Listrik</li>
                        </ul>
                      </div>
                      <div class="col-lg-5 col-3">
                        <ul class="custom-list2">
                          <li
                            class="bg-white opacity-50 text-black rounded px-2"
                          >
                            {{ data.spots[0].kursi }}
                          </li>
                          <li
                            class="bg-white opacity-50 text-black rounded px-2"
                          >
                            {{ data.spots[0].r_meeting }}
                          </li>
                          <li
                            class="bg-white opacity-50 text-black rounded px-2"
                          >
                            {{ data.spots[0].genset }}
                          </li>
                          <li
                            class="bg-white opacity-50 text-black rounded px-2"
                          >
                            {{ data.spots[0].sound_system }}
                          </li>
                          <li
                            class="bg-white opacity-50 text-black rounded px-2"
                          >
                            {{ data.spots[0].r_makeup }}
                          </li>
                          <li
                            class="bg-white opacity-50 text-black rounded px-2"
                          >
                            {{ data.spots[0].m_panggung }}
                          </li>
                          <li
                            class="bg-white opacity-50 text-black rounded px-2"
                          >
                            {{ data.spots[0].r_transit }}
                          </li>
                          <li
                            class="bg-white opacity-50 text-black rounded px-2"
                          >
                            {{ data.spots[0].listrik }}
                          </li>
                        </ul>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-12">
                        <div class="row align-items-center mb-3">
                          <div class="col-lg-3 col-4"></div>
                          <div class="col-lg-2 col-3">Lain-Lain</div>
                          <div
                            class="col-lg-6 col-5 bg-white opacity-50 text-black rounded px-2 lh-lg"
                          >
                            {{ data.spots[0].other_fac }}
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-12">
                        <div class="row mt-5">
                          <div class="col-lg-2 col-3">
                            <strong>Harga</strong>
                          </div>
                          <div class="col-1">:</div>
                          <div class="col-lg-3 col-5">
                            <ul class="custom-list">
                              <li>Halfday</li>
                              <li>Fullday</li>
                            </ul>
                          </div>
                          <div class="col-lg-5 col-3">
                            <ul class="custom-list2">
                              <li
                                class="bg-white opacity-50 text-black rounded px-2"
                              >
                                {{ formattedCurrency(data.spots[0].halfday) }}
                              </li>
                              <li
                                class="bg-white opacity-50 text-black rounded px-2"
                              >
                                {{ formattedCurrency(data.spots[0].fullday) }}
                              </li>
                            </ul>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-12">
                        <div class="row align-items-center mb-3">
                          <div class="col-lg-3 col-4"></div>
                          <div class="col-lg-2 col-3">Lain-Lain</div>
                          <div
                            class="col-lg-6 col-5 bg-white opacity-50 text-black rounded px-2 lh-lg"
                          >
                            {{ displayValue(data.spots[0].other_harga) }}
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <div class="col-lg-4">
                    <div class="row align-items-center mb-3">
                      <div class="col-lg-5 col-4">
                        <strong>Indoor/Outdoor</strong>
                      </div>
                      <div class="col-1">:</div>
                      <div
                        class="col-lg-5 col-7 bg-white opacity-50 text-black rounded lh-lg"
                      >
                        {{ displayValue(data.spots[0].indoor_outdoor) }}
                      </div>
                    </div>
                  </div>
                </div>
              </section>
              <!-- End of Section Spot -->

              <div class="separator my-5">
                <div class="text-bg fs-3 fw-bold">KAMAR</div>
              </div>

              <!-- Start of Section Kamar -->
              <div class="col-lg-8">
                <div class="row align-items-center mb-3">
                  <div class="col-lg-2 col-3">
                    <strong>Harga/Pack</strong>
                  </div>
                  <div class="col-1">:</div>
                  <div
                    class="col-8 bg-white opacity-50 text-black rounded lh-lg"
                  >
                    {{ formattedCurrency(data.harga_pack) }}
                  </div>
                </div>
                <div class="row align-items-center mb-3">
                  <div class="col-lg-3"></div>
                  <div class="col-lg-2 col-3">Lain-Lain</div>
                  <div class="col-1">:</div>
                  <div
                    class="col-lg-5 col-8 bg-white opacity-50 text-black rounded lh-lg"
                  >
                    {{ displayValue(data.lain_lain) }}
                  </div>
                </div>
              </div>
              <!-- End of Section Kamar -->

              <div class="separator my-5">
                <div class="text-bg fs-3 fw-bold">CHARGE</div>
              </div>

              <!-- Start of Secttion Charge -->
              <div class="row">
                <div class="col-lg-8">
                  <div class="row align-items-center mb-3">
                    <div class="col-lg-2 col-3">
                      <strong>Charge</strong>
                    </div>
                    <div class="col-1">:</div>
                    <div
                      class="col-8 bg-white opacity-50 text-black rounded lh-lg"
                    >
                      {{ formattedCurrency(data.charge) }}
                    </div>
                  </div>
                </div>
              </div>
              <!-- End of Section Charge -->
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="d-none d-lg-flex flex-row-reverse m-3">
      <button
        @click="generatePDF"
        type="button"
        class="btn btn-success btn-responsive"
      >
        Generate PDF
      </button>
      <router-link
        :to="{ name: 'edit', params: { id: data.id } }"
        tag="button"
        class="btn btn-warning btn-responsive mx-2"
      >
        EDIT
      </router-link>
    </div>
    <div
      class="card bg-dark border-0 rounded shadow text-white mb-5"
      style="--bs-bg-opacity: 0.25"
    >
      <div class="card-body">
        <h1 class="text-center">Image</h1>
        <form @submit.prevent="storePost()">
          <div class="col-3 mb-3">
            <label class="form-label fw-bold">Image</label>
            <input
              type="file"
              class="form-control"
              @change="handleFileChange($event)"
            />
          </div>

          <button
            type="submit"
            class="btn btn-md btn-primary rounded-sm shadow border-0"
          >
            Save
          </button>
        </form>
        <div class="image-gallery mt-5">
          <div
            class="column"
            v-for="(column, columnIndex) in columns"
            :key="columnIndex"
          >
            <div
              class="image-item"
              v-for="(item, itemIndex) in column"
              :key="item.id_image"
            >
              <img :src="item.image" alt="" />
              <div class="overlay">
                <button class="btn_img" @click="showCarousel(item.id_image)">
                  Show
                </button>
                <button class="btn_del" @click="delImage(item.id_image)">
                  Delete
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal -->
    <div class="modal-backdrop"></div>
    <div
      class="modal"
      id="carouselModal"
      tabindex="-1"
      aria-labelledby="carouselModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <button
            type="button"
            class="btn-close"
            data-dismiss="modal"
            aria-label="Close"
            @click="closeCarousel"
          ></button>
          <div class="modal-body">
            <div id="carouselExample" class="carousel slide">
              <div class="carousel-inner">
                <div
                  class="carousel-item"
                  v-for="(item, index) in images"
                  :class="{ active: item.id_image == activeVenueId }"
                  :key="index"
                >
                  <img :src="item.image" class="d-block w-100" alt="..." />
                </div>
              </div>
              <button
                class="carousel-control-prev"
                type="button"
                data-bs-target="#carouselExample"
                data-bs-slide="prev"
              >
                <span
                  class="carousel-control-prev-icon"
                  aria-hidden="true"
                ></span>
                <span class="visually-hidden">Previous</span>
              </button>
              <button
                class="carousel-control-next"
                type="button"
                data-bs-target="#carouselExample"
                data-bs-slide="next"
              >
                <span
                  class="carousel-control-next-icon"
                  aria-hidden="true"
                ></span>
                <span class="visually-hidden">Next</span>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.pdf-bg {
  font-family: "Quicksand", sans-serif;
}

.modal-backdrop {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(
    0,
    0,
    0,
    0.5
  ); /* Adjust the alpha (0.5) for darkness level */
  z-index: 1050; /* Ensure it's above the modal */
  display: none;
}

.btn_img,
.btn_del {
  border-color: darkgray;
  border-radius: 10px;
  background-color: whitesmoke;
}

.btn_del {
  margin-left: 2px;
}

.btn-close {
  position: absolute;
  right: 0;
  background-color: red;
  opacity: 0.9;
  width: 2em;
  height: 2em;
  z-index: 999;
}

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
.file-input-card {
  width: 300px; /* Adjust the card width as needed */
}

.image-gallery {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.image-gallery .column {
  display: flex;
  height: 100%;
  flex-direction: column;
  gap: 10px;
}

.image-item img {
  width: 100%;
  border-radius: 5px;
  height: 100%;
  object-fit: cover;
}

/* overlay styles */

.image-item {
  position: relative;
  cursor: pointer;
}

.overlay {
  position: absolute;
  width: 100%;
  height: 100%;
  background: rgba(57, 57, 57, 0.502);
  top: 0;
  left: 0;
  transform: scale(0);
  transition: all 0.2s 0.1s ease-in-out;
  color: #fff;
  /* center overlay content */
  display: flex;
  align-items: center;
  justify-content: center;
}

/* hover */
.image-item:hover .overlay {
  transform: scale(1);
}

.carousel-control-prev-icon,
.carousel-control-next-icon {
  scale: 2;
  filter: invert(100%);
}

@media screen and (min-width: 768px) {
  .image-gallery {
    flex-direction: row;
  }

  .pdf-bg {
    background-image: url("../../public/assets/bg_to_prisma-04.png");
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
    border-radius: 10px;
  }
}
</style>
