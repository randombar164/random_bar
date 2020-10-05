<template>
  <div id="topImg">
    <div class="exp">
        <p class="exp-com">今日の気分を探しに<br>
        10000種類のカクテルから</p>
    </div>
    <div class="d-flex justify-center">
        <slot-btn class="gachaBtn" :gacha="gacha" :msg="btnMsg" :width="width"></slot-btn>
    </div>
  </div>
</template>
<script>
import SlotBtn from "packs/atoms/SlotBtn";
export default{
  props:[
    "gacha"
  ],
  data(){
    return{
      btnMsg: "材料を登録する",
      width: "220px"
    }
  },
  components:{
    SlotBtn
  }
}
</script>
<style scoped>
#topImg{
  background-image: url("https://recruit.fiveneeds.co.jp/wp-content/uploads/2019/09/chuttersnap-9UD0JHnWyVE-unsplash.jpg");
  background-size:cover;
  width:100%;
  height: 300px;
  background-color:rgba(255,255,255,0.7);
  background-blend-mode:lighten;
}
.exp{
  font-size: 20px;
  line-height: 40px;
  color: #000;
  text-align: center;
  padding-top: 90px;
}
.gachaBtn{
  width: 191px;
  height: 57px;
  margin-top: 20px;
}
</style>
