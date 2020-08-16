<template>
  <v-container>
    <v-row>
      <v-col>
        <result></result>
        <ingredients-list></ingredients-list>
    </v-col>
  </v-row>
</v-container>
</template>
<script>
import Result from "packs/organisms/Result";
import IngredientsList from "packs/organisms/IngredientsList";
export default{
  components:{
    Result,
    IngredientsList
  }
}
</script>
