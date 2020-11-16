<template>
  <a :href="amazonUrl" @click="trackClick" target="_blank">
    <v-btn  class="amazonBtn">
      Amazonで購入
    </v-btn>
  </a>
</template>
<script>
export default{
  props:[
    "amazonUrl",
    "ingName"
  ],
  methods: {
    trackClick() {
      this.$ga.event('click', 'amazon-link', this.ingName, 1)
    }
  }
}
</script>
<style scoped>
.amazonBtn{
  border-radius: 6px;
  font-style: normal;
  font-weight: normal;
  font-size: 12px;
  line-height: 14px;
  width: 116px;
  height: 34px;
  border: 2px solid #FF6749;
  color: #FF6749;
}
a {
  text-decoration: none;
}
</style>
