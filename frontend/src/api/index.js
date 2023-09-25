//import axios
import axios from 'axios';

const Api = axios.create({
    //set default endpoint API
    // baseURL: 'http://localhost:8000'
    baseURL: 'http://192.168.186.124:8000'
})

export default Api