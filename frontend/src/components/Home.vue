<script setup>
import { ref, onMounted, computed } from "vue";
import { offlineApi, api } from "../api";
import * as XLSX from "xlsx";

const data = ref([]);
const kapasitasSelect = ref("");
const inSelect = ref("");
const searchText = ref("");
const areaSelect = ref("");

let rows = ref([]);

const fetchData = async () => {
  try {
    const response = await api.get("/api/venues");
    data.value = response.data.data;
    data.value.forEach((venue) => {
      venue.spots.forEach((spot) => {
        rows.value.push({
          venue: {
            id: venue.id,
            nama_venue: venue.nama_venue,
            address: venue.address,
            area: venue.area,
            charge: venue.charge,
            cp_marketing: venue.cp_marketing,
            harga_pack: venue.harga_pack,
            lain_lain: venue.lain_lain,
            no_cp: venue.no_cp,
          },
          spot: {
            id_venue: venue.id,
            spot_id: spot.spot_id,
            spot_name: spot.spot_name,
            kapasitas: spot.kapasitas,
            indoor_outdoor: spot.indoor_outdoor,
            kursi: spot.kursi,
          },
        });
      });
    });
    // console.log(response)
  } catch (error) {
    console.error("Error fetching data:", error);
    // If an error occurs, run an alternative request using Axios
    try {
      const axiosResponse = await offlineApi.get("/api/venues");
      // console.log(axiosResponse);
      data.value = axiosResponse.data.data;
      data.value.forEach((venue) => {
        venue.spots.forEach((spot) => {
          rows.value.push({
            venue: {
              id: venue.id,
              nama_venue: venue.nama_venue,
              address: venue.address,
              area: venue.area,
              charge: venue.charge,
              cp_marketing: venue.cp_marketing,
              harga_pack: venue.harga_pack,
              lain_lain: venue.lain_lain,
              no_cp: venue.no_cp,
            },
            spot: {
              id_venue: venue.id,
              spot_id: spot.spot_id,
              spot_name: spot.spot_name,
              kapasitas: spot.kapasitas,
              indoor_outdoor: spot.indoor_outdoor,
              kursi: spot.kursi,
            },
          });
        });
      });
      // Handle the response from Axios here
    } catch (axiosError) {
      console.error("Error fetching data with Axios:", axiosError);
    }
  }
};

const confirmDelete = (spot_id, spot_name) => {
  const confirmed = window.confirm(
    "Are you sure you want to delete " + spot_name + spot_id + "?"
  );
  // console.log(confirmed); // Log the result of the confirmation

  if (confirmed) {
    // Proceed with the deletion by calling deleteVenue
    deleteSpot(spot_id, spot_name);
  }
};

const deleteSpot = async (spot_id, spot_name) => {
  try {
    const response = await api.delete(`/api/spots/${spot_id}`);

    if (response.status === 200) {
      window.alert(spot_name + " Deleted");
      const updatedData = rows.value.filter(
        (item) => item.spot.spot_id !== spot_id
      );
      console.log();
      rows.value = updatedData;
    } else {
      console.log("Error deleting spot:", response);
    }
  } catch (error) {
    console.error("Error deleting spot:", error);

    // If an error occurs, run an alternative delete request using Axios
    try {
      const axiosResponse = await offlineApi.delete(`/api/spots/${spot_id}`);
      // Handle the Axios response here as needed
      if (axiosResponse.status === 200) {
        window.alert(spot_name + " Deleted");
        const updatedData = rows.value.filter(
          (item) => item.spot.spot_id !== spot_id
        );
        rows.value = updatedData;
      } else {
        console.error("Error deleting spot:", response.statusText);
      }
    } catch (axiosError) {
      console.error("Error deleting spot with Axios:", axiosError);
    }
  }
};

onMounted(fetchData);

