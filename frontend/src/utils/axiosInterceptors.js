import Axios from 'axios';

export default Axios.interceptors.response.use(
  (response) => {
    return response;
  },
  (error) => {
    console.log(error)
    if (error.response.status === 401) {
      window.location.href = '/';
    }
  }
)