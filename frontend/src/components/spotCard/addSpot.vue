<script setup>
import { ref, onMounted } from "vue";
import { offlineApi, api } from '../../api';
import { useRouter, useRoute } from 'vue-router';

const router = useRouter();
const route = useRoute();

let nama_venue = ref("");
let spot_name = ref("");
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

// Fetch data when the component is mounted
onMounted(() => {
  fetchData();
});

//fetch detail data post by ID
const fetchData = async () => {
  try {
    const response = await api.get(`/api/venues/${route.params.id}`);
    let responseData = response.data.data; // Extract data from the response
    // Assign JSON values to variables
    nama_venue.value = responseData.nama_venue;
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
    } catch (axiosError) {
      console.error("Error fetching data with Axios:", axiosError);
    }
  }
};

const submitForm = async () => {
  // Create a FormData object
  const formData = new FormData();

  // Append data to the FormData object
  formData.append("id_venue", route.params.id);
  formData.append("spot_name", spot_name.value);
  formData.append("kapasitas", kapasitas.value);
  formData.append("indoor_outdoor", indoor_outdoor.value);
  formData.append("kursi", kursi.value);
  formData.append("r_meeting", r_meeting.value);
  formData.append("genset", genset.value);
  formData.append("sound_system", sound_system.value);
  formData.append("r_makeup", r_makeup.value);
  formData.append("m_panggung", m_panggung.value);
  formData.append("r_transit", r_transit.value);
  formData.append("listrik", listrik.value);
  formData.append("other_fac", other_fac.value);
  formData.append("halfday", halfday.value);
  formData.append("fullday", fullday.value);
  formData.append("other_harga", other_harga.value);

  try {
    // Store data with API
    await api.post("/api/spots", formData);

    // Redirect upon success
    router.push({ name: "show", params: { id: route.params.id } });
  } catch (error) {
    // Assign response error data to state "errors"
    console.error(error)

    // If an error occurs, run an alternative post request using Axios
    try {
      await offlineApi.post("/api/spots", formData);
      // Redirect upon success
      router.push({ name: "show", params: { id: route.params.id } });
    } catch (axiosError) {
      console.error("Error posting data with Axios:", axiosError);
    }
  }
};

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
            <form @submit.prevent="submitForm">
              <!-- Start of Venue Section -->
              <h1 class="text-center mb-3">{{ nama_venue }}</h1>

              <div class="separator my-5">
                <div class="text-bg fs-5 fw-bold">ADD SPOT VENUE</div>
              </div>

              <!-- Start of Spot Section -->
              <div class="row justify-content-center">
                <div class="row my-3">
                  <div class="col-lg-8">
                    <div class="row align-items-center">
                      <label for="spot_name" class="col-lg-2 col-form-label">
                        <strong> Nama Spot </strong></label
                      >
                      <div class="col-1 d-none d-sm-block">:</div>
                      <div class="col-lg-9">
                        <input
                          type="text"
                          class="form-control"
                          id="spot_name"
                          v-model="spot_name"
                          aria-describedby="spot_nameHelp"
                          autocomplete="off"
                          required
                        />
                      </div>
                    </div>
                  </div>
                  <div class="col-lg-4">
                    <div class="row align-items-center">
                      <label for="kapasitas" class="col-lg-5 col-form-label">
                        <strong> Kapasitas </strong></label
                      >
                      <div class="col-1 d-none d-sm-block">:</div>
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
                  <div class="col-lg-4 order-lg-2 ">
                    <div class="row align-items-center">
                      <label
                        for="indoor_outdoor"
                        class="col-lg-5 col-form-label"
                      >
                        <strong> Indoor/Outdoor </strong></label
                      >
                      <div class="col-1 d-none d-sm-block">:</div>
                      <div class="col-lg-6">
                        <select class="form-select" id="area" v-model="indoor_outdoor">
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

<style>
@media screen and (max-width: 768px){
  .fasilitasClass{
    float: right !important;
  }
}
</style>
