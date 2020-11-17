<template>
  <div>
    <div id="topImg">
      <div class="exp">
          <p class="exp-com">今日の気分を探しに<br>
          10000種類のカクテルから</p>
      </div>
      <div class="d-flex justify-center">
          <slot-btn class="gachaBtn" :gacha="toRegister" :msg="btnMsg" :width="width"></slot-btn>
      </div>
    </div>
    <v-container class="d-flex flex-column align-center px-3">
    <v-card flat class="mt-8">
      <v-card max-width="350px" flat class="topExp" color="secondary">
        <div class="d-flex flex-column justify-center">
          <p class="concept">今作れるカクテルが見つかる</p>
          <p >お家Barは<span>お家のお酒とコンビニで買えるもので作れるカクテルを探せるWEBサービス</span>です。手元のお酒を登録するだけで、今すぐに作れるカクテルがわかります。</p>
        </div>
      </v-card>
    </v-card>
    <v-card flat color="secondary" class="mt-3" max-width="350px" outlined>
      <p class="concept">簡単３stepでカクテルを見つけよう！</p>
      <v-card width="100%" flat class="expBlock mb-6 mx-0 d-flex flex-column align-center">
        <h3 class="mt-5">１．お家のお酒を登録</h3>
        <img class="my-5"max-width="300px" src="../static/images/cocktailExp01.png" />
      </v-card>
      <v-card width="100%" flat class="expBlock mb-6 mx-0 d-flex flex-column align-center">
        <h3 class="mt-5">２．追加の材料が買える場所を選択</h3>
        <img class="my-5" max-width="300px" src="../static/images/cocktailExp02.png"/>
      </v-card>
      <v-card width="100%" flat class="expBlock mb-6 mx-0 d-flex flex-column align-center">
        <h3 class="mt-5">３．飲みたいカクテルを見つけよう！</h3>
        <img class="my-5" max-width="300px" src="../static/images/cocktailExp03.png"/>
      </v-card>
    <v-card flat color="secondary mt-7">
      <p class="concept">新しいお酒を買ったら追加で登録！</p>
      <v-card flat class="expBlock mx-0 d-flex flex-column align-center" width="100%" >
        <h3 class="mt-5 mx-2">新しいお酒を追加して作れるカクテルを増やそう！</h3>
        <p class="mt-5 mx-2">お家のお酒は保存されているので、買ったお酒だけを登録すれば作れるカクテル数が増えます！</p>
        <img class="my-3" max-width="300px" src="../static/images/cocktailExp04.png"/>
      </v-card>
    </v-card>
    </v-card>
  </v-container>
  </div>
</template>
<script>
import SlotBtn from "components/atoms/SlotBtn";
export default{
  data(){
    return{
      btnMsg: "材料を登録する",
      width: "220px"
    }
  },
  components:{
    SlotBtn
  },
  methods: {
    toRegister(){
      this.$router.push({path: '/register'})
    }
  },
  created(){
    localStorage.removeItem("recipe");
    localStorage.removeItem("registeredIng");
  }
}
</script>
<style scoped>
span{
  color: #FF6749;
}
.topExp{
  background-color: transparent;
}
.expBlock{
  width: 90%;
  margin-left: 13px;
}
.concept{
  border-bottom:solid;
  font-style: normal;
  font-weight: bold;
  font-size: 16px;
  line-height: 19px;
  padding-bottom: 9px;
}
.letStart{
  text-align: center;
  font-style: normal;
  font-weight: bold;
  font-size: 16px;
}
#topImg{
  background-image: url("../static/images/ouchiBarTopImg.png");
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
.expBlock{
  border: 1px solid;
  border-color: #C4C4C4;
}
</style>