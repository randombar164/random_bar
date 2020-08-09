<template>
  <v-card flat height="161px" id="ingCard">
    <div class="float-left my-5 mx-4">
      <v-img src="http://placekitten.com/200/300" height="117px" width="112px"></v-img>
    </div>
    <div class="my-5 mr-4">
      <p class="ingName">{{ name }}</p>
      <p class="ingTotal">{{ cockNum }}種類</p>
      <ing-slot-btn :gacha="toGacha" class="ingBtn" ></ing-slot-btn>
    </div>
  </v-card>
</template>
<script>
import IngSlotBtn from "packs/atoms/IngSlotBtn";
import { mapState, mapActions } from 'vuex';

export default{
  props:[
    "id",
    "name",
  ],
  components:{
    IngSlotBtn
  },
  computed: {
    ...mapState('drinkData',[
      'cockNum'
    ])
  },
  methods:{
    ...mapActions('drinkData',[
      'countCocktail'
    ]),
    toGacha(){
      this.$router.push({ path:`/ingredient_gacha/${this.id}`, query: {IngName: this.name}});
      window.scrollTo(0,0);
    }
  },
  created(){
    this.countCocktail(this.id);
  }
}
</script>
<style scoped>
#ingCard{
  border: 1px solid #C4C4C4;
}
.ingBtn{
  width: 50%;
}
.ingName{
  font-family: Roboto;
  font-style: normal;
  font-weight: bold;
  font-size: 19px;
  line-height: 21px;
}
.ingTotal{
  font-family: Roboto;
  font-style: normal;
  font-weight: normal;
  font-size: 16px;
  line-height: 19px;
}
</style>
