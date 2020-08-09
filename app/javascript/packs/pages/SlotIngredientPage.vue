<template>
  <v-container>
    <v-row>
      <v-col cols="12" class="IngPageWrapper">
        <p class="cockName"><span>{{ name }}</span>を使ったカクテルガチャ</p>
        <question-circle></question-circle><br />
        <slot-btn class="ing-slot-btn" :gacha="IngredientGacha"></slot-btn>
      </v-col>
      <v-col cols="12">
        <ingredients-list></ingredients-list>
      </v-col>
    </v-row>
  </v-container>
</template>
<script>
import QuestionCircle from "packs/atoms/QuestionCircle";
import SlotBtn from "packs/atoms/SlotBtn";
import IngredientsList from "packs/organisms/IngredientsList";
import { mapActions } from 'vuex';

export default{
  components:{
    QuestionCircle,
    SlotBtn,
    IngredientsList,
  },
  data: function(){
    return{
      id: null,
      name: null
    }
  },
  created(){
    this.id = this.$route.params.ingredient_id
    this.name = this.$route.query.IngName
  },
  watch:{
    '$route' (to, from){
      this.id = to.params.ingredient_id
      this.name = to.query.IngName
    }
  },
  methods:{
    ...mapActions('drinkData',[
      'getDrink',
      'toResult',
      'removeRecipe',
      'setRecipe'
    ]),
    IngredientGacha(){
      this.removeRecipe();
      this.getDrink({
        filters:{
          base_ingredient_ids:[this.id]
        }
      });
      this.setRecipe();
      this.$router.push({ path:`/result/${this.id}`, query: {IngName: this.name}});
    }
  }
}
</script>
<style scoped>
span{
  color: #FF6749;
}
.IngPageWrapper{
  margin-top: 64px;
  text-align: center;
}
.cockName{
  font-family: Roboto;
  font-style: normal;
  font-weight: normal;
  font-size: 16px;
  line-height: 19px;
  margin-bottom: 50px;
}
.ing-slot-btn{
  width: 337px;
  margin-top: 40px
}
</style>
