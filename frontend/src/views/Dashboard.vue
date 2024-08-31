<template>
  <div>
    <SideMenu />
    <Header />
    <div class="content-wrapper">
      <PageTitle 
        title="Listing Movies" 
        :showAddButton="true" 
        :paths="breadcrumbs"
        :onClickAdd="onClickAdd" />
      <div class="content p-0">
        <div class="table-responsive">
          <table class="table table-striped">
            <thead>
              <tr>
                <th>Title</th>
                <th>Directors</th>
                <th>Genres</th>
                <th>Status</th>
                <th>Release date</th>
                <th>Score</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="movie in data.movies" :key="movie.id">
                <td>{{ movie.title }}</td>
                <td>{{ movie.directors }}</td>
                <td>
                  <span v-for="genre in movie.genres" :key="genre" class="badge bg-danger me-1">
                    {{ genre.name }}
                  </span>
                </td>
                <td>
                  <span :class="['badge', movie.status === 'Released' ? 'bg-success' : 'bg-warning']">
                    {{ movie.status }}
                  </span>
                </td>
                <td>{{ formatDate(movie.release_date) }}</td>
                <td>{{ movie.score }}</td>
                <td><button class="btn btn-danger btn-sm">Delete</button></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
  <Toast ref="toast" />
</template>

<script>
import axios from 'axios';
import { format } from 'date-fns';
import SideMenu from '../components/SideMenu.vue';
import Header from '../components/Header.vue';
import PageTitle from '../components/PageTitle.vue';
import Toast from '../components/Toast.vue';
import { api_url } from '../../constants.json';

export default {
  name: 'Dashboard',
  components: {
    SideMenu,
    Header,
    PageTitle,
    Toast
  },
  async mounted() {
    try {
      const response = await axios.get(`${api_url}/movies?page=${this.data.meta.current_page}&per_page=10`, {
        headers: {
          Authorization: localStorage.getItem('authToken')
        }
      })
      this.data = response.data;
    } catch (error) {
      console.error('Error loading movies:', error);
    }
  },
  data() {
    return {
      data: {
        movies: [
          // Populate this with movie data
          // {
          //   id: 1,
          //   title: 'Deadpool & Wolverine',
          //   directors: 'Shawn Levy',
          //   genres: ['Action', 'Comedy', 'Science Fiction'],
          //   status: 'Released',
          //   releaseDate: '07/24/2024',
          //   score: '77%',
          // },
        ],
        meta: {
          current_page: 1,
          next_page: null,
          prev_page: null,
          total_pages: 1,
          total_count: 1
        }
      },
      breadcrumbs: [
        {
          route: '/dashboard',
          name: 'Movies',
          currentPage: true
        }
      ]
    };
  },
  methods: {
    formatDate(dateString) {
      return format(new Date(dateString), 'yyyy-MM-dd');
    },
    onClickAdd() {
      this.$router.push('/add-movie');
    }
  }
};
</script>

<style scoped>
.table-responsive {
  background: white;
  padding: 15px;
  border-radius: 5px;
}
</style>
