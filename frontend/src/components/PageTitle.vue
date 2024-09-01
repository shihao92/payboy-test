<template>
  <div class="page-title p-3">
    <div>
      <h4 class="mb-1">{{ title }}</h4>
      <ol class="breadcrumb">
        <li class="breadcrumb-item" v-for="path in paths" :key="path.name">
          <router-link :to="{ path: path.route }">{{ path.name }}</router-link>
        </li>
      </ol>
    </div>
    <button 
      class="btn btn-primary ml-auto btn-add" 
      v-if="showAddButton" 
      @click="onClickAdd">+</button>
    <button 
      class="btn btn-success ml-auto btn-save-movie" 
      v-if="showNewMovieButton" 
      @click="onClickSaveNewMovie">Save Movie</button>
    <button 
      class="btn btn-success ml-auto btn-save-movie" 
      v-if="showSaveProfileButton" 
      @click="onClickSaveProfile">Save Profile</button>
  </div>
</template>

<script>
export default {
  name: 'PageTitle',
  props: {
    title: {
      type: String,
      required: true,
    },
    showAddButton: {
      type: Boolean,
      default: false,
    },
    showNewMovieButton: {
      type: Boolean,
      default: false,
    },
    showSaveProfileButton: {
      type: Boolean,
      default: false,
    },
    paths: {
      type: Array,
      default: [],
    },
    onClickAdd: {
      type: Function,
      default: () => {},
    },
    onClickSaveNewMovie: {
      type: Function,
      default: () => {},
    },
    onClickSaveProfile: {
      type: Function,
      default: () => {},
    },
  },
};
</script>

<style scoped>
.page-title {
  background: #ececec;
  margin-left: 0; /* Adjust based on the side menu width */
  display: flex;
  flex-direction: row;
}
.breadcrumb {
  padding-left: 0;
  margin-bottom: 0;
}
.btn-save-movie {
  height: 40px;
}
</style>