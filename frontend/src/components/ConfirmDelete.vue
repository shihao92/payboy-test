<template>
  <div 
    v-if="show" 
    class="modal fade showModal"
    :class="{ show: show }" 
    id="confirmDeleteModal" 
    tabindex="-1" 
    aria-labelledby="confirmDeleteModalLabel">
    <div class="modal-dialog">
      <div class="modal-content p-0" style="max-width:none;">
        <div class="modal-header">
          <h1 class="modal-title fs-5" id="confirmDeleteModalLabel">{{ title }}</h1>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" @click="cancelDelete"></button>
        </div>
        <div class="modal-body pt-5 pb-5">
          {{ message }}
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" @click="cancelDelete">Close</button>
          <button type="button" class="btn btn-primary" @click="confirmDelete">Save changes</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    show: {
      type: Boolean,
      required: true,
    },
    title: {
      type: String,
      default: 'Confirm Deletion',
    },
    message: {
      type: String,
      default: 'Are you sure you want to delete this item?',
    },
  },
  methods: {
    confirmDelete() {
      this.$emit('confirm');
    },
    cancelDelete() {
      this.$emit('cancel');
    },
  },
};
</script>

<style scoped>
.modal-content {
  background-color: #fff;
  padding: 20px;
  border-radius: 8px;
  max-width: 400px;
  width: 100%;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  text-align: center;
}

.showModal {
  display: block;
}
</style>
