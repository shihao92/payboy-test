<template>
  <div class="d-flex justify-content-center align-items-center vh-100" style="background-color: #a52828;">
    <div class="card p-4" style="width: 320px; background-color: rgba(255, 255, 255, 0.2);">
      <div class="card-body text-center">
        <h2 class="text-white mb-4">Rails Flix</h2>
        <form @submit.prevent="handleSubmit">
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
          <button type="submit" class="btn btn-danger btn-block">Login</button>
        </form>
        <Toast ref="toast" />
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import Toast from '../components/Toast.vue';
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
      const userData = {
        email: this.email,
        password: this.password,
      };
      try {
        const response = await axios.post('http://localhost:3002/login', {
          "user": userData
        });
        console.log('response.data:', response.data);
        await localStorage.setItem('authToken', response.headers.authorization);
        if(this.rememberMe) {
          await localStorage.setItem('payboy-email', this.email);
          await localStorage.setItem('payboy-password', this.password);
        }
        this.$router.push('/dashboard');
      } catch (error) {
        this.$refs.toast.showToast('Error!', `Failed to login into the system, error: ${error}`);
      }
    },
    triggerToast() {
      this.$refs.toast.showToast('Success!', 'Your action was successful.');
    },
  },
  components: {
    Toast,
  },
};
</script>
