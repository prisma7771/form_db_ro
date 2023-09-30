<script setup>
import { ref, onMounted, computed } from "vue";
import { offlineApi, api } from '../api';
import { useRouter, useRoute } from "vue-router";

const router = useRouter();
const route = useRoute();

let nama_venue = ref("");
let cp_marketing = ref("");
let no_cp = ref("");
let address = ref("");
let area = ref("-");

let harga_pack = ref(0);
let lain_lain = ref("");

let charge = ref(0);

let errors = ref("");

const updateForm = async () => {
  // Create a FormData object
  const formData = new FormData();

  // Append form data to the FormData object for venue updates
  formData.append("venue[nama_venue]", nama_venue.value || "-");
  formData.append("venue[cp_marketing]", cp_marketing.value || "-");
  formData.append("venue[no_cp]", no_cp.value || "-");
  formData.append("venue[address]", address.value || "-");
  formData.append("venue[area]", area.value || "-");
  formData.append("venue[harga_pack]", harga_pack.value);
  formData.append("venue[lain_lain]", lain_lain.value || "-");
  formData.append("venue[charge]", charge.value);

  // Append form data to the FormData object for spot updates
  formData.append("_method", "PATCH");

  for (const [key, value] of formData.entries()) {
    console.log(`${key}: ${value}`);
  }

  // Submit form data using the 'api' object
  try {
    const response = await api.post(`/api/venues/${route.params.id}`, formData);
    router.push({ name: "show", params: { id: route.params.id } }); // Redirect to the 'show' route with the updated ID
  } catch (error) {
    // Handle any errors with the 'api' request
    errors.value = error.response;

    // If an error occurs, run an alternative POST request using Axios
    try {
      const axiosResponse = await offlineApi.post(
        `/api/venues/${route.params.id}`,
        formData
      );
      // Handle the Axios response here as needed
      router.push({ name: "show", params: { id: route.params.id } });
    } catch (axiosError) {
      console.error("Error posting data with Axios:", axiosError);
      // Handle the Axios error as needed
    }
  }
};

//fetch detail data post by ID
const fetchData = async () => {
  try {
    const response = await api.get(`/api/venues/${route.params.id}`);
    let responseData = response.data.data; // Extract data from the response

    // Assign JSON values to variables
    nama_venue.value = responseData.nama_venue;
    cp_marketing.value = responseData.cp_marketing;
    no_cp.value = responseData.no_cp;
    address.value = responseData.address;
    area.value = responseData.area;

    harga_pack.value = responseData.harga_pack;
    lain_lain.value = responseData.lain_lain;
    charge.value = responseData.charge;
  } catch (error) {
    // Handle any errors here
    console.error(error);

    // If an error occurs, run an alternative GET request using Axios
    try {
      const axiosResponse = await offlineApi.get(
        `/api/venues/${route.params.id}`
      );
      // Handle the Axios response here as needed
      let responseData = axiosResponse.data.data; // Extract data from the response

      // Assign JSON values to variables
      nama_venue.value = responseData.nama_venue;
      cp_marketing.value = responseData.cp_marketing;
      no_cp.value = responseData.no_cp;
      address.value = responseData.address;
      area.value = responseData.area;

      harga_pack.value = responseData.harga_pack;
      lain_lain.value = responseData.lain_lain;
      charge.value = responseData.charge;
    } catch (axiosError) {
      console.error("Error fetching data with Axios:", axiosError);
    }
  }
};

// Fetch data when the component is mounted
onMounted(() => {
  fetchData();
});
</script>

