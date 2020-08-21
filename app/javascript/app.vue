<template>
  <v-app>
    <div id="app">
      <header-component />
        <v-content>
          <!-- Provides the application the proper gutter -->
          <!-- <v-container fluid> -->
            <!-- If using vue-router -->
              <router-view />
          <!-- </v-container> -->
      </v-content>
      <amazon-osusume />
      <footer-component />
    </div>
  </v-app>
</template>

<script>
import HeaderComponent from './packs/organisms/header';
import FooterComponent from './packs/organisms/footer';
import AmazonOsusume from './packs/molecules/AmazonOsusume';

export default {
  components: {
    HeaderComponent,
    FooterComponent,
    AmazonOsusume
  }
}
</script>

<style>
.marginTop9 {
  margin-top: 90px
}
#app{
  background-color: #FCFAF1;
}
</style>
