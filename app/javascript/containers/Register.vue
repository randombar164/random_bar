<template>
  <v-container>
  <h1 class="title my-5">手元のお酒を登録</h1>
    <v-row justify="center">
    <v-col cols="12" class="py-0">
      <v-autocomplete
        v-model="items"
        class="my-0"
        :items="baseIngredientsList"
        item-text="name"
        item-value="id"
        label="材料名を入力してください。"
        item-color="#FF6749"
        outlined
        append-icon="mdi-magnify-plus-outline"
        multiple
        deletable-chips
        chips
        small-chips
        return-object
      ></v-autocomplete>
    </v-col>
    </v-row>
  <v-row>
    <v-col cols="12" v-for="registerIngredient in registeredIngredientList">
    <register-ingredient-card :id="registerIngredient.id" :name="registerIngredient.name" :imageUrl="getImageTag(registerIngredient.concrete_ingredients)" :deleteCard="deleteCard"></register-ingredient-card>
    </v-col>
  </v-row>
  <v-row class="my-3">
    <v-col cols="12" class="ma-0 pa-0">
    <v-checkbox class="select" v-model="conbiniChecked" @change="setHandlingStoreId(1)" label="コンビニの材料を含む"></v-checkbox>
    </v-col>
    <v-col cols="12" class="ma-0 pa-0">
    <v-checkbox  class="select" v-model="amazonChecked" @change="setHandlingStoreId(3)" label="Amazonの材料を含む"></v-checkbox>
    </v-col>
  </v-row>
  <v-row>
    <v-col cols="12" class="d-flex justify-center pt-0">
      <slot-btn :width="width" :msg="btnMsg" :gacha="gacha"></slot-btn>
    </v-col>
  </v-row>
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
import RegisterIngredientCard from "components/molecules/RegisterIngredientCard";
import SlotBtn from "components/atoms/SlotBtn";
import { mapState, mapActions } from 'vuex';

export default{
  components: {
    SlotBtn,
    RegisterIngredientCard
  },
  data(){
    return{
      alert: false,
      loading: false,
      conbiniChecked: true,
      amazonChecked: true,
      items: null,
      width: "100%",
      btnMsg: "作れるカクテルを見つける"
    }
  },
  watch: {
    items: function(){
      this.items && this.setIngredient(this.items.slice(-1)[0]);
    }
  },
  computed:{
    ...mapState('registerIngredients',[
      'baseIngredientsList',
      'registeredIngredientList',
      'baseIngredientIds'
    ]),
    ...mapState('handlingStore',[
      'handlingStoreIds'
    ])
  },
  methods: {
    ...mapActions('registerIngredients',[
      'getBaseIngredientsList',
      'setIngredient',
      'removeRegisteredIngredient'
    ]),
    ...mapActions('handlingStore',[
      'setHandlingStoreId'
    ]),
    getImageTag(ingredients){
        if(!ingredients){ return; };
        const amazonImage = ingredients[0].tag.match(/((h?)(ttps?:\/\/[a-zA-Z0-9.\-_@:/~?%&;=+#',()*!]+))/g)[1];
        return amazonImage;
    },
    deleteCard(id){
      this.removeRegisteredIngredient(id);
    },
    gacha(){
      if(this.handlingStoreIds.length < 1){
          this.alert = true;
          return;
      };
      this.$ga.event('click', 'button', "gacha_btn", 1) // ga の処理
      this.$router.push({ path:`/result?baseIngredientIds=${this.baseIngredientIds}&handlingStoreIds=${this.handlingStoreIds}`});
      window.scrollTo(0,0);
    }
  },
  created(){
    this.getBaseIngredientsList();
    this.items = this.registeredIngredientList;
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
</style>
