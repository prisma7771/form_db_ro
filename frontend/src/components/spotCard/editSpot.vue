<script setup>
import { ref, onMounted } from "vue";
import { offlineApi, api } from "../../api";
import { useRouter, useRoute } from "vue-router";

const router = useRouter();
const route = useRoute();

const spot_name = ref("");
const kapasitas = ref(0);
const indoor_outdoor = ref("-");
const kursi = ref(0);
const r_meeting = ref(0);
const genset = ref(0);
const sound_system = ref(0);
const r_makeup = ref(0);
const m_panggung = ref(0);
const r_transit = ref(0);
const listrik = ref(0);
const other_fac = ref("");
const halfday = ref(0);
const fullday = ref(0);
const other_harga = ref("");
const errors = ref("");

const updateForm = async () => {
  const formData = new FormData();
  formData.append("spot[spot_name]", spot_name.value || "None");
  formData.append("spot[kapasitas]", kapasitas.value || 0);
  formData.append("spot[indoor_outdoor]", indoor_outdoor.value || "-");
  formData.append("spot[kursi]", kursi.value || 0);
  formData.append("spot[r_meeting]", r_meeting.value || 0);
  formData.append("spot[genset]", genset.value || 0);
  formData.append("spot[sound_system]", sound_system.value || 0);
  formData.append("spot[r_makeup]", r_makeup.value || 0);
  formData.append("spot[m_panggung]", m_panggung.value || 0);
  formData.append("spot[r_transit]", r_transit.value || 0);
  formData.append("spot[listrik]", listrik.value || 0);
  formData.append("spot[other_fac]", other_fac.value || "-");
  formData.append("spot[halfday]", halfday.value || 0);
  formData.append("spot[fullday]", fullday.value || 0);
  formData.append("spot[other_harga]", other_harga.value || "-");

  formData.append("_method", "PATCH");

  try {
    const response = await api.post(`/api/spots/${route.params.idS}`, formData);
    router.push({ name: "show", params: { id: route.params.id } });
  } catch (error) {
    errors.value = error.response;
    try {
      const axiosResponse = await offlineApi.post(`/api/spots/${route.params.idS}`, formData);
      router.push({ name: "show", params: { id: route.params.id } });
    } catch (axiosError) {
      console.error("Error posting data with Axios:", axiosError);
    }
  }
};

const fetchData = async () => {
  try {
    const response = await api.get(`/api/spots/${route.params.idS}`);
    const responseData = response.data.data;
    assignValues(responseData);
  } catch (error) {
    console.error(error);
    try {
      const axiosResponse = await offlineApi.get(`/api/spots/${route.params.idS}`);
      assignValues(axiosResponse.data.data);
    } catch (axiosError) {
      console.error("Error fetching data with Axios:", axiosError);
    }
  }
};

const assignValues = (data) => {
  spot_name.value = data.spot_name || "-";
  kapasitas.value = data.kapasitas || 0;
  indoor_outdoor.value = data.indoor_outdoor || "-";
  kursi.value = data.kursi || 0;
  r_meeting.value = data.r_meeting || 0;
  genset.value = data.genset || 0;
  sound_system.value = data.sound_system || 0;
  r_makeup.value = data.r_makeup || 0;
  m_panggung.value = data.m_panggung || 0;
  r_transit.value = data.r_transit || 0;
  listrik.value = data.listrik || 0;
  other_fac.value = data.other_fac || "";
  halfday.value = data.halfday || 0;
  fullday.value = data.fullday || 0;
  other_harga.value = data.other_harga || "";
};

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
            <form @submit.prevent="updateForm">
              <!-- Start of Venue Section -->

              <div class="separator my-5">
                <div class="text-bg fs-5 fw-bold">EDIT SPOT VENUE</div>
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
                  <div class="col-lg-4 order-lg-2">
                    <div class="row align-items-center">
                      <label
                        for="indoor_outdoor"
                        class="col-lg-5 col-form-label"
                      >
                        <strong> Indoor/Outdoor </strong></label
                      >
                      <div class="col-1 d-none d-sm-block">:</div>
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
