import axios from "axios";

export const api = axios.create({
  baseURL: "http://136.248.122.142:5177",
  timeout: 10000,
});

export default api;
