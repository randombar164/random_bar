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
      'drinkId'
    ])
  },
  methods: {
    ...mapActions('drinkData',[
      'getDrink',
      'setRecipe',
      'removeRecipe',
    ]),
    async RandomGacha(){
      this.removeRecipe();
      await this.getDrink({
        filters:{
          handling_store_ids: [1, 2, 3],
        }
      });
      this.setRecipe();
      this.$router.push({ path:`/result/${this.drinkId}`});
      console.log("now");
      window.scrollTo(0,0);
      console.log("ddd");
      console.log(this.cocktailRecipe);
      console.log(this.drinkId);
    }
  }
};
</script>