const filteredData = computed(() => {
  // Create an array of rows, one for each spot
  return rows.value.filter((item) => {
    const kapasitasValue = kapasitasSelect.value;
    const kapasitasMatch =
      !kapasitasValue ||
      checkKapasitasRange(item.spot.kapasitas, kapasitasValue);
    const inMatch =
      !inSelect.value || item.spot.indoor_outdoor === inSelect.value;
    const areaMatch = !areaSelect.value || item.venue.area === areaSelect.value;
    const searchMatch =
      !searchText.value ||
      item.venue.nama_venue
        .toLowerCase()
        .includes(searchText.value.toLowerCase()) ||
      item.venue.address.toLowerCase().includes(searchText.value.toLowerCase());
    return kapasitasMatch && inMatch && areaMatch && searchMatch;
  });
});

function checkKapasitasRange(kapasitas, range) {
  if (range === ">1000") {
    return kapasitas > 1000;
  }
  const [min, max] = range.split("-").map(Number);
  return kapasitas >= min && kapasitas <= max;
}

const resetFilters = () => {
  kapasitasSelect.value = "";
  inSelect.value = "";
  areaSelect.value = "";
  searchText.value = "";
};

const saveAsExcel = () => {
  const flattenedData = [];
  data.value.forEach((venue) => {
    venue.spots.forEach((spot) => {
      const flattenedVenue = { ...venue };
      delete flattenedVenue.spots;
      const flattenedSpot = { ...spot };
      flattenedData.push({ ...flattenedVenue, ...flattenedSpot });
    });
  });
  const ws = XLSX.utils.json_to_sheet(flattenedData);
  const wb = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(wb, ws, "Venue Data");
  XLSX.writeFile(wb, "venue_data.xlsx");
};
</script>

