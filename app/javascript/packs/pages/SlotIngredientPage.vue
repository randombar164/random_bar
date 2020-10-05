<template>
  <v-container>
    <v-row>
      <v-col cols="12" class="IngPageWrapper">
        <p class="cockName"><span>{{ name }}</span>を使ったカクテルガチャ</p>
        <question-circle></question-circle><br />
        <slot-btn class="ing-slot-btn" :gacha="IngredientGacha" :msg="btnMsg" :width="width"></slot-btn>
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
import { mapState, mapActions } from 'vuex';

export default{
  components:{
    QuestionCircle,
    SlotBtn,
    IngredientsList,
  },
  data: function(){
    return{
      id: null,
      name: null,
      btnMsg: "まわす",
      width: "333px"
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
  computed: {
    ...mapState([
      'drinkId'
    ])
  },
  methods:{
    ...mapActions('drinkData',[
      'getDrink',
      'removeRecipe',
      'setRecipe'
    ]),
    async IngredientGacha(){
      this.removeRecipe();
      await this.getDrink({
        filters:{
          base_ingredient_ids:[ Number(this.id) ],
          handling_store_ids: [1]
        }
      });
      this.setRecipe();
      this.$router.push({ path:`/result/${this.drinkId}`, query: {IngName: this.name, IngId: this.id}});
      window.scrollTo(0,0);
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
  font-family: "Roboto";
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
