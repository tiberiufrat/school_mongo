<template>
  <div class="max-w-sm m-auto my-8">
    <div class="border p-10 border-grey-light shadow rounded">
      <h3 class="text-2xl mb-6 text-grey-darkest">Sign In</h3>
      <form @submit.prevent="signin">
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
        <button
          type="submit"
          class="font-sans font-bold px-4 rounded-lg cursor-pointer no-underline bg-green-500 hover:bg-green-700 block w-full py-4 text-white items-center justify-center"
        >
          Sign In
        </button>

        <div class="mb-4 mt-6 text-center">
          <router-link
            to="/sign_up"
            class="link-grey font-sans bg-gray-100 hover:bg-gray-300 w-1/2 py-2 px-3 rounded-lg"
            >Sign up</router-link
          >
        </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  name: "SignIn",
  data() {
    return {
      email: "",
      password: "",
      error: "",
    };
  },
  created() {
    this.checkSignedIn();
  },
  updated() {
    this.checkSignedIn();
  },
  methods: {
    signin() {
      this.$http.plain
        .post("/sign_in", { email: this.email, password: this.password })
        .then((response) => this.signinSuccessful(response))
        .catch((error) => this.signinFailed(error));
    },
    signinSuccessful(response) {
      if (!response.data.csrf) {
        this.signinFailed(response);
        return;
      }
      localStorage.csrf = response.data.csrf;
      localStorage.signedIn = true;
      this.error = "";
      this.$router.replace("/records");
    },
    signinFailed(error) {
      this.error =
        (error.response && error.response.data && error.response.data.error) ||
        "";
      delete localStorage.csrf;
      delete localStorage.signedIn;
    },
    checkSignedIn() {
      if (localStorage.signedIn) {
        this.$router.replace("/records");
      }
    },
  },
};
</script>