<template>
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div class="d-flex flex-row-reverse mt-3">
          <router-link to="/create">
            <button type="button" class="btn btn-primary btn-responsive">
              Add New Entry <i class="fa-solid fa-plus fa-xl ms-2"></i>
            </button>
          </router-link>
        </div>
        <!-- Filter Dropdowns -->
        <div class="row mt-2">
          <div class="col-md-6">
            <label for="kapasitasFilter" class="form-label"
              >Filter by Kapasitas:</label
            >
            <select
              class="form-select"
              id="kapasitasFilter"
              v-model="kapasitasSelect"
            >
              <option value="">All</option>
              <option value="0-50">0-50</option>
              <option value="50-100">50-100</option>
              <option value="100-300">100-300</option>
              <option value="300-500">300-500</option>
              <option value="500-1000">500-1000</option>
              <option value=">1000">&gt;1000</option>
            </select>
          </div>
          <div class="col-md-6">
            <label for="inFilter" class="form-label"
              >Filter by Indoor/Outdoor:</label
            >
            <select class="form-select" id="inFilter" v-model="inSelect">
              <option value="">All</option>
              <option value="indoor">Indoor</option>
              <option value="outdoor">Outdoor</option>
            </select>
          </div>
          <div class="row mt-2">
            <div class="col-md-4">
              <label for="areaFilter" class="form-label">Filter by Area:</label>
              <select class="form-select" id="areaFilter" v-model="areaSelect">
                <option value="">All</option>
                <option value="Timur">Timur</option>
                <option value="Barat">Barat</option>
                <option value="Utara">Utara</option>
                <option value="Selatan">Selatan</option>
                <option value="Tengah">Tengah</option>
              </select>
            </div>
            <div class="col-md-4">
              <label for="searchText" class="form-label"
                >Search by Name/Lokasi:</label
              >
              <input
                type="search"
                class="form-control"
                id="searchText"
                v-model="searchText"
                placeholder="Search..."
              />
            </div>
            <div class="col-md-4 mt-2">
              <label for="resetFilter" class="form-label"></label><br />
              <button
                type="button"
                class="btn btn-secondary"
                @click="resetFilters"
              >
                Reset
              </button>
            </div>
          </div>
        </div>

        <div
          class="card p-3 my-4 border-0 rounded shadow"
          :style="{ backgroundColor: 'rgba(0, 0, 0, 0.25)' }"
        >
          <div class="card border-0 scrollable-card">
            <div class="card-body">
              <table class="table table-bordered table-sm">
                <thead class="table-azure text-center">
                  <tr class="bg-dark">
                    <th scope="col" class="col-1 text-white">NO</th>
                    <th scope="col" class="col-2 text-white">VENUE</th>
                    <th scope="col" class="col-2 text-white">LOKASI</th>
                    <th scope="col" class="col-1 text-white">AREA</th>
                    <th
                      scope="col"
                      class="col-2 text-white d-none d-md-table-cell"
                    >
                      SPOT
                    </th>
                    <th
                      scope="col"
                      class="col-1 text-white d-none d-md-table-cell"
                    >
                      KAPASITAS
                    </th>
                    <th
                      scope="col"
                      class="col-1 text-white d-none d-md-table-cell"
                    >
                      INDOOR/OUTDOOR
                    </th>
                    <th scope="col" class="col-2 text-white">Option</th>
                  </tr>
                </thead>
                <tbody class="tbody-transparent">
                  <tr
                    class="align-middle"
                    v-for="(item, index) in filteredData"
                    :key="item.id"
                  >
                    <th scope="row" class="text-center">{{ index + 1 }}</th>
                    <td>{{ item.venue.nama_venue }}</td>
                    <td>{{ item.venue.address }}</td>
                    <td class="text-center">{{ item.venue.area }}</td>
                    <td class="text-center d-none d-md-table-cell">
                      {{ item.spot.spot_name }}
                    </td>
                    <td class="text-center d-none d-md-table-cell">
                      {{ item.spot.kapasitas }}
                    </td>
                    <td class="text-center d-none d-md-table-cell">
                      {{ item.spot.indoor_outdoor }}
                    </td>
                    <td class="text-center">
                      <div
                        class="btn-group"
                        role="group"
                        aria-label="Basic mixed styles"
                      >
                        <router-link
                          :to="{ name: 'show', params: { id: item.venue.id } }"
                          tag="button"
                          class="btn btn-success btn-responsive"
                        >
                          <i class="fa-solid fa-eye fa-sm"></i>
                        </router-link>
                        <router-link
                          :to="{
                            name: 'editSpot',
                            params: {
                              id: item.venue.id,
                              idS: item.spot.spot_id,
                            },
                          }"
                          tag="button"
                          class="btn btn-warning btn-responsive"
                        >
                          <i class="fa-solid fa-pencil fa-sm"></i>
                        </router-link>
                        <button
                          type="button"
                          class="btn btn-danger btn-responsive"
                          @click="
                            confirmDelete(
                              item.spot.spot_id,
                              item.spot.spot_name
                            )
                          "
                        >
                          <i class="fa-solid fa-xmark fa-sm"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="d-flex flex-row-reverse m-3">
      <button
        @click="saveAsExcel"
        type="button"
        class="btn btn-success btn-responsive"
      >
        Save as Excel
      </button>
    </div>
  </div>
</template>

<style>
.scrollable-card {
  height: 60vh;
  overflow: scroll;
  background-color: transparent;
  position: relative;
}

.btn-responsive {
  padding: 0.5rem 1rem;
}

.table-azure tr th {
  background-color: blue;
}

.tbody-transparent tr td,
.tbody-transparent tr th {
  background-color: transparent;
  color: aliceblue;
}

@media (max-width: 767px) {
  .btn-responsive {
    padding: 0.25rem 0.5rem; /* Adjust padding for smaller screens */
    font-size: 0.875rem; /* Adjust font size for smaller screens */
  }

  table.table-sm th,
  table.table-sm td {
    font-size: 0.875rem;
    padding: 0.25rem;
  }
}
</style>
