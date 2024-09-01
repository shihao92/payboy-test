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
          :v$="v$"
          :errorPassword="errorPassword"
          :errorConfirmPassword="errorConfirmPassword" />
      </div>
    </div>
  </div>
  <Toast ref="toast" />
  <LoadingOverlay :isLoading="isLoading" />
</template>

<script>
import axios from 'axios';
import useVuelidate from '@vuelidate/core';
import { required, minLength, email } from '@vuelidate/validators';
import SideMenu from '../components/SideMenu.vue';
import Header from '../components/Header.vue';
import PageTitle from '../components/PageTitle.vue';
import Toast from '../components/Toast.vue';
import LoadingOverlay from '../components/LoadingOverlay.vue';
import UserForm from '../components/UserForm.vue';
import { api_url } from '../../constants.json';

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
        id: 0,
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
      isLoading: false,
      errorPassword: '',
      errorConfirmPassword: '',
    }
  },
  mounted() {
    let tmpUser = JSON.parse(localStorage.getItem('currentLoginUser'));
    this.user = {
      id: tmpUser.id,
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
      if(this.user.password) {
        if(this.user.password.length < 6) {
          this.errorPassword = 'Password must be at least 6 characters long';
          return;
        }
        if(this.user.password !== this.user.confirm_password) {
          this.errorConfirmPassword = 'Password and confirm password must match';
          return;
        }
      }
      const result = await this.v$.$validate()
      if (!result) {
        this.$refs.toast.showToast('Error!', `Please fill in proper value into email and name fields.`);
        return
      }

      this.isLoading = true;
      try {
        const response = await axios.patch(`${api_url}/users/${this.user.id}`, {
          "user": {
            "email": this.user.email,
            "name": this.user.name,
          }
        }, {
          headers: {
            Authorization: localStorage.getItem('authToken')
          }
        });
        this.$refs.toast.showToast('Success!', `User profile update success.`);
        let currentLoginUser = JSON.stringify(response.data.user);
        localStorage.setItem('currentLoginUser', currentLoginUser);
      } catch (error) {
        this.$refs.toast.showToast('Error!', `Error updating user profile: ${error}`);
      } finally {
        this.isLoading = false;
      }
    }
  }
}
</script>