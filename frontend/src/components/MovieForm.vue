<template>
  <form>
    <div class="row">
      <div class="col-sm-8">
        <div class="form-group">
          <label>Title</label>
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
            :options="genres"
            :multiple="true"></multiselect>
        </div>
        <div class="form-group">
          <label>Homepage</label>
          <input 
            type="text" 
            class="form-control"
            v-model="newMovie.homepage" />
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
          <label>Status</label>
          <select class="form-control" v-model="newMovie.status">
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
      </div>
    </div>
  </form>
</template>

<script>
import Multiselect from 'vue-multiselect'
export default {
  name: 'MovieForm',
  props: {
    newMovie: {
      type: Object,
      required: true,
    },
    genres: {
      type: Array,
      default: []
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
    Multiselect
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
      ]
    }
  },
};
</script>

<style>
.invalid-feedback {
  display: block;
}
</style>
