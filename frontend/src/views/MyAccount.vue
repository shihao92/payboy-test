<template>
  <div>
    <SideMenu />
    <Header />
    <div class="content-wrapper">
      <PageTitle 
        title="My Account Information" 
        :paths="breadcrumbs"
        :showSaveProfileButton="true"
        :onClickSaveProfile="onClickSaveProfile" />
      <div class="content p-3">
        <UserForm
          :user="user"
          :v$="v$" />
      </div>
    </div>
  </div>
  <Toast ref="toast" />
  <LoadingOverlay :isLoading="isLoading" />
</template>

<script>
import useVuelidate from '@vuelidate/core';
import { required, minLength, email } from '@vuelidate/validators';
import SideMenu from '../components/SideMenu.vue';
import Header from '../components/Header.vue';
import PageTitle from '../components/PageTitle.vue';
import Toast from '../components/Toast.vue';
import LoadingOverlay from '../components/LoadingOverlay.vue';
import UserForm from '../components/UserForm.vue';

export default {
  name: 'MyAccount',
  components: {
    SideMenu,
    Header,
    PageTitle,
    Toast,
    LoadingOverlay,
    UserForm
  },
  data() {
    return {
      user: {
        email: '',
        name: '',
        password: '',
        confirm_password: '',
      },
      breadcrumbs: [
        {
          route: '/my-account',
          name: 'My Account',
          currentPage: true
        }
      ],
      isLoading: false
    }
  },
  mounted() {
    let tmpUser = JSON.parse(localStorage.getItem('currentLoginUser'));
    this.user = {
      email: tmpUser.email,
      name: tmpUser.name,
    }
  },
  setup() {
    return { v$: useVuelidate() }
  },
  validations () {
    return {
      user: {
        email: {
          required: required,
          email: email
        },
        name: {
          required: required,
          minLength: minLength(3)
        },
      }
    }
  },
  methods: {
    async onClickSaveProfile() {
      
    }
  }
}
</script>