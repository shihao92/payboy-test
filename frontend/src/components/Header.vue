<template>
  <header class="d-flex justify-content-between align-items-center p-3 bg-light">
    <h2 class="m-0"></h2>
    <div class="user-info dropdown">
      <a
        class="d-flex align-items-center text-decoration-none text-dark dropdown-toggle"
        href="#"
        role="button"
        id="userDropdown"
        data-bs-toggle="dropdown"
        aria-expanded="false"
        @click="showDropDown = !showDropDown"
      >
        <span class="username">Demo <strong>User</strong></span>
        <i class="bi bi-person-circle" style="font-size: 1.5rem;"></i>
      </a>
      <ul class="dropdown-menu dropdown-menu-end" :style="dynamicStyles">
        <li>
          <a class="dropdown-item" href="#">My Account</a>
        </li>
        <li>
          <a class="dropdown-item" href="#" @click="handleLogout">Logout</a>
        </li>
      </ul>
    </div>
  </header>
</template>

<script>
import axios from 'axios';
export default {
  name: 'Header',
  data() {
    return {
      showDropDown: false
    }
  },
  computed: {
    dynamicStyles() {
      return {
        display: this.showDropDown ? 'block' : 'none'
      }
    }
  }, methods: {
    async handleLogout() {
      try {
        const response = await axios.delete('http://localhost:3002/logout', {
          headers: {
            Authorization: localStorage.getItem('authToken')
          }
        });
        await localStorage.removeItem('authToken');
        this.$router.push('/');
      } catch (error) {
        console.error('Error logging in:', error);
      }
    }
  }
};
</script>

<style scoped>
header {
  margin-left: 200px; /* Adjust based on the side menu width */
  width: calc(100% - 200px);
}

.user-info .dropdown-toggle {
  cursor: pointer;
}

.user-info .dropdown-menu {
  left: auto;
  right: 0;
}

.username {
  margin-right: 5px;
}
</style>
