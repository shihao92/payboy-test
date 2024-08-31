import { createRouter, createWebHistory } from 'vue-router';
import Login from '../views/Login.vue'; 
import Dashboard from '../views/Dashboard.vue';
import AddMovie from '../views/AddMovie.vue';

const routes = [
  {
    path: '/',
    name: 'Login',
    component: Login,
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: Dashboard,
  },
  {
    path: '/add-movie',
    name: 'AddMovie',
    component: AddMovie,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;