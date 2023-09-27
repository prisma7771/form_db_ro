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
let area = ref("");

let total_spot = ref(0);
let spot_name = ref("None");
let kapasitas = ref(0);
let indoor_outdoor = ref("-");
let kursi = ref(0);
let r_meeting = ref(0);
let genset = ref(0);
let sound_system = ref(0);
let r_makeup = ref(0);
let m_panggung = ref(0);
let r_transit = ref(0);
let listrik = ref(0);
let other_fac = ref("");
let halfday = ref(0);
let fullday = ref(0);
let other_harga = ref("");

let harga_pack = ref(0);
let lain_lain = ref("");

let charge = ref(0);

let errors = ref("");

const updateForm = async () => {
  // Create a FormData object
  const formData = new FormData();

  // Append form data to the FormData object for venue updates
  formData.append("venue[nama_venue]", nama_venue.value);
  formData.append("venue[cp_marketing]", cp_marketing.value);
  formData.append("venue[no_cp]", no_cp.value);
  formData.append("venue[address]", address.value);
  formData.append("venue[area]", area.value);
  formData.append("venue[harga_pack]", harga_pack.value);
  formData.append("venue[lain_lain]", lain_lain.value);
  formData.append("venue[charge]", charge.value);

  // Append form data to the FormData object for spot updates
  formData.append("spot[total_spot]", total_spot.value);
  formData.append("spot[spot_name]", spot_name.value);
  formData.append("spot[kapasitas]", kapasitas.value);
  formData.append("spot[indoor_outdoor]", indoor_outdoor.value);
  formData.append("spot[kursi]", kursi.value);
  formData.append("spot[r_meeting]", r_meeting.value);
  formData.append("spot[genset]", genset.value);
  formData.append("spot[sound_system]", sound_system.value);
  formData.append("spot[r_makeup]", r_makeup.value);
  formData.append("spot[m_panggung]", m_panggung.value);
  formData.append("spot[r_transit]", r_transit.value);
  formData.append("spot[listrik]", listrik.value);
  formData.append("spot[other_fac]", other_fac.value);
  formData.append("spot[halfday]", halfday.value);
  formData.append("spot[fullday]", fullday.value);
  formData.append("spot[other_harga]", other_harga.value);
  formData.append("_method", "PATCH");

  // for (const [key, value] of formData.entries()) {
  //   console.log(`${key}: ${value}`);
  // }

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

    total_spot.value = responseData.spots[0].total_spot;
    spot_name.value = responseData.spots[0].spot_name;
    kapasitas.value = responseData.spots[0].kapasitas;
    indoor_outdoor.value = responseData.spots[0].indoor_outdoor;
    kursi.value = responseData.spots[0].kursi;
    r_meeting.value = responseData.spots[0].r_meeting;
    genset.value = responseData.spots[0].genset;
    sound_system.value = responseData.spots[0].sound_system;
    r_makeup.value = responseData.spots[0].r_makeup;
    m_panggung.value = responseData.spots[0].m_panggung;
    r_transit.value = responseData.spots[0].r_transit;
    listrik.value = responseData.spots[0].listrik;
    other_fac.value = responseData.spots[0].other_fac;
    halfday.value = responseData.spots[0].halfday;
    fullday.value = responseData.spots[0].fullday;
    other_harga.value = responseData.spots[0].other_harga;

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

      total_spot.value = responseData.spots[0].total_spot;
      spot_name.value = responseData.spots[0].spot_name;
      kapasitas.value = responseData.spots[0].kapasitas;
      indoor_outdoor.value = responseData.spots[0].indoor_outdoor;
      kursi.value = responseData.spots[0].kursi;
      r_meeting.value = responseData.spots[0].r_meeting;
      genset.value = responseData.spots[0].genset;
      sound_system.value = responseData.spots[0].sound_system;
      r_makeup.value = responseData.spots[0].r_makeup;
      m_panggung.value = responseData.spots[0].m_panggung;
      r_transit.value = responseData.spots[0].r_transit;
      listrik.value = responseData.spots[0].listrik;
      other_fac.value = responseData.spots[0].other_fac;
      halfday.value = responseData.spots[0].halfday;
      fullday.value = responseData.spots[0].fullday;
      other_harga.value = responseData.spots[0].other_harga;

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

              <h1 class="mt-5">FORM VISIT</h1>
              <div class="separator my-5">
                <div class="text-bg fs-5 fw-bold">SPOT VENUE</div>
              </div>

              <!-- Start of Spot Section -->
              <div class="row justify-content-center">
                <div class="col-lg-2 col-4">
                  <div class="row align-items-center">
                    <label for="total_spot" class="form-label col-lg-5"
                      ><strong>Spot:</strong></label
                    >
                    <div class="col-lg-7">
                      <select
                        class="form-select"
                        id="total_spot"
                        v-model="total_spot"
                      >
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                      </select>
                    </div>
                  </div>
                </div>
                <div class="row my-3">
                  <div class="col-lg-8">
                    <div class="row align-items-center">
                      <label for="spot_name" class="col-lg-2 col-form-label">
                        <strong> Nama Spot </strong></label
                      >
                      <div class="col-1 d-none d-lg-block">:</div>
                      <div class="col-lg-9">
                        <input
                          type="text"
                          class="form-control"
                          id="spot_name"
                          v-model="spot_name"
                          aria-describedby="spot_nameHelp"
                          autocomplete="off"
                        />
                      </div>
                    </div>
                  </div>
                  <div class="col-lg-4">
                    <div class="row align-items-center">
                      <label for="kapasitas" class="col-lg-5 col-form-label">
                        <strong> Kapasitas </strong></label
                      >
                      <div class="col-1 d-none d-lg-block">:</div>
                      <div class="col-lg-6">
                        <input
                          type="number"
                          class="form-control"
                          id="kapasitas"
                          v-model="kapasitas"
                          aria-describedby="kapasitasHelp"
                        />
                      </div>
                    </div>
                  </div>
                </div>
                <div class="row mb-3">
                  <div class="col-lg-8 order-1 order-sm-2">
                    <div class="row align-items-center">
                      <div class="col-lg-2 mt-3">
                        <strong>Fasilitas</strong>
                      </div>
                      <div class="col-1 d-none d-lg-block">:</div>
                      <div class="col-lg-3">
                        <span
                          style="
                            font-size: 16px;
                            color: white;
                            margin-right: 10px;
                          "
                          >&#9632;</span
                        >
                        <strong>Kursi</strong>
                      </div>
                      <div class="col-lg-5">
                        <input
                          type="number"
                          class="form-control"
                          id="kursi"
                          v-model="kursi"
                          aria-describedby="kursiHelp"
                        />
                      </div>
                    </div>
                  </div>
                  <div class="col-lg-4 order-lg-2">
                    <div class="row align-items-center">
                      <label
                        for="indoor_outdoor"
                        class="col-lg-5 col-form-label"
                      >
                        <strong> Indoor/Outdoor </strong></label
                      >
                      <div class="col-1 d-none d-lg-block">:</div>
                      <div class="col-lg-6">
                        <select
                          class="form-select"
                          id="area"
                          v-model="indoor_outdoor"
                        >
                          <option value="indoor">Indoor</option>
                          <option value="outdoor">Outdoor</option>
                        </select>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="row mb-3">
                  <div class="col-lg-8">
                    <div class="row align-items-center">
                      <div class="col-lg-3"></div>
                      <div class="col-lg-3">
                        <span
                          style="
                            font-size: 16px;
                            color: white;
                            margin-right: 10px;
                          "
                          >&#9632;</span
                        >
                        <strong>R. Meeting</strong>
                      </div>
                      <div class="col-lg-5">
                        <input
                          type="number"
                          class="form-control"
                          id="r_meeting"
                          v-model="r_meeting"
                          aria-describedby="r_meetingHelp"
                        />
                      </div>
                    </div>
                  </div>
                </div>
                <div class="row mb-3">
                  <div class="col-lg-8">
                    <div class="row align-items-center">
                      <div class="col-lg-3"></div>
                      <div class="col-lg-3">
                        <span
                          style="
                            font-size: 16px;
                            color: white;
                            margin-right: 10px;
                          "
                          >&#9632;</span
                        >
                        <strong>Genset</strong>
                      </div>
                      <div class="col-lg-5">
                        <input
                          type="number"
                          class="form-control"
                          id="genset"
                          v-model="genset"
                          aria-describedby="gensetHelp"
                        />
                      </div>
                    </div>
                  </div>
                </div>
                <div class="row mb-3">
                  <div class="col-lg-8">
                    <div class="row align-items-center">
                      <div class="col-lg-3"></div>
                      <div class="col-lg-3">
                        <span
                          style="
                            font-size: 16px;
                            color: white;
                            margin-right: 10px;
                          "
                          >&#9632;</span
                        >
                        <strong>Sound System</strong>
                      </div>
                      <div class="col-lg-5">
                        <input
                          type="number"
                          class="form-control"
                          id="sound_system"
                          v-model="sound_system"
                          aria-describedby="sound_systemHelp"
                        />
                      </div>
                    </div>
                  </div>
                </div>
                <div class="row mb-3">
                  <div class="col-lg-8">
                    <div class="row align-items-center">
                      <div class="col-lg-3"></div>
                      <div class="col-lg-3">
                        <span
                          style="
                            font-size: 16px;
                            color: white;
                            margin-right: 10px;
                          "
                          >&#9632;</span
                        >
                        <strong>R. Makeup</strong>
                      </div>
                      <div class="col-lg-5">
                        <input
                          type="number"
                          class="form-control"
                          id="r_makeup"
                          v-model="r_makeup"
                          aria-describedby="r_makeupHelp"
                        />
                      </div>
                    </div>
                  </div>
                </div>
                <div class="row mb-3">
                  <div class="col-lg-8">
                    <div class="row align-items-center">
                      <div class="col-lg-3"></div>
                      <div class="col-lg-3">
                        <span
                          style="
                            font-size: 16px;
                            color: white;
                            margin-right: 10px;
                          "
                          >&#9632;</span
                        >
                        <strong>Modul Panggung</strong>
                      </div>
                      <div class="col-lg-5">
                        <input
                          type="number"
                          class="form-control"
                          id="m_panggung"
                          v-model="m_panggung"
                          aria-describedby="m_panggungHelp"
                        />
                      </div>
                    </div>
                  </div>
                </div>
                <div class="row mb-3">
                  <div class="col-lg-8">
                    <div class="row align-items-center">
                      <div class="col-lg-3"></div>
                      <div class="col-lg-3">
                        <span
                          style="
                            font-size: 16px;
                            color: white;
                            margin-right: 10px;
                          "
                          >&#9632;</span
                        >
                        <strong>R. Transit</strong>
                      </div>
                      <div class="col-lg-5">
                        <input
                          type="number"
                          class="form-control"
                          id="r_transit"
                          v-model="r_transit"
                          aria-describedby="r_transitHelp"
                        />
                      </div>
                    </div>
                  </div>
                </div>
                <div class="row mb-3">
                  <div class="col-lg-8">
                    <div class="row align-items-center">
                      <div class="col-lg-3"></div>
                      <div class="col-lg-3">
                        <span
                          style="
                            font-size: 16px;
                            color: white;
                            margin-right: 10px;
                          "
                          >&#9632;</span
                        >
                        <strong>Listrik</strong>
                      </div>
                      <div class="col-lg-5">
                        <input
                          type="number"
                          class="form-control"
                          id="listrik"
                          v-model="listrik"
                          aria-describedby="listrikHelp"
                        />
                      </div>
                    </div>
                  </div>
                </div>
                <div class="row mb-5">
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
                          id="other_fac"
                          v-model="other_fac"
                          aria-describedby="other_facHelp"
                          autocomplete="off"
                        />
                      </div>
                    </div>
                  </div>
                </div>

                <div class="row my-3">
                  <div class="col-lg-8">
                    <div class="row align-items-center">
                      <div class="col-lg-2">
                        <strong>Harga</strong>
                      </div>
                      <div class="col-1 d-none d-lg-block">:</div>
                      <div class="col-lg-3">
                        <span
                          style="
                            font-size: 16px;
                            color: white;
                            margin-right: 10px;
                          "
                          >&#9632;</span
                        >
                        <strong>Halfday</strong>
                      </div>
                      <div class="col-lg-5">
                        <input
                          type="number"
                          class="form-control"
                          id="halfday"
                          v-model="halfday"
                          aria-describedby="halfdayHelp"
                        />
                      </div>
                    </div>
                  </div>
                </div>
                <div class="row mb-3">
                  <div class="col-lg-8">
                    <div class="row align-items-center">
                      <div class="col-lg-3"></div>
                      <div class="col-lg-3">
                        <span
                          style="
                            font-size: 16px;
                            color: white;
                            margin-right: 10px;
                          "
                          >&#9632;</span
                        >
                        <strong>Fullday</strong>
                      </div>
                      <div class="col-lg-5">
                        <input
                          type="number"
                          class="form-control"
                          id="fullday"
                          v-model="fullday"
                          aria-describedby="fulldayHelp"
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
                          id="other_harga"
                          v-model="other_harga"
                          aria-describedby="other_hargaHelp"
                          autocomplete="off"
                        />
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <!-- End of Spot Section -->

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
                    <div class="col-1">:</div>
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
