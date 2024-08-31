<template>
  <div>
    <SideMenu />
    <Header />
    <div class="content-wrapper">
      <PageTitle 
        title="New Movie" 
        :showAddButton="false" 
        :showNewMovieButton="true"
        :paths="breadcrumbs"
        :onClickSaveNewMovie="onClickSaveNewMovie" />
      <div class="content p-3">
        <MovieForm 
          :newMovie="newMovie"
          :genres="genres"
          :v$="v$" />
      </div>
    </div>
  </div>
  <Toast ref="toast" />
</template>

<script>
import axios from 'axios';
import useVuelidate from '@vuelidate/core';
import { required, minLength } from '@vuelidate/validators';
import SideMenu from '../components/SideMenu.vue';
import Header from '../components/Header.vue';
import PageTitle from '../components/PageTitle.vue';
import Toast from '../components/Toast.vue';
import MovieForm from '../components/MovieForm.vue';
export default {
  name: 'AddMovie',
  components: {
    SideMenu,
    Header,
    PageTitle,
    Toast,
    MovieForm
  },
  async mounted() {
    try {
      let tmpGenres = [];
      const response = await axios.get(`http://localhost:3002/genres`, {
        headers: {
          Authorization: localStorage.getItem('authToken')
        }
      })
      response.data.map(item => {
        tmpGenres.push(item.name);
      })
      this.genres = tmpGenres;
    } catch (error) {
      console.error('Error loading genres:', error);
    }
  },
  data() {
    return {
      newMovie: {
        "title": "",
        "tagline": "",
        "overview": "",
        "homepage": "",
        "runtime": 0,
        "budget": "",
        "revenue": "",
        "status": "",
        "release_date": "",
        "score": "",
        "genre_ids": [],
        "photo_data": ""
      },
      breadcrumbs: [
        {
          route: '/dashboard',
          name: 'Home',
          currentPage: false
        },
        {
          route: '/add-movie',
          name: 'Add movie',
          currentPage: true
        }
      ],
      genres: []
    };
  },
  methods: {
    async onClickSaveNewMovie() {
      console.log('newMovie:', this.newMovie);
      const result = await this.v$.$validate()
      if (!result) {
        // notify user form is invalid
        console.log(this.v$.$errors)
        console.log(this.v$.newMovie.title.$errors)
        return
      }
    }
  },
  setup() {
    return { v$: useVuelidate() }
  },
  validations () {
    return {
      newMovie: {
        title: { required, minLength: minLength(1)},
        status: { required, minLength: minLength(1)},
      }
    }
  }
};
</script>
