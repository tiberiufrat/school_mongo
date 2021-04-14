import Vue from 'vue'
import Router from 'vue-router'
import SignIn from '@/components/SignIn'
import SignUp from '@/components/SignUp'
import Schools from '@/components/Schools'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/sign_in',
      name: 'SignIn',
      component: SignIn
    },
    {
      path: '/sign_up',
      name: 'SignUp',
      component: SignUp
    },
    {
      path: '/schools',
      name: 'Schools',
      component: Schools
    }
  ]
})
