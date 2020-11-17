<template>
  <div>
    <v-app-bar app color="#FF6749" dark shouldExtend>
      <v-toolbar-title>
        <v-btn depressed dark color ="#FF6749" small router class="px-1" @click="toTop">
          <span class="display-1 text-capitalize" style="line-height: 1.5rem;">お家Bar</span>
        </v-btn>
      </v-toolbar-title>
    </v-app-bar>
  </div>
</template>

<script>
export default {
  methods:{
    toTop(){
      this.$router.push({ path:`/`});
      window.scrollTo(0,0);
    }
  }
}
</script>

<style scoped>

</style>
