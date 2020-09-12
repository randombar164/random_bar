<template>
  <v-container>
    <v-row v-for="recommendedIngredient in recommendedIngredients" :key=recommendedIngredient.id>
      <v-col cols="12">
        <p class="gachaWith">{{ recommendedIngredient.category }}からガチャる</p>
      </v-col>
      <v-col cols="12" v-for="ings in recommendedIngredient.ingredients" :key=ings.id>
        <slot-ingredient-card :id="ings.id" :name="ings.name" :count="ings.count" :amazonImage="ings.amazonImage"></slot-ingredient-card>
      </v-col>
    </v-row>
  </v-container>
</template>
<script>
import SlotIngredientCard from "packs/molecules/SlotIngredientCard";
import { mapState, mapActions } from 'vuex';

export default{
  components:{
    SlotIngredientCard
  },
  data: function(){
    return{
      "recommendedIngredients": null
    }
  },
  computed: {
    ...mapState('drinkData',[
      'ingredientCardsInfo',
    ])
  },
  created(){
    this.getIngredietCards();
    this.recommendedIngredients = this.ingredientCardsInfo;
    console.log(this.ingredientCardsInfo);
  },
  methods: {
    ...mapActions('drinkData',[
      'getIngredietCards'
    ]),
  }
}
</script>
<style scoped>
.gachaWith{
  font-family: Roboto;
  font-style: normal;
  font-weight: bold;
  border-bottom:solid;
  font-size: 16px;
  line-height: 19px;
  padding-bottom: 9px;
  margin-bottom: 0;
}
</style>
