<template>
  <v-card  flat min-height="140px" max-height="161px" id="ingResults">
    <div class="float-left mt-3 mx-4">
      <v-img :src="imageUrl" width="112px" height="117px" contain class="IngImg"></v-img>
    </div>
    <div class="mr-4 mt-3">
      <p class="supportInfo">{{ amount }}ml</p>
      <p class="resultIngName">{{ name }}</p>
      <p class="supportInfo">{{ baseIngName }}</p>
      <p class="supportInfo">{{ additionalExp }}</p>
      <amazon-btn :amazonUrl="amazonUrl"></amazon-btn>
    </div>
  </v-card>
</v-row>
</v-container>
</template>
<script>
import AmazonBtn from "packs/atoms/AmazonBtn";

export default{
  props:[
    "amazonUrl",
    "imageUrl",
    "name",
    "unit",
    "amount",
    "baseIngName",
    "additionalExp"
  ],
  components:{
    AmazonBtn
  }
}
</script>
<style scoped>
#ingResults{
  background-color: white;
  width: 100%;
  margin-top: 15px;
}
.supportInfo{
  font-family: Roboto;
  font-style: normal;
  font-weight: normal;
  font-size: 12px;
  line-height: 12px;
}
.resultIngName{
  font-family: Roboto;
  font-style: normal;
  font-weight: normal;
  font-size: 20px;
  line-height: 21px;
}
</style>
