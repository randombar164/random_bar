<template>
  <div>
    <top-img :gacha="gacha"></top-img>
    <v-container>
      <top-exp></top-exp>
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
    IngredientsList,
  },
  computed: {
  },
  methods: {
    // async RandomGacha(){
    //   this.removeRecipe();
    //   await this.getDrink({
    //     filters:{
    //       handling_store_ids: [1, 2, 3],
    //     }
    //   });
    //   this.setRecipe();
    //   this.$router.push({ path:`/result/${this.drinkId}`});
    //   window.scrollTo(0,0);
    // }
    gacha(){
      this.$router.push({path: '/register'});
    }
  }
};
</script>
