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
                <td>
                  <button 
                    class="btn btn-danger btn-sm" 
                    @click="onClickShowConfirmDelete(movie.id)">
                    <i class="bi bi-trash"></i>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
          <Pagination :meta="data.meta" :onChangePage="onChangePage" />
        </div>
      </div>
    </div>
  </div>
  <Toast ref="toast" />
  <LoadingOverlay :isLoading="isLoading" />
  <ConfirmDeleteModal 
    :show="showConfirmDelete"
    :title="titleConfirmDelete"
    :message="messageConfirmDelete"
    @confirm="confirmDelete"
    @cancel="cancelDelete" />
</template>

<script>
import _ from 'lodash'
import { format } from 'date-fns';
import SideMenu from '../components/SideMenu.vue';
import Header from '../components/Header.vue';
import PageTitle from '../components/PageTitle.vue';
import Toast from '../components/Toast.vue';
import Pagination from '../components/Pagination.vue';
import LoadingOverlay from '../components/LoadingOverlay.vue';
import ConfirmDeleteModal from '../components/ConfirmDelete.vue'; 
import { loadMovies, deleteMovie } from '../services'
export default {
  name: 'Dashboard',
  components: {
    SideMenu,
    Header,
    PageTitle,
    Toast,
    Pagination,
    LoadingOverlay,
    ConfirmDeleteModal
  },
  async mounted() {
    this.isLoading = true;
    this.data = await loadMovies(this.data, this.$refs.toast);
    this.isLoading = false;
  },
  data() {
    return {
      data: {
        movies: [],
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
      ],
      isLoading: false,
      showConfirmDelete: false,
      titleConfirmDelete: 'Notification',
      messageConfirmDelete: 'Are you sure to remove selected movie?',
      selectedMovieId: 0
    };
  },
  methods: {
    formatDate(dateString) {
      return format(new Date(dateString), 'yyyy-MM-dd');
    },
    onClickAdd() {
      this.$router.push('/add-movie');
    },
    async onChangePage(page) {
      this.data.meta.current_page = page;
      this.isLoading = true;
      this.data = await loadMovies(this.data, this.$refs.toast);
      this.isLoading = false;
    },
    onClickShowConfirmDelete(movieId) {
      this.showConfirmDelete = true;
      this.selectedMovieId = movieId;
    },
    async confirmDelete() {
      this.showConfirmDelete = false;
      this.isLoading = true;
      this.data.movies = await deleteMovie(this.data.movies, this.selectedMovieId, this.$refs.toast);
      this.isLoading = false;
    },
    cancelDelete() {
      this.showConfirmDelete = false;
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
