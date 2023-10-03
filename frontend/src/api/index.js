// offlineApi.js
import axios from 'axios';

const offlineApi = axios.create({
    baseURL: 'http://localhost:8000'
});

// This changed as you change wifi
const api = axios.create({
    // baseURL: 'http://192.168.9.124:8000'
    baseURL: 'http://localhost:8000'
});

export { offlineApi, api };
