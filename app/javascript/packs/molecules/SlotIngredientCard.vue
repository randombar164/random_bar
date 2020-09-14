<template>
  <v-card flat height="161px" id="ingCard">
    <div class="float-left my-5 mx-4">
      <v-img :src="amazonImage" height="117px"contain  width="112px"></v-img>
    </div>
    <div class="ingCard-info">
      <p class="ingName">{{ name }}</p>
      <!-- <p class="ingTotal">カクテル{{ count }}種類</p> -->
      <ing-slot-btn :gacha="toGacha" class="ingBtn" ></ing-slot-btn>
    </div>
  </v-card>
</template>
<script>
import IngSlotBtn from "packs/atoms/IngSlotBtn";

export default{
  props:[
    "id",
    "name",
    "count",
    "amazonImage"
  ],
  components:{
    IngSlotBtn
  },
  methods:{
    toGacha(){
      this.$router.push({ path:`/ingredient_gacha/${this.id}`, query: {IngName: this.name, IngId: this.id}});
      window.scrollTo(0,0);
    }
  }
}
</script>
<style scoped>
#ingCard{
  border: 1px solid #C4C4C4;
  width: 100%;
}
.ingBtn{
  width: 50%;
  margin-top: 10px;
}
.ingName{
  font-family: Roboto;
  font-style: normal;
  font-weight: bold;
  font-size: 19px;
  line-height: 21px;
}
.ingTotal{
  font-family: Roboto;
  font-style: normal;
  font-weight: normal;
  font-size: 16px;
  line-height: 19px;
}
.ingCard-info{
  margin-top: 40px;
}
</style>
