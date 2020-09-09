<template>
  <v-btn outlined color="#FF6749" height="45px" v-on:click="gacha" id="slotBtn">ガチャへ></v-btn>
</template>
<script>
export default{
  props: [
    "gacha"
  ],
}
</script>
<style scoped>
#slotBtn{
  background-color: #FCFAF1;
  border-radius: 6px;
  font-family: Roboto;
  font-style: normal;
  font-weight: normal;
  font-size: 18px;
  line-height: 21px;
}
</style>
