<template>
  <div>
    <SideMenu />
    <Header />
    <div class="content-wrapper">
      <PageTitle 
        title="New Movie" 
        :showAddButton="false" 
        :paths="breadcrumbs" />
      <div class="content p-0">
        
      </div>
    </div>
  </div>
  <Toast ref="toast" />
</template>

<script>
import axios from 'axios';
import SideMenu from '../components/SideMenu.vue';
import Header from '../components/Header.vue';
import PageTitle from '../components/PageTitle.vue';
import Toast from '../components/Toast.vue';

export default {
  name: 'AddMovie',
  components: {
    SideMenu,
    Header,
    PageTitle,
    Toast
  },
  async mounted() {
    try {
      const response = await axios.get(`http://localhost:3002/genres`, {
        headers: {
          Authorization: localStorage.getItem('authToken')
        }
      })
      this.data = response.data;
    } catch (error) {
      console.error('Error loading genres:', error);
    }
  },
  data() {
    return {
      newMovie: {

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
      ]
    };
  },
  methods: {
    
  }
};
</script>
