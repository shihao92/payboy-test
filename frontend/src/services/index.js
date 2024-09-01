import axios from "axios";
import { api_url } from "../../constants.json";

export const loadMovies = async(data, toast) => {
  try {
    const response = await axios.get(`${api_url}/movies?page=${data.meta.current_page}&per_page=10`, {
      headers: {
        Authorization: localStorage.getItem('authToken')
      }
    })
    return response.data
  } catch (error) {
    toast.showToast('Error!', `Failed to load movies, error: ${error}`);
  }
}

export const addMovie = async(toast, router, tmpNewMovie) => {
  try {
    await axios.post(`${api_url}/movies`, {
      "movie": tmpNewMovie
    }, {
      headers: {
        Authorization: localStorage.getItem('authToken')
      }
    })
    toast.showToast('Success!', 'Movie added successfully.');
    router.push('/dashboard');
  } catch (error) {
    toast.showToast('Error!', `Failed to add movie, error: ${error}`);
  }
}

export const deleteMovie = async(movies, selectedMovieId, toast) => {
  try {
    await axios.delete(`${api_url}/movies/${selectedMovieId}`, {
      headers: {
        Authorization: localStorage.getItem('authToken')
      }
    });
    movies = movies.filter(movie => movie.id !== selectedMovieId);
    toast.showToast('Success!', 'Movie has been deleted successfully.');
    return movies;
  } catch (error) {
    toast.showToast('Error!', `Failed to delete movie, error: ${error}`);
  }
}