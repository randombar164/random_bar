<template>
  <v-container>
  <h1 class="title mt-5">手元のお酒を登録</h1>
  <v-row>
    <v-col cols="12" v-for="registeredIng in registeredIngList">
    <register-ingredient-card :id="registeredIng.id" :name="registeredIng.name" :imageUrl="registeredIng.imageUrl" :deleteCard="removeRegisteredIng"></register-ingredient-card>
    </v-col>
  </v-row>
  <v-row class="d-flex justify-end">
  <v-btn  @click="dialog = !dialog" class="addBtn float-right mr-5 mt-5" color="#F5E9D3" height="47px">
    <v-icon large color="#FF6749">mdi-plus-circle</v-icon>
    <p class="addBtnText">追加登録する</p>
  </v-btn>
  </v-row>
  <v-row class="my-3">
    <v-col cols="12" class="ma-0 pa-0">
    <v-checkbox class="select" v-model="conbiniChecked" @change="setStore(1)" label="コンビニの材料を含む"></v-checkbox>
    </v-col>
    <v-col cols="12" class="ma-0 pa-0">
    <v-checkbox  class="select" v-model="amazonChecked" @change="setStore(3)" label="Amazonの材料を含む"></v-checkbox>
    </v-col>
  </v-row>
  <v-row>
    <v-col cols="12" class="d-flex justify-center pt-0">
      <slot-btn :width="width" :msg="btnMsg" :gacha="gacha"></slot-btn>
    </v-col>
  </v-row>
  <v-dialog
    v-model="dialog"
    class="dialog"
    persistent>
    <v-card>
    <v-row justify="end">
    <v-icon class="icon my-1 mr-5" @click="dialog = !dialog" large>mdi-close</v-icon>
    </v-row>
    <v-row justify="center">
    <v-col cols="10">
      <v-autocomplete
        v-model="selectedItem"
        :items="items"
        item-text="name"
        item-value="id"
        :search-input.sync="search"
        placeholder="材料名を入力してください。"
        hide-no-data
        multiple
        no-filter
        chips
        return-object
      ></v-autocomplete>
    </v-col>
    </v-row>
    <v-row justify="center"><v-btn class="my-5" @click="appendIng">登録する</v-btn></v-row>
    </v-card>
  </v-dialog>
  <v-row v-if="alert">
    <v-col cols="12" class="d-flex justify-center">
      <v-alert
      type="error"
      color="#2A5078"
      class="alertBox"
      >
      <v-row align="center">
      <v-col cols="8" class="pl-5">チェックボックスの欄を最低でも一つ選んでください</v-col>
      <v-col cols="4"><v-btn @click="alert=false" class="alertBtn" color="#FFF">OK</v-btn></v-col>
      </v-row>
    </v-alert>
    </v-col>
  </v-row>
  </v-container>
</template>
<script>
import RegisterIngredientCard from "packs/molecules/RegisterIngredientCard";
import SlotBtn from "packs/atoms/SlotBtn";
import Vue from 'vue';
import { mapState, mapActions } from 'vuex';
export default{
  components: {
    SlotBtn,
    RegisterIngredientCard
  },
  data: function(){
    return{
      dialog: false,
      search: null,
      selectedItem: null,
      alert: false,
      loading: false,
      conbiniChecked: true,
      amazonChecked: true,
      items: [],
      stores: [1, 3],
      width: "95%",
      btnMsg: "作れるカクテルを見つける"
    }
  },
  created(){
    this.getBaseIngList();
    this.removeRecipe();
    this.handlingStoreIds?.map((v) => this.deleteHandlingStoreId(v));
    this.baseIngredientIds?.map((v) => this.removeRegisteredIng(v));
    this.getRegisteredIng();
  },
  computed:{
    ...mapState('drinkData',[
      'cocktailRecipe',
      'baseIngredientsList',
      'registeredIngList',
      'drinkId',
      'baseIngredientIds',
      'handlingStoreIds'
    ])
  },
  watch: {
     search (val) {
       val && val !== this.selectedItem && this.querySelections(val)
     },
   },
  methods: {
    ...mapActions('drinkData',[
      'getBaseIngList',
      'setRegisteredIng',
      'getDrink',
      'setRecipe',
      'setHandlingStoreId',
      'deleteHandlingStoreId',
      'removeRecipe',
      'removeRegisteredIng',
      'getRegisteredIng',
      'remainRegisteredIng'
    ]),
    querySelections (v) {
        this.loading = true
        // Simulated ajax query
        setTimeout(() => {
          this.items = this.baseIngredientsList.filter(e => {
            return (e.name || '').toLowerCase().indexOf((v || '').toLowerCase()) > -1
          })
          this.loading = false
        }, 500)
      },
    setStore(id){
      if(this.stores.includes(id)){
        this.stores = this.stores.filter(v => v !== id);
      }else{
        this.stores.push(id);
      };
    },
    appendIng() {
      this.selectedItem.map((v) => this.setRegisteredIng(v));
      this.dialog = !this.dialog;
    },
    gacha(){
      this.stores.map(v => this.setHandlingStoreId(v));
      if(this.handlingStoreIds.length < 1){
          this.alert = true;
          return;
      };
      this.getDrink({
        filters:{
          base_ingredient_ids: [ ...this.baseIngredientIds ],
          handling_store_ids: [ ...this.handlingStoreIds ]
        }
      });
      this.remainRegisteredIng();
      this.setRecipe();
      this.$router.push({ path:`/result/${this.drinkId}`});
      window.scrollTo(0,0);
    }
  }
}
</script>
<style scoped>
.title{
  font-size: 23px;
}
.addBtn{
  text-align: right;
}
.addBtnText{
  font-size: 24px;
  line-height: 28px;
  margin: 0;
}
.select{
  margin-left: 10%;
}
.alertBox{
  position: absolute;
  top:0;
}
.alertBtn{
  color: #2A5078;
}
.icon{

}
.dialog{
  height: 80%;
}
</style>
