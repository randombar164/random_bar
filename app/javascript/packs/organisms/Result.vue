<template>
  <v-container>
    <v-row>
      <v-col cols="12" v-if="name"><span>{{ name }}</span>を使ったカクテルガチャ</v-col>
      <v-col cols="12" class="cocktailName">{{ cocktailRecipe.name }}</v-col>
      <v-col cols="12" class="ings">材料</v-col>
      <v-col cols="12" class="results" v-for="recipe in cocktailRecipe.ingredients" :key=cocktailRecipe.ingredients.id>
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
import ResultIngredientCard from "packs/molecules/ResultIngredientCard";
import SlotBtn from "packs/atoms/SlotBtn";
import ShareBtn from "packs/atoms/ShareBtn";
import { mapState, mapActions } from 'vuex'

export default{
  components:{
    ResultIngredientCard,
    SlotBtn,
    ShareBtn
  },
  data: function(){
    return{
      name: null,
      id: null,
      btnMsg: "もう１回まわす",
      width: "100%",
    }
  },
  computed: {
    ...mapState('drinkData',[
      'cocktailRecipe',
      'drinkId',
    ])
  },
  created(){
    this.getRecipe();
    if(this.$route.query.IngName){
      this.name = this.$route.query.IngName;
      this.id = this.$route.query.IngId;
    }
  },

  methods: {
    ...mapActions('drinkData',[
      'getRecipe',
      'getDrink',
      'setRecipe',
      'removeRecipe',
    ]),
    async gachaMore(){
      this.removeRecipe();
      if(this.name){
         await this.getDrink({
          filters:{
            base_ingredient_ids:[ Number(this.id) ],
            handling_store_ids: [1]
          }
        })
      }else{
        await this.getDrink({
          filters:{
            handling_store_ids:[1]
          }
        })
      };
      this.setRecipe();
      this.$router.push({ path:`/result/${this.drinkId}`, query:{IngName: this.name, IngId: this.id}});
      window.scrollTo(0,0);
    }
  }
}
</script>
<style scoped>
span{
  color: #FF6749;
}
.cocktailName{
  font-family: Roboto;
  font-style: normal;
  font-weight: normal;
  font-size: 28px;
  line-height: 33px;
  text-align: center;
  margin-top: 36px;
}
.ings{
  border-bottom:solid;
  font-family: Roboto;
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
