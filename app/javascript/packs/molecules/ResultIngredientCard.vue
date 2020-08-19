<template>
  <v-card  flat min-height="140px" max-height="161px" id="ingResults">
    <div class="float-left mt-3 mx-4">
      <v-img :src="imageUrl" width="112px" height="117px" contain class="IngImg"></v-img>
    </div>
    <div class="mr-4 mt-3">
      <p class="howMany">{{ amount }}{{ unit }}</p>
      <p class="resultIngName">{{ name }}</p>
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
    "amazonTag",
    "name",
    "unit",
    "amount"
  ],
  data(){
    return{
      amazonUrl: null,
      imageUrl: null
    }
  },
  components:{
    AmazonBtn
  },
  created(){
    const regexp_url = /((h?)(ttps?:\/\/[a-zA-Z0-9.\-_@:/~?%&;=+#',()*!]+))/g; // ']))/;
    this.amazonUrl = this.amazonTag.match(regexp_url)[0];
    this.imageUrl = this.amazonTag.match(regexp_url)[1];
  }
}
</script>
<style scoped>
#ingResults{
  background-color: white;
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
