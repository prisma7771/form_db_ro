<script setup>
import { useRoute, useRouter } from "vue-router";
import { ref, onMounted, computed } from "vue";
import { offlineApi, api } from "../api";
import html2pdf from "html2pdf.js";

import spotCard from "./spotCard/spotCard.vue";

const route = useRoute();
const router = useRouter();
const data = ref({});
const images = ref([]);
const columns = ref([]);
const loading = ref(true);
let selectedSpotIndex = ref();
let selectedSpotName = ref();

let id_venue = ref(route.params.id);
let image = ref("");
let errors = ref([]);

let activeVenueId = ref();

let includeBackground = ref(false);

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
    // If an error occurs, run an alternative request using Axios
    try {
      const axiosResponse1 = await offlineApi.get(
        `/api/venues/${route.params.id}`
      );
      data.value = axiosResponse1.data.data;

      const axiosResponse2 = await offlineApi.get(
        `/api/images/${route.params.id}`
      );
      if (axiosResponse2.data && axiosResponse2.data.data) {
        images.value = axiosResponse2.data.data.images;
        columns.value = chunkArray(images.value, 3);
        loading.value = false;
        console.log(selectedSpotIndex.value);
      } else {
        console.error("No image data found in the offline response.");
      }
    } catch (axiosError) {
      console.error("Error fetching data with Axios:", axiosError);
    }
  }
};

const confirmDelete = (id, nama_venue) => {
  const confirmed = window.confirm(
    "Are you sure you want to delete " + nama_venue + id + "?"
  );
  // console.log(confirmed); // Log the result of the confirmation

  if (confirmed) {
    // Proceed with the deletion by calling deleteVenue
    deleteVenue(id, nama_venue);
  }
};

const deleteVenue = async (id, nama_venue) => {
  try {
    const response = await api.delete(`/api/venues/${id}`);
    // Redirect upon success
    router.push({ path: "/" });
  } catch (error) {
    console.error("Error deleting spot:", error);

    // If an error occurs, run an alternative delete request using Axios
    try {
      const axiosResponse = await offlineApi.delete(`/api/venues/${id}`);
      // Redirect upon success
      router.push({ path: "/" });
      // Handle the Axios response here as needed
    } catch (axiosError) {
      console.error("Error deleting spot with Axios:", axiosError);
    }
  }
};

