import { createApp } from "vue";
import App from "./App.vue";
import { createRouter, createWebHistory } from "vue-router";

// Import Bootstrap CSS (add this line)
import "bootstrap/dist/css/bootstrap.css";

// Import Bootstrap JavaScript (add this line)
import "bootstrap/dist/js/bootstrap.min.js";

// Import your components
import Home from "./components/Home.vue";
import Create from "./components/Create.vue";
import Show from "./components/Show.vue";
import Edit from "./components/Edit.vue";
import addSpot from "./components/spotCard/addSpot.vue";
import editSpot from "./components/spotCard/editSpot.vue";

const routes = [
  {
    path: "/",
    name: "home",
    component: Home,
  },
  {
    path: "/create",
    name: "create",
    component: Create,
  },
  {
    path: "/show/:id",
    name: "show",
    component: Show,
  },
  {
    path: "/edit/:id",
    name: "edit",
    component: Edit,
  },
  {
    path: "/addSpot/:id",
    name: "addSpot",
    component: addSpot,
  },
  {
    path: "/editSpot/:id/:idS",
    name: "editSpot",
    component: editSpot,
  }
  
  //   { path: '/about', component: About }
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

const app = createApp(App);

// Use the router in your Vue instance
app.use(router);

app.mount("#app");
