import { createApp } from 'vue'
import App from './App.vue'
import router from './router';

import 'bootstrap-icons/font/bootstrap-icons.css';
import "vue-multiselect/dist/vue-multiselect.css";
import './style.css';

createApp(App)
  .use(router)  
  .mount('#app');
