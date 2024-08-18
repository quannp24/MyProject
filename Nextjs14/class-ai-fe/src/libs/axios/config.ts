import { accessTokenCookie, authUrl } from "@/constants/authen/cookies";
import { logout } from "@/services/Authen";
import axios from "axios";
import { setCookie, getCookie } from 'cookies-next';



const axiosAPI = axios.create({
  baseURL: process.env.NEXT_PUBLIC_API_URL,
  headers: {
    "Content-Type": "application/json"
  },
});


//Xử lý requests của axios
axiosAPI.interceptors.request.use(
  (config) => {
    const accessToken = getCookie(accessTokenCookie);
    if (accessToken) {
      config.headers["authorization"] = 'Bearer '+accessToken;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

//Xử lý responses của axios
axiosAPI.interceptors.response.use(
  (res) => {
    return res;
  },
  async (err) => {
    
    const originalConfig = err.config;
    if (!originalConfig?.url?.includes(authUrl) && err.response) {
      // Access Token was expired
      if (err.response.status === 401 && !originalConfig._retry) {
        originalConfig._retry = true;
        logout();
        return Promise.reject(err.response);
      }
    }
    return Promise.reject(err.response);
  }
);

export default axiosAPI;
