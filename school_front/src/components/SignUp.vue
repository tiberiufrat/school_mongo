<template>
  <div class="max-w-sm m-auto my-8">
    <div class="border p-10 border-grey-light shadow rounded">
      <h3 class="text-2xl mb-6 text-grey-darkest">Sign Up</h3>
      <form @submit.prevent="signup">
        <div class="text-red-500" v-if="error">{{ error }}</div>

        <div class="mb-6">
          <input
            type="email"
            v-model="email"
            class="input"
            id="email"
            placeholder="E-mail"
          />
        </div>

        <div class="mb-6">
          <input
            type="password"
            v-model="password"
            class="input"
            id="password"
            placeholder="Password"
          />
        </div>

        <div class="mb-6">
          <input
            type="password"
            v-model="password_confirmation"
            class="input"
            id="password_confirmation"
            placeholder="Password Confirmation"
          />
        </div>
        <button
          type="submit"
          class="font-sans font-bold px-4 rounded-lg cursor-pointer no-underline bg-green-500 hover:bg-green-700 block w-full py-4 text-white items-center justify-center"
        >
          Sign Up
        </button>

        <div class="mb-4 mt-6 text-center">
          <router-link
            to="/sign_in"
            class="link-grey font-sans bg-gray-100 hover:bg-gray-300 w-1/2 py-2 px-3 rounded-lg"
            >Sign in</router-link
          >
        </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  name: 'SignUp',
  data () {
    return {
      email: '',
      password: '',
      password_confirmation: '',
      error: ''
    }
  },
  created () {
    this.checkedSignedIn()
  },
  updated () {
    this.checkedSignedIn()
  },
  methods: {
    signup () {
      this.$http.plain
        .post('/sign_up', {
          email: this.email,
          password: this.password,
          password_confirmation: this.password_confirmation
        })
        .then((response) => this.signupSuccessful(response))
        .catch((error) => this.signupFailed(error))
    },
    signupSuccessful (response) {
      if (!response.data.csrf) {
        this.signupFailed(response)
        return
      }

      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      this.$router.replace('/records')
    },
    signupFailed (error) {
      this.error =
        (error.response && error.response.data && error.response.data.error) ||
        'Something went wrong'
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkedSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/records')
      }
    }
  }
}
</script>
