<template>
  <form>
    <div class="row">
      <div class="col-sm-8">
        <div class="form-group">
          <label>Title *</label>
          <input 
            type="text" 
            class="form-control"
            v-model="newMovie.title" />
          <div v-for="error of v$.newMovie.title.$errors" :key="error.$uid" class="invalid-feedback">
            {{ error.$message }}
          </div>
        </div>
        <div class="form-group">
          <label>Tagline</label>
          <input 
            type="text" 
            class="form-control"
            v-model="newMovie.tagline" />
        </div>
        <div class="form-group">
          <label>Overview</label>
          <input 
            type="text" 
            class="form-control"
            v-model="newMovie.overview" />
        </div>
        <div class="form-group">
          <label>Genres</label>
          <multiselect 
            v-model="newMovie.genre_ids" 
            track-by="name"
            :options="genres"
            :multiple="true"
            :custom-label="formatSelectedGenre">
            <template #option="props">
              <span>{{ props.option.name }}</span>
            </template>
          </multiselect>
        </div>
        <div class="form-group">
          <label>Homepage</label>
          <input 
            type="text" 
            class="form-control"
            v-model="newMovie.homepage" />
        </div>
        <div class="form-group">
          <label>Director</label>
          <input 
            type="text" 
            class="form-control"
            v-model="newMovie.director" />
        </div>
        <div class="row">
          <div class="col-sm-4">
            <div class="form-group">
              <label>Runtime</label>
              <input 
                type="number" 
                class="form-control"
                v-model="newMovie.runtime" />
            </div>
          </div>
          <div class="col-sm-4">
            <div class="form-group">
              <label>Budget</label>
              <input 
                type="text" 
                class="form-control"
                v-model="newMovie.budget" />
            </div>
          </div>
          <div class="col-sm-4">
            <div class="form-group">
              <label>Revenue</label>
              <input 
                type="text" 
                class="form-control"
                v-model="newMovie.revenue" />
            </div>
          </div>
        </div>
      </div>
      <div class="col-sm-4">
        <div class="form-group">
          <label>Upload photo</label>
          <input type="file" @change="onFileChange" accept="image/*" />
        </div>
        <div class="form-group">
          <label>Status *</label>
          <select class="form-control" v-model="newMovie.status">
            <option></option>
            <option v-for="status in statusOptions" :key="status.value" :value="status.value">
              {{ status.name }}
            </option>
          </select>
          <div v-for="error of v$.newMovie.title.$errors" :key="error.$uid" class="invalid-feedback">
            {{ error.$message }}
          </div>
        </div>
        <div class="form-group">
          <label>Release date</label>
          <input 
            type="date" 
            class="form-control"
            v-model="newMovie.release_date" />
        </div>
        <div class="form-group">
          <label>Score</label>
          <input 
            type="text" 
            class="form-control"
            v-model="newMovie.score" />
        </div>
      </div>
    </div>
  </form>
  <Toast ref="toast" />
</template>

<script>
import Multiselect from 'vue-multiselect'
import Toast from '../components/Toast.vue';
import { loadGenres } from '../services';
export default {
  name: 'MovieForm',
  props: {
    newMovie: {
      type: Object,
      required: true,
    },
    errors: {
      type: Array,
      default: []
    },
    v$: {
      type: Object,
    }
  },
  components: {
    Multiselect,
    Toast,
  },
  data() {
    return {
      statusOptions: [
        { name: 'Rumored', value: 'rumored' },
        { name: 'Planned', value: 'planned' },
        { name: 'In production', value: 'in_production' },
        { name: 'Post production', value: 'post_production' },
        { name: 'Released', value: 'released' },
        { name: 'Canceled', value: 'cancelled' },
      ],
      genres: []
    }
  },
  async mounted() {
    this.genres = await loadGenres(this.$refs.toast);
  },
  methods: {
    formatSelectedGenre({name}) {
      return name
    },
    onFileChange(event) {
      const file = event.target.files[0];
      const maxSize = 2 * 1024 * 1024; // 2MB in bytes

      if (file && file.size > maxSize) {
        this.$refs.toast.showToast('Error!', 'File size exceeds 2MB. Please choose a smaller file.');
        return;
      } 

      if (file) {
        const reader = new FileReader();
        reader.onloadend = () => {
          this.newMovie.photo_data = reader.result;
        };
        reader.readAsDataURL(file);
      }
    },
  }
};
</script>

<style>
.invalid-feedback {
  display: block;
}
</style>
