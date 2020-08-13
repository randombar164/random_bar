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
      btnMsg: "ガチャる",
      width: "172px"
    }
  },
  components:{
    SlotBtn
  }
}
</script>
<style scoped>
#topImg{
  background-color:rgba(255,255,255,0.52);
  background-image: url("https://recruit.fiveneeds.co.jp/wp-content/uploads/2019/09/chuttersnap-9UD0JHnWyVE-unsplash.jpg");
  background-size:cover;
  width:100%;
  height: 583px;
}
.exp{
  position: absolute;
  top: 167px;
  bottom: 356px;
  left: 18px;
  font-size: 20px;
  color: #553C60;
}
.exp-com{
  background-color: white;
}
.gachaBtn{
  position: absolute;
  width: 191px;
  height: 57px;
  top: 505px;
}
</style>
