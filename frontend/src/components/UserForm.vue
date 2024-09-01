<template>
  <form>
    <div class="row">
      <div class="col-sm-6">
        <div class="form-group">
          <label>Email *</label>
          <input 
            type="text" 
            class="form-control"
            v-model="user.email" />
          <div v-for="error of v$.user.email.$errors" :key="error.$uid" class="invalid-feedback">
            {{ error.$message }}
          </div>
        </div>
      </div>
      <div class="col-sm-6">
        <div class="form-group">
          <label>Name *</label>
          <input 
            type="text" 
            class="form-control"
            v-model="user.name" />
          <div v-for="error of v$.user.name.$errors" :key="error.$uid" class="invalid-feedback">
            {{ error.$message }}
          </div>
        </div>
      </div>
      <div class="col-sm-6">
        <div class="form-group">
          <label>Password *</label>
          <input 
            type="password" 
            class="form-control"
            v-model="user.password" />
          <div v-if="errorPassword" class="invalid-feedback">
            {{ errorPassword }}
          </div>  
        </div>
      </div>
      <div class="col-sm-6">
        <div class="form-group">
          <label>Confirm password *</label>
          <input 
            type="password" 
            class="form-control"
            v-model="user.confirm_password" />
          <div v-if="errorConfirmPassword" class="invalid-feedback">
            {{ errorConfirmPassword }}
          </div>
        </div>
      </div>
    </div>
  </form>
</template>

<script>
export default {
  name: 'UserForm',
  props: {
    user: {
      type: Object,
      required: true,
    },
    v$: {
      type: Object,
    },
    errorPassword: {
      type: String,
      default: ''
    },
    errorConfirmPassword: {
      type: String,
      default: ''
    }
  },
  methods: {
    
  }
};
</script>