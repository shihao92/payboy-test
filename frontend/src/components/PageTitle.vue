<template>
  <div class="page-title p-3">
    <div>
      <h4 class="mb-1">{{ title }}</h4>
      <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
          <li class="breadcrumb-item" v-for="path in paths" :key="path.name">
            <router-link :to="{ path: path.route }">{{ path.name }}</router-link>
          </li>
        </ol>
      </nav>
    </div>
    <button class="btn btn-primary ml-auto btn-add" v-if="showAddButton" @click="onClickAdd">+</button>
  </div>
</template>

<script>
export default {
  name: 'PageTitle',
  props: {
    title: {
      type: String,
      required: true,
    },
    showAddButton: {
      type: Boolean,
      default: false,
    },
    paths: {
      type: Array,
      default: [],
    },
    onClickAdd: {
      type: Function,
      default: () => {},
    },
  },
};
</script>

<style scoped>
.page-title {
  background: #fafafa;
  margin-left: 0; /* Adjust based on the side menu width */
  display: flex;
  flex-direction: row;
}
</style>