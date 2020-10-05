<template>
  <v-card flat class="topExp">
    <div class="expBlock  d-flex flex-column justify-center">
      <p class="concept">日々のお酒選びをもっと楽しく</p>
      <p >お家Barは今の気分に合ったカクテルを材料から見つけられるアプリです。見つかるカクテルの<span>材料は全てコンビニで揃えられる</span>ので、お酒を飲みたいと思ったらコンビニに行くだけで作ることが出来ます。<span>あなたは今、どんなお酒を飲みたいですか？</span></p>
    </div>
    <div class="letStart">
      <p>さあ、今日のお酒を見つけよう。</p>
    </div>
  </v-card>
</template>
<script>
export default{
}
</script>
<style scoped>
span{
  color: #FF6749;
}
.topExp{
  background-color: transparent;
  margin-top: 49px;
}
.expBlock{
  width: 90%;
  margin-left: 13px;
}
.concept{
  border-bottom:solid;
  font-family: "Roboto";
  font-style: normal;
  font-weight: bold;
  font-size: 16px;
  line-height: 19px;
  padding-bottom: 9px;
}
.letStart{
  text-align: center;
  padding-top: 30px;
  font-family: "Roboto";
  font-style: normal;
  font-weight: bold;
  font-size: 16px;
}
</style>
