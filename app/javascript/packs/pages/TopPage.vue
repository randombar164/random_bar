<template>
  <div>
    <top-img :gacha="RandomGacha"></top-img>
    <top-exp></top-exp>
    <ingredients-list>a</ingredients-list>
  </div>
</template>
<script>
import TopExp from "packs/molecules/TopExp";
import TopImg from "packs/molecules/TopImg";
import IngredientsList from "packs/organisms/IngredientsList";
import { mapState, mapActions } from 'vuex'

export default{
  components:{
    TopExp,
    TopImg,
    IngredientsList
  },
  computed: {
    ...mapState('drinkData',[
      'cocktailRecipe',
      'drinkId',
    ])
  },
  methods: {
    ...mapActions('drinkData',[
      'getDrink',
      'foundId',
      'setRecipe',
      'removeRecipe',
      'toResult'
    ]),
    RandomGacha(){
      this.removeRecipe();
      this.getDrink({
        filters:{
          handling_store_ids: [1],
          base_ingredient_ids:[1]
        }
      });
      console.log(this.cocktailRecipe)
      this.foundId();
      this.setRecipe();
      this.$router.push({ path:`/result/${this.drinkId}`});
    }
  }
};
</script>
