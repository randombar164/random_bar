<template>
  <v-btn v-on:click="gacha" id="ingBtn" height="57" width="width">{{ msg }}</v-btn>
</template>
<script>
export default{
  props: [
    "gacha",
    "msg",
    "width"
  ]
}
</script>
<style scoped>
#ingBtn{
  border-radius: 6px;
  background-color: #FF6749;
  font-family: Roboto;
  font-style: normal;
  font-weight: normal;
  font-size: 24px;
  line-height: 28px;
  color: #FCFAF1;
}
</style>
