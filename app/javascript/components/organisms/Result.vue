<template>
  <v-container>
    <v-row>
      <v-btn @click="toRegister" text color="#FF6749">< 材料登録に戻る</v-btn>
    </v-row>
    <v-row>
      <v-col cols="12" class="cocktailName">{{ cocktailName }}</v-col>
      <v-col cols="12" class="ings">材料</v-col>
      <v-col cols="12" class="results" v-for="recipe in cocktailIngredients" :key=recipe.id>
        <result-ingredient-card :amazonUrl="recipe.amazonUrl" :imageUrl="recipe.imageUrl" :name="recipe.name" :amount="recipe.amount" :unit="recipe.unit" :baseIngName="recipe.baseIngredientName" :additionalExp="recipe.additionalExp"></result-ingredient-card>
      </v-col>
      <v-col cols="12" class="d-flex justify-center mt-5">
        <slot-btn :gacha="gachaMore" :msg="btnMsg" :width="width"></slot-btn>
      </v-col>
      <!-- <v-col cols="12" class="d-flex justify-center">
        <share-btn></share-btn>
      </v-col> -->
    </v-row>
  </v-container>
</template>
<script>
import ResultIngredientCard from "components/molecules/ResultIngredientCard";
import SlotBtn from "components/atoms/SlotBtn";
import ShareBtn from "components/atoms/ShareBtn";
import Cocktail from "models/cocktail"
import { mapState, mapActions } from 'vuex';

export default{
  components:{
    ResultIngredientCard,
    SlotBtn,
    ShareBtn
  },
  data: function(){
    return{
      cocktail: new Cocktail({baseIngredientIds: this.$route.query.baseIngredientIds.split(","), handlingStoreIds: this.$route.query.handlingStoreIds.split(",")}),
      btnMsg: "もう１回まわす",
      width: "100%",
    }
  },
  computed: {
    ...mapState('registerIngredients',[
      'baseIngredientIds'
    ]),
    ...mapState('handlingStore',[
      'handlingStoreIds'
    ]),
    cocktailName(){return this.cocktail?.name},
    cocktailIngredients(){return this.cocktail?.ingredients}
  },
  methods: {
    gachaMore(){
      this.cocktail = new Cocktail({baseIngredientIds: this.$route.query.baseIngredientIds.split(","), handlingStoreIds: this.$route.query.handlingStoreIds.split(",")});
      this.$ga.event('click', 'button', "gacha_btn", 1) // ga の処理
      this.$router.push({ path:`/result/${this.drinkId}`});
      window.scrollTo(0,0);
    },
    toRegister(){
      this.$router.push({path: '/register'});
    }
  }
}
</script>
<style scoped>
span{
  color: #FF6749;
}
.cocktailName{
  font-family: "Roboto";
  font-style: normal;
  font-weight: normal;
  font-size: 28px;
  line-height: 33px;
  text-align: center;
  margin-top: 36px;
}
.ings{
  border-bottom:solid;
  font-family: "Roboto";
  font-style: normal;
  font-weight: bold;
  font-size: 16px;
  line-height: 19px;
  padding-bottom: 9px;
  padding-top: 35px;
}
.results{
  padding-top: 0;
  padding-bottom: 0;
}
</style>