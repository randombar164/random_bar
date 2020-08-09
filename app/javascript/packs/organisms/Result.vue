<template>
  <v-container>
    <v-row>
      <v-col cols="12"><span>{{ this.name }}</span>を使ったカクテルガチャ</v-col>
      <v-col cols="12" class="cocktailName">{{ cocktailRecipe.name }}</v-col>
      <v-col cols="12" class="ings">材料</v-col>
      <v-col cols="12" class="results" v-for="recipe in cocktailRecipe.ingredients" :key=cocktailRecipe.ingredients.id>
        <result-ingredient-card :toAmazon="toAmazon" :name="recipe.name" :unit="recipe.unit" :amount="recipe.amount"></result-ingredient-card>
      </v-col>
    </v-row>
  </v-container>
</template>
<script>
import ResultIngredientCard from "packs/molecules/ResultIngredientCard";
import { mapState, mapActions } from 'vuex'

export default{
  components:{
    ResultIngredientCard,
  },
  data: function(){
    return{
      name: null
    }
  },
  computed: {
    ...mapState('drinkData',[
      'cocktailRecipe'
    ])
  },
  created(){
    this.name = this.$route.query.IngName;
  },
  methods: {
    ...mapActions('drinkData',[
      'getRecipe'
    ])
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