const generatePDF = async () => {
  includeBackground.value = true;
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

const formattedCurrency = (item) => {
  const RP = item;
  if (!isNaN(RP)) {
    return `Rp ${RP.toFixed(0).replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.")}`;
  }
  return RP;
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

const selectSpot = (spot_id, spot_name) => {
  selectedSpotIndex.value = spot_id;
  selectedSpotName.value = spot_name;
  console.log(selectedSpotName.value);
  columns.value = [];
  columns.value = chunkArray(filteredImage.value, 3);
};

const handleFileChange = (e) => {
  image.value = e.target.files[0];
};

const storePost = async () => {
  let formData2 = new FormData();
  formData2.append("image", image.value);
  formData2.append("id_venue", id_venue.value);
  formData2.append("spot_id", selectedSpotIndex.value);
  formData2.append("spot_name", selectedSpotName.value);
  formData2.append("nama_venue", data.value.nama_venue);

  //   formData2.forEach((value, key) => {
  //   console.log(key, value);
  // });

  try {
    const response3 = await api.post("/api/images", formData2);
    const dt = response3.data.data;
    console.log(dt);
    const newImage = {
      id_venue: dt.id_venue,
      id_image: dt.id,
      image: dt.image,
      spot_id: dt.spot_id,
    };
    images.value.push(newImage);
    columns.value = [];
    columns.value = chunkArray(filteredImage.value, 3);
  } catch (error) {
    errors.value = error.response;

    // If an error occurs, run an alternative post request using Axios
    try {
      const axiosResponse = await offlineApi.post("/api/images", formData2);
      // Handle the Axios response here as needed
      const dt = axiosResponse.data.data;
      console.log(dt);
      const newImage = {
        id_venue: dt.id_venue,
        id_image: dt.id,
        image: dt.image,
        spot_id: dt.spot_id,
      };
      images.value.push(newImage);
      columns.value = [];
      columns.value = chunkArray(filteredImage.value, 3);
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
      columns.value = chunkArray(filteredImage.value, 3);
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
        const updatedData = images.value.filter(
          (image) => image.id_image !== id
        );
        images.value = updatedData;
        columns.value = [];
        columns.value = chunkArray(filteredImage.value, 3);
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

const filteredImage = computed(() => {
  // Create an array of rows, one for each spot
  return images.value.filter((item) => {
    const imageMatch =
      selectedSpotIndex.value === null ||
      item.spot_id == selectedSpotIndex.value;
    // console.log(item);
    console.log(
      `Item ${item.id_image}:  ${item.spot_id} = ${selectedSpotIndex.value}`,
      imageMatch
    );
    return imageMatch;
  });
});

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
  // console.log(filteredImage.value);
  // console.log(images.value);
  filteredImage.value.forEach((item, index) => {
    // Inside the callback function, you can access each item and its index.
    console.log(item, index);
  });

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

onMounted(() => {
  fetchData();
});
</script>

<template>
  <div class="container">
    <div class="row pdf-bg" id="pdf-content">
      <div class="col-md-12">
        <h1 class="text-center my-3">Detail Venue</h1>
        <div class="d-flex justify-content-end my-2">
          <router-link
            :to="{ name: 'edit', params: { id: data.id } }"
            tag="button"
            class="btn btn-primary btn-responsive"
          >
            Edit Venue
          </router-link>
          <router-link
            :to="{ name: 'addSpot', params: { id: data.id } }"
            tag="button"
            class="btn btn-success btn-responsive mx-2"
          >
            Add Spot
          </router-link>
          <button
            type="button"
            class="btn btn-danger btn-responsive"
            @click="confirmDelete(data.id, data.nama_venue)"
          >
            Delete Venue
          </button>
        </div>
        <div
          class="card bg-dark border-0 rounded shadow text-white mb-3"
          style="--bs-bg-opacity: 0.25"
        >
          <div class="card-body">
            <div v-if="loading">Loading...</div>
            <div v-else>
              <div id="title" class="mb-4">
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
                <div class="col-lg-6 px-2">
                  <div class="row align-items-center mb-3">
                    <div class="col-lg-3"><strong>Address</strong></div>
                    <div class="col-1 d-none d-lg-block">:</div>
                    <div
                      class="col-lg-8 bg-white opacity-50 text-black rounded lh-lg"
                    >
                      {{ displayValue(data.address) }}
                    </div>
                  </div>

                  <div class="row align-items-center">
                    <div class="col-3"><strong>Area</strong></div>
                    <div class="col-1 d-none d-lg-block">:</div>
                    <div
                      class="col-lg-8 bg-white opacity-50 text-black rounded lh-lg"
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

              <div class="d-flex gap-2 justify-content-center">
                <div
                  v-for="(spot, index) in data.spots"
                  :key="spot.spot_id"
                  @click="selectSpot(spot.spot_id, spot.spot_name)"
                  class="p-2 tagSelect mb-3 text-center align-middle"
                  :class="{ active_spot: spot.spot_id == selectedSpotIndex }"
                  style="
                    cursor: pointer;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                  "
                >
                  <span>{{ spot.spot_name }}</span>
                </div>
              </div>

              <div v-for="(spot, index) in data.spots">
                <spot-card
                  :key="spot.spot_id"
                  v-if="selectedSpotIndex == spot.spot_id"
                  :data="spot"
                ></spot-card>
              </div>

              <!-- End of Section Spot -->

              <div class="separator my-5">
                <div class="text-bg fs-3 fw-bold">KAMAR</div>
              </div>

              <!-- Start of Section Kamar -->
              <div class="col-lg-8 px-2">
                <div class="row align-items-center mb-3">
                  <div class="col-lg-2">
                    <strong>Harga/Pack</strong>
                  </div>
                  <div class="col-1 d-none d-lg-block">:</div>
                  <div
                    class="col-lg-8 bg-white opacity-50 text-black rounded lh-lg"
                  >
                    {{ formattedCurrency(data.harga_pack) }}
                  </div>
                </div>
                <div class="row align-items-center mb-3">
                  <div class="col-lg-3"></div>
                  <div class="col-lg-2">Lain-Lain</div>
                  <div class="col-1 d-none d-lg-block">:</div>
                  <div
                    class="col-lg-5 bg-white opacity-50 text-black rounded lh-lg"
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
              <div class="row px-2">
                <div class="col-lg-8">
                  <div class="row align-items-center mb-3">
                    <div class="col-lg-2">
                      <strong>Charge</strong>
                    </div>
                    <div class="col-1 d-none d-lg-block">:</div>
                    <div
                      class="col-lg-8 bg-white opacity-50 text-black rounded lh-lg"
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
    <div class="d-flex flex-row-reverse m-2">
      <button
        @click="generatePDF"
        type="button"
        class="btn btn-success btn-responsive d-none d-lg-block"
      >
        Generate PDF
      </button>
    </div>
    <div
      class="card bg-dark border-0 rounded shadow text-white mb-5"
      style="--bs-bg-opacity: 0.25"
    >
      <div class="card-body">
        <h1 class="text-center">Image</h1>
        <div class="d-flex gap-2 justify-content-center">
          <div
            @click="selectSpot(0, 'Home')"
            class="p-2 tagSelect mb-3 text-center align-middle"
            :class="{ active_spot: 0 == selectedSpotIndex }"
            style="
              cursor: pointer;
              display: flex;
              flex-direction: column;
              align-items: center;
            "
          >
            Venue
          </div>
          <div
            v-for="(spot, index) in data.spots"
            :key="spot.spot_id"
            @click="selectSpot(spot.spot_id, spot.spot_name)"
            class="p-2 tagSelect mb-3 text-center align-middle"
            :class="{ active_spot: spot.spot_id == selectedSpotIndex }"
            style="
              cursor: pointer;
              display: flex;
              flex-direction: column;
              align-items: center;
            "
          >
            <span>{{ spot.spot_name }}</span>
          </div>
        </div>
        <form
          @submit.prevent="storePost()"
          v-show="
            typeof selectedSpotIndex !== 'undefined' && selectedSpotIndex !== ''
          "
        >
          <div class="col-lg-3 mb-3">
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
            class="column col-lg-4"
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
                  v-for="(item, index) in filteredImage"
                  :class="{ active: item.id_image == activeVenueId }"
                  :key="item.id_image"
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
.tagSelect {
  background-color: gray;
  border: 1px solid black;
  border-radius: 15px;
}

.tagSelect.active_spot {
  background-color: black;
  color: white;
}

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
    background-attachment: fixed;
    background-blend-mode: difference;
  }
}
</style>
