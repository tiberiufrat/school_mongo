<template>
  <div class="max-w-md m-auto py-10">
    <div class="text-red" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb-4">Add a new school</h3>
    <form action="" @submit.prevent="addSchool">
      <div class="mb-6">
        <input
          class="input"
          autofocus
          autocomplete="off"
          placeholder="Type a school name"
          v-model="newSchool.name"
        />
      </div>
      <input
        type="submit"
        value="Add School"
        class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-green-500 hover:bg-green-700 block w-full py-4 text-white items-center justify-center"
      />
    </form>

    <hr class="border border-grey-300 my-6" />

    <ul class="list-reset mt-4">
      <li
        class="py-4"
        v-for="school in schools"
        :key="school.id"
        :school="school"
      >
        <div class="flex items-center justify-between flex-wrap">
          <p class="flex-1 font-mono font-semibold flex items-center">
            <svg
              class="fill-current text-indigo w-6 h-6 mr-2"
              viewBox="0 0 20 20"
              width="20"
              height="20"
            >
              <title>music school</title>
              <path
                d="M15.75 8l-3.74-3.75a3.99 3.99 0 0 1 6.82-3.08A4 4 0 0 1 15.75 8zm-13.9 7.3l9.2-9.19 2.83 2.83-9.2 9.2-2.82-2.84zm-1.4 2.83l2.11-2.12 1.42 1.42-2.12 2.12-1.42-1.42zM10 15l2-2v7h-2v-5z"
              ></path>
            </svg>
            {{ school.name }}
          </p>

          <button
            class="bg-tranparent text-sm hover:bg-blue-500 hover:text-white text-blue-500 border border-blue-500 no-underline font-bold py-2 px-4 mr-2 rounded"
            @click.prevent="editSchool(school)"
          >
            Edit
          </button>

          <button
            class="bg-transprent text-sm hover:bg-red-500 text-red-500 hover:text-white no-underline font-bold py-2 px-4 rounded border border-red-500"
            @click.prevent="removeSchool(school)"
          >
            Delete
          </button>
        </div>

        <div v-if="school == editedSchool">
          <form action="" @submit.prevent="updateSchool(school)">
            <div
              class="mb-6 p-4 bg-white rounded border border-grey-light mt-4"
            >
              <input class="input" v-model="school.name" />
              <input
                type="submit"
                value="Update"
                class="my-2 bg-transparent text-sm hover:bg-blue-500 hover:text-white text-blue-500 border border-blue-500 no-underline font-bold py-2 px-4 rounded cursor-pointer"
              />
            </div>
          </form>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: "Schools",
  data() {
    return {
      schools: [],
      newSchool: [],
      error: "",
      editedSchool: "",
    };
  },
  created() {
    if (!localStorage.signedIn) {
      this.$router.replace("/sign_in");
    } else {
      this.$http.secured
        .get("/api/v1/schools")
        .then((response) => {
          this.schools = response.data;
        })
        .catch((error) => this.setError(error, "Something went wrong"));
      console.log(this.schools);
    }
  },
  methods: {
    setError(error, text) {
      this.error =
        (error.response && error.response.data && error.response.data.error) ||
        text;
    },
    addSchool() {
      const value = this.newSchool;
      if (!value) {
        return;
      }
      this.$http.secured
        .post("/api/v1/schools/", { school: { name: this.newSchool.name } })

        .then((response) => {
          this.schools.push(response.data);
          this.newSchool = "";
        })
        .catch((error) => this.setError(error, "Cannot create school"));
    },
    removeSchool(school) {
      this.$http.secured
        .delete(`/api/v1/schools/${school.id}`)
        .then((response) => {
          this.schools.splice(this.schools.indexOf(school), 1);
        })
        .catch((error) => this.setError(error, "Cannot delete school"));
    },
    editSchool(school) {
      this.editedSchool = school;
    },
    updateSchool(school) {
      this.editedSchool = "";
      this.$http.secured
        .patch(`/api/v1/schools/${school._id.$oid}`, {
          school: { name: school.name },
        })
        .catch((error) => this.setError(error, "Cannot update school"));
    },
  },
};
</script>
