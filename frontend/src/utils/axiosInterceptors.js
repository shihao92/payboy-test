import Axios from 'axios';

export default Axios.interceptors.response.use(
  (response) => {
    return response;
  },
  (error) => {
    if (error.response.status === 401 && error.request.responseURL.indexOf('login') === -1) {
      window.location.href = '/';
    }
    return error;
  }
)