<template>
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div
          class="card border-0 rounded shadow bg-dark"
          style="--bs-bg-opacity: 0.15"
        >
          <div class="card-body">
            <form @submit.prevent="updateForm()">
              <!-- Start of Venue Section -->
              <h1>VENUE</h1>
              <div class="col-lg-6">
                <div class="mt-3 mb-3 row align-items-center">
                  <label for="nama_venue" class="col-lg-3 col-form-label">
                    <strong> Nama Venue </strong></label
                  >
                  <div class="col-lg-9">
                    <input
                      type="text"
                      class="form-control"
                      id="nama_venue"
                      v-model="nama_venue"
                      aria-describedby="nama_venueHelp"
                      placeholder="Name Venue can't be empty"
                      autocomplete="off"
                      required
                    />
                  </div>
                </div>
                <div class="mb-3 row align-items-center">
                  <label for="cp_marketing" class="col-lg-3 form-label"
                    ><strong>CP Marketing</strong></label
                  >
                  <div class="col-lg-9">
                    <input
                      type="text"
                      class="form-control"
                      id="cp_marketing"
                      v-model="cp_marketing"
                      aria-describedby="descHelp"
                      autocomplete="off"
                    />
                  </div>
                </div>
                <div class="mb-3 row align-items-center">
                  <label for="cp_marketing" class="col-lg-3 form-label"
                    ><strong>No CP</strong></label
                  >
                  <div class="col-lg-9">
                    <input
                      type="text"
                      class="form-control"
                      id="no_cp"
                      v-model="no_cp"
                      aria-describedby="no_cpHelp"
                      autocomplete="off"
                    />
                  </div>
                </div>
                <div class="mb-3 row align-items-center">
                  <label for="address" class="col-lg-3 col-form-label">
                    <strong> Address </strong></label
                  >
                  <div class="col-lg-9">
                    <input
                      type="text"
                      class="form-control"
                      id="address"
                      v-model="address"
                      aria-describedby="addressHelp"
                      autocomplete="off"
                    />
                  </div>
                </div>
                <div class="mb-3 row align-items-center">
                  <label for="area" class="col-lg-3 col-form-label">
                    <strong> Area </strong></label
                  >
                  <div class="col-lg-9">
                    <select class="form-select" id="area" v-model="area">
                      <option value="Barat">Barat</option>
                      <option value="Timur">Timur</option>
                      <option value="Selatan">Selatan</option>
                      <option value="Utara">Utara</option>
                      <option value="Tengah">Tengah</option>
                    </select>
                  </div>
                </div>
              </div>
              <!-- End of venue section -->

              <div class="separator my-5">
                <div class="text-bg fs-5 fw-bold">KAMAR</div>
              </div>

              <!-- Start of Section Kamar -->
              <div class="row my-3">
                <div class="col-lg-8">
                  <div class="row align-items-center">
                    <div class="col-lg-2">
                      <strong>Harga/Pack</strong>
                    </div>
                    <div class="col-1 d-none d-lg-block">:</div>
                    <div class="col-lg-8">
                      <input
                        type="number"
                        class="form-control"
                        id="harga_pack"
                        v-model="harga_pack"
                        aria-describedby="harga_packHelp"
                      />
                    </div>
                  </div>
                </div>
              </div>
              <div class="row mb-3">
                <div class="col-lg-8">
                  <div class="row align-items-center">
                    <div class="col-lg-3"></div>
                    <div class="col-lg-2">
                      <strong>Lain-Lain</strong>
                    </div>
                    <div class="col-lg-6">
                      <input
                        type="text"
                        class="form-control"
                        id="lain_lain"
                        v-model="lain_lain"
                        aria-describedby="lain_lainHelp"
                        autocomplete="off"
                      />
                    </div>
                  </div>
                </div>
              </div>
              <!-- End of Section Kamar -->

              <div class="separator my-5">
                <div class="text-bg fs-5 fw-bold">CHARGE</div>
              </div>

              <!-- Start of Section Charge -->
              <div class="row mt-3 my-5">
                <div class="col-lg-8">
                  <div class="row align-items-center">
                    <div class="col-lg-2">
                      <strong>Charge</strong>
                    </div>
                    <div class="col-1 d-none d-lg-block">:</div>
                    <div class="col-lg-8">
                      <input
                        type="number"
                        class="form-control"
                        id="charge"
                        v-model="charge"
                        aria-describedby="chargeHelp"
                      />
                    </div>
                  </div>
                </div>
              </div>
              <!-- End of Section Charge -->

              <div class="row justify-content-end">
                <div class="col-lg-2">
                  <button type="submit" class="btn btn-primary fs-3">
                    SUBMIT
                  </button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style></style>
