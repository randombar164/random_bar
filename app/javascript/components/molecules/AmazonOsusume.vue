<template>
<v-container>
  <p class="osusume">おすすめのお酒</p>
  <v-col cols="12" v-for="ings in tempoIng" :key="ings.id">
    <v-card flat max-height="161px" min-height="140px" id="ingCard">
      <div class="float-left mx-4">
        <v-img :src="ings.amazonImage" height="117px"contain  width="112px"></v-img>
      </div>
      <div class="mr-4">
        <p class="ingName">{{ ings.name }}</p>
        <amazon-btn :amazonUrl="ings.amazonUrl"></amazon-btn>
      </div>
    </v-card>
  </v-col>
</v-container>
</template>
<script>
import temporaryIng from "components/temporaryIng.json";
import AmazonBtn from "components/atoms/AmazonBtn";

export default{
  components:{
    AmazonBtn
  },
  data(){
    return{
      tempoIng: temporaryIng.option
    }
  }
}
</script>
<style scoped>
#ingResults{
  background-color: white;
  width: 100%;
  margin-top: 15px;
}
.osusume{
  font-style: normal;
  font-weight: bold;
  border-bottom:solid;
  font-size: 16px;
  line-height: 19px;
  padding-bottom: 9px;
  margin-bottom: 0;
}
.ingName{
  font-style: normal;
  font-weight: bold;
  font-size: 19px;
  line-height: 21px;
}
</style>
