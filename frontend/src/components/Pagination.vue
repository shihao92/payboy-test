<template>
  <div class="pagination d-flex align-items-center w-100">
    <nav aria-label="Page navigation example">
      <ul class="pagination">
        <li 
          class="page-item"
          :class="{ disabled: meta.current_page === 1 }">
          <a 
            class="page-link" 
            href="#" 
            @click.prevent="onChangePage(meta.current_page - 1)">
            Previous
          </a>
        </li>
        <li 
          class="page-item"
          v-for="page in meta.total_pages"
          :key="page"
          :class="{ active: meta.current_page === page }">
          <a 
            class="page-link" 
            href="#" 
            @click.prevent="onChangePage(page)">
            {{ page }}
          </a>
        </li>
        <li 
          class="page-item"
          :class="{ disabled: meta.current_page === meta.total_pages }">
          <a 
            class="page-link" 
            href="#" 
            @click.prevent="onChangePage(meta.current_page + 1)">
            Next
          </a>
        </li>
      </ul>
    </nav>
  </div>
</template>

<script>
export default {
  name: 'Pagination',
  props: {
    meta: {
      type: Object,
      required: true,
    },
    onChangePage: {
      type: Function,
      default: () => {},
    }
  },
  methods: {
    
  }
}
</script>