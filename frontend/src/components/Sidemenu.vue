<template>
  <div class="side-menu bg-dark text-white">
    <div class="brand p-3">
      <h3>Rails Flix</h3>
    </div>
    <ul class="nav flex-column">
      <li class="nav-item">
        <router-link 
          class="nav-link text-white" 
          :class="{ 'active-menu': currentActiveURL === '/dashboard' }"
          to="/dashboard">Movies</router-link>
      </li>
      <li class="nav-item">
        <router-link 
          class="nav-link text-white" 
          :class="{ 'active-menu': currentActiveURL === '/my-account' }"
          to="/my-account">My Account</router-link>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'SideMenu',
  data() {
    return {
      currentActiveURL: this.$route.path
    }
  },
  computed: {
    currentRouteName() {
      return this.$route.path;
    },
  },
  watch: {
    $route(to, from) {
      this.currentActiveURL = to.path;
    },
  },
};
</script>

<style scoped>
.side-menu {
  width: 200px;
  height: 100vh;
  position: fixed;
  top: 0;
  left: 0;
  background-color: #343a40;
}

.nav-link {
  padding: 10px 15px;
}

.nav-link:hover {
  background-color: #495057;
}

.active-menu {
  background-color: #495057;
}
</style>