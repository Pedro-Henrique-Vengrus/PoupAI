import axios from "axios";

export const api = axios.create({
  baseURL: "https://philosophical-max-poupaai-f5b2f021.koyeb.app",
  timeout: 10000,
});

export default api;
