<template>
  <div>
    <top-img :gacha="RandomGacha"></top-img>
    <v-container>
      <top-exp></top-exp>
      <ingredients-list>a</ingredients-list>
    </v-container>
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
          handling_store_ids: [1],
        }
      });
      this.setRecipe();
      this.$router.push({ path:`/result/${this.drinkId}`});
      window.scrollTo(0,0);
    }
  }
};
</script>
