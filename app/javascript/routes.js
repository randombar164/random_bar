import VueRouter from 'vue-router';
import TopPage from './packs/pages/TopPage.vue'
import SlotIngredientPage from './packs/pages/SlotIngredientPage.vue'
import SlotResultPage from './packs/pages/SlotResultPage.vue'
import AboutUs from './packs/pages/AboutUs.vue'
import RegisterPage from './packs/pages/Register.vue'

const router = new VueRouter({
  routes: [
    { path: '/', component: TopPage, props: true },
    { path: '/ingredient_gacha/:ingredient_id', component: SlotIngredientPage, props: true },
    { path: '/result/:drink_id', component: SlotResultPage, props: true },
    { path: '/about_us', component: AboutUs },
    { path: '/register', component: RegisterPage }
  ]
})

export default router;
