<template>
  <v-btn outlined color="#FF6749" @click="toAmazon" class="amazonBtn" width="116px" height="34px">Amazonで購入</v-btn>
</template>
<script>
export default{
  props:[
    "toAmazon"
  ]
}
</script>
<style scoped>
.amazonBtn{
  border-radius: 6px;
  font-family: Roboto;
  font-style: normal;
  font-weight: normal;
  font-size: 12px;
  line-height: 14px;
}
</style>
