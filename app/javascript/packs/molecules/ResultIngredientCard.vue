<template>
  <v-card  flat min-height="140px" max-height="161px" id="ingResults">
    <div class="float-left mx-4">
      <v-img src="http://placekitten.com/200/300" height="117px" width="112px"></v-img>
    </div>
    <div class="mr-4">
      <p class="howMany">{{ amount }}{{ unit }}</p>
      <p class="resultIngName">{{ name }}</p>
      <amazon-btn :toAmazon="toAmazon"></amazon-btn>
    </div>
  </v-card>
</v-row>
</v-container>
</template>
<script>
import AmazonBtn from "packs/atoms/AmazonBtn";
export default{
  props:[
    "toAmazon",
    "name",
    "unit",
    "amount"
  ],
  components:{
    AmazonBtn
  }
}
</script>
<style scoped>
#ingResults{
  background-color: transparent;
  width: 100%;
  margin-top: 15px;
}
.howMany{
  font-family: Roboto;
  font-style: normal;
  font-weight: normal;
  font-size: 15px;
  line-height: 18px;
}
.resultIngName{
  font-family: Roboto;
  font-style: normal;
  font-weight: normal;
  font-size: 20px;
  line-height: 23px;
}
</style>
