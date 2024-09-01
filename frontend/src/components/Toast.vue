<template>
  <div class="toast-container" ref="toastContainer">
    <div 
      class="toast" 
      role="alert" 
      aria-live="assertive" 
      aria-atomic="true"
      :class="{'show': visible}"
      ref="toast">
      <div class="toast-header">
        <strong class="me-auto">{{ title }}</strong>
        <button 
          type="button" 
          class="btn-close" 
          data-bs-dismiss="toast" 
          aria-label="Close"
          @click="hideToast"></button>
      </div>
      <div class="toast-body">
        {{ message }}
      </div>
    </div>
  </div>
</template>

<script>
import { createPopper } from '@popperjs/core';

export default {
  data() {
    return {
      visible: false,
      title: 'Toast Title',
      message: 'This is the toast message.',
      popperInstance: null,
    };
  },
  mounted() {
    this.popperInstance = createPopper(this.$refs.toast, this.$refs.toastContainer, {
      placement: 'bottom-end',
    });
  },
  methods: {
    showToast(title = 'Toast Title', message = 'This is the toast message.') {
      this.title = title;
      this.message = message;
      this.visible = true;

      this.popperInstance.update();

      // Hide after 3 seconds (or any duration you prefer)
      setTimeout(() => {
        this.hideToast();
      }, 3000);
    },
    hideToast() {
      this.visible = false;
    },
  },
};
</script>

<style scoped>
.toast-container {
  z-index: 1055;
  top: 1rem;
  right: 1rem;
  transform: none !important;
  margin: 15px !important;
}
.toast {
  opacity: 0;
  transition: opacity 0.3s ease;
}
.toast.show {
  opacity: 1;
}
</style>
