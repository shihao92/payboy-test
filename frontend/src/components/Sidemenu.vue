<template>
  <div class="side-menu bg-dark text-white">
    <div class="brand p-3">
      <h3>Rails Flix</h3>
    </div>
    <ul class="nav flex-column">
      <li class="nav-item">
        <router-link class="nav-link text-white" to="/dashboard">Movies</router-link>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'SideMenu',
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
</style>