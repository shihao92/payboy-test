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
          :v$="v$" />
      </div>
    </div>
  </div>
  <Toast ref="toast" />
  <LoadingOverlay :isLoading="isLoading" />
</template>

<script>
import useVuelidate from '@vuelidate/core';
import { required, minLength } from '@vuelidate/validators';
import _ from 'lodash';
import SideMenu from '../components/SideMenu.vue';
import Header from '../components/Header.vue';
import PageTitle from '../components/PageTitle.vue';
import Toast from '../components/Toast.vue';
import MovieForm from '../components/MovieForm.vue';
import LoadingOverlay from '../components/LoadingOverlay.vue';
import { addMovie } from '../services';

export default {
  name: 'AddMovie',
  components: {
    SideMenu,
    Header,
    PageTitle,
    Toast,
    MovieForm,
    Toast,
    LoadingOverlay
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
        "photo_data": "",
        "director": "",
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
      isLoading: false
    };
  },
  methods: {
    async onClickSaveNewMovie() {
      let tmpNewMovie = _.cloneDeep(this.newMovie);
      tmpNewMovie.genre_ids = [];
      const result = await this.v$.$validate()
      if (!result) {
        this.$refs.toast.showToast('Error!', `Please fill in all the required fields.`);
        return
      }
      this.newMovie.genre_ids.map(item => {
        tmpNewMovie.genre_ids.push(item.id);
      })
      this.isLoading = true;
      await addMovie(this.$refs.toast, this.$router, tmpNewMovie);
      this.isLoading = false;
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
