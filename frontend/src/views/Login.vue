<template>
  <div class="d-flex justify-content-center align-items-center" style="background-color:#a52828;height:100vh;">
    <div class="card p-4" style="width: 320px; background-color: rgba(255, 255, 255, 0.2);">
      <div class="card-body text-center">
        <h2 class="text-white mb-4">Rails Flix</h2>
        <div>
          <div class="mb-3">
            <div class="input-group">
              <span class="input-group-text bg-transparent text-white">
                <i class="bi bi-person"></i>
              </span>
              <input v-model="email" type="email" class="form-control bg-transparent text-white" placeholder="demo@example.com">
            </div>
          </div>
          <div class="mb-3">
            <div class="input-group">
              <span class="input-group-text bg-transparent text-white">
                <i class="bi bi-lock"></i>
              </span>
              <input v-model="password" type="password" class="form-control bg-transparent text-white" placeholder="••••••••">
            </div>
          </div>
          <div class="form-check mb-3 text-start">
            <input class="form-check-input" type="checkbox" id="rememberMe" v-model="rememberMe" />
            <label class="form-check-label text-white" for="rememberMe">
              Remember me
            </label>
          </div>
          <button class="btn btn-danger btn-block" @click="handleSubmit">Login</button>
        </div>
      </div>
    </div>
  </div>
  <Toast ref="toast" />
</template>

<script>
import axios from 'axios';
import useVuelidate from '@vuelidate/core';
import { required, minLength, email } from '@vuelidate/validators';
import Toast from '../components/Toast.vue';
import { api_url } from '../../constants.json';

export default {
  name: 'Login',
  data() {
    return {
      email: '',
      password: '',
      rememberMe: false,
    };
  },
  mounted() {
    this.email = localStorage.getItem('payboy-email') || '';
    this.password = localStorage.getItem('payboy-password') || '';
    this.rememberMe = (this.email && this.password) ? 'true' : 'false';
  },
  methods: {
    async handleSubmit() {
      const result = await this.v$.$validate();
      if (!result) {
        this.$refs.toast.showToast('Error!', 'Please fill in the login form correctly.');
        return;
      }
      const userData = {
        email: this.email,
        password: this.password,
      };
      try {
        const response = await axios.post(`${api_url}/login`, {
          "user": userData
        });
        if(response?.response?.data) {
          this.$refs.toast.showToast('Error!', `Failed to login into the system, error: ${response.response.data}`);
          return;
        }
        localStorage.setItem('authToken', response.headers.authorization);
        if(this.rememberMe) {
          localStorage.setItem('payboy-email', this.email);
          localStorage.setItem('payboy-password', this.password);
        } else {
          localStorage.removeItem('payboy-email');
          localStorage.removeItem('payboy-password');
        }
        this.$router.push('/dashboard');
      } catch (error) {
        this.$refs.toast.showToast('Error!', `Failed to login into the system, error: ${error}`);
      }
    },
  },
  components: {
    Toast,
  },
  setup() {
    return { v$: useVuelidate() }
  },
  validations () {
    return {
      email: { required, minLength: minLength(1), email },
      password: { required, minLength: minLength(1) }
    }
  }
};
</script>
