// offlineApi.js
import axios from 'axios';

const offlineApi = axios.create({
    baseURL: 'http://localhost:8000'
});

// This changed as you change wifi
const api = axios.create({
    baseURL: 'http://192.168.59.124:8000'
});

export { offlineApi, api };
