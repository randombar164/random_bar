<template>
  <v-card flat height="120px" class="ingCard">
    <div class="float-left mt-3 ml-3">
      <v-img :src="imageUrl" height="90px"contain  width="90px"></v-img>
    </div>
    <div class="ingCard-info d-flex justify-space-between">
      <p class="ingName">{{ name }}</p>
      <v-icon class="icon mr-3" @click="deleteCard(id)" large>mdi-close</v-icon>
    </div>
  </v-card>
</template>
<script>
export default{
  props:[
    "imageUrl",
    "name",
    "id",
    "deleteCard"
  ]
}
</script>
<style scoped>
.ingCard{
  border: 1px solid #C4C4C4;
  box-sizing: border-box;
  position: relative;
}
.ingName{
  position: absolute;
  font-size: 1em;
  float: left;
  font-family: "Roboto";
  font-weight: bold;
  margin: 0;
  margin-left: 10px;
  top: 50%;
  -webkit-transform : translateY(-50%);
  transform : translateY(-50%);
}
.icon{
  position: absolute;
  width: 30px;
  top: 50%;
  right: 6px;
  -webkit-transform : translateY(-50%);
  transform : translateY(-50%);
}
</style>
