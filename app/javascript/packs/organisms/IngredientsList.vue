<template>
  <v-container>
    <v-row v-for="recommendedIngredient in recommendedIngredients" :key=recommendedIngredient.id>
      <v-col cols="12">
        <p class="gachaWith">{{ recommendedIngredient.category }}からガチャる</p>
      </v-col>
      <v-col cols="12" v-for="ings in recommendedIngredient.ingredients" :key=ings.id>
        <slot-ingredient-card :id="ings.id" :name="ings.name"></slot-ingredient-card>
      </v-col>
    </v-row>
  </v-container>
</template>
<script>
import SlotIngredientCard from "packs/molecules/SlotIngredientCard";
import Ingrecommended from "../Ingrecommended.json";

export default{
  components:{
    SlotIngredientCard
  },
  data: function(){
    return{
      "recommendedIngredients":Ingrecommended.option
    }
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
