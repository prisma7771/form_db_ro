// offlineApi.js
import axios from 'axios';

const offlineApi = axios.create({
    baseURL: 'http://localhost:8000'
});

const api = axios.create({
    baseURL: 'http://192.168.186.124:8000'
});

export { offlineApi, api };
