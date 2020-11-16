import VueRouter from 'vue-router';
import TopPage from './containers/TopPage.vue'
import SlotResultPage from './containers/SlotResultPage.vue'
import AboutUs from './containers/AboutUs.vue'
import RegisterPage from './containers/Register.vue'

const router = new VueRouter({
  routes: [
    { path: '/', component: TopPage, props: true },
    { path: '/result', component: SlotResultPage, props: true },
    { path: '/about_us', component: AboutUs },
    { path: '/register', component: RegisterPage }
  ]
})

export default router;
