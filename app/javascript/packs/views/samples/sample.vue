<template>
  <div>
    <h1>Sample Page</h1>
    <p>
      {{ sampleText }}
    </p>
    <button v-on:click="getBaseDrink">まわす</button>
    <p>
      {{ baseDrink }}
    </p>
  </div>
</template>

<script>
import { mapState, mapGetters, mapActions } from 'vuex';
  export default {
    data: function() {
      return {
        sampleText: "This is a sample page",
      }
    },
    computed: {
      baseDrink(){
        return this.$store.state.drink.baseDrink;
      }
    },
    methods: {
      getBaseDrink(){
        this.$store.dispatch('drink/getBaseDrink');
        console.log(this.$store.state.drink.baseDrink);
      }
    },
  };
</script>
