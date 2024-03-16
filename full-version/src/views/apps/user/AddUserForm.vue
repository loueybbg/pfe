<script setup>
const firstName = ref("");
const email = ref("");
const mobile = ref();
const password = ref();
const checkbox = ref(false);

const emit = defineEmits(["userAdded"]);

const submitForm = () => {
  const user = {
    firstName: firstName.value,
    email: email.value,
    mobile: mobile.value,
    password: password.value,
    rememberMe: checkbox.value,
  };
  emit("userAdded", user);
};
const resetForm = () => {
  firstName.value = "";
  email.value = "";
  mobile.value = "";
  password.value = "";
  checkbox.value = false;
};
</script>

<template>
  <VForm @submit.prevent="() => {}">
    <VCard>
      <VCardText>
        <VRow>
          <VCol cols="12">
            <VRow no-gutters>
              <!-- 👉 First Name -->
              <VCol cols="12" md="3" class="d-flex align-items-center">
                <label
                  class="v-label text-body-2 text-high-emphasis"
                  for="firstName"
                  >First Name</label
                >
              </VCol>

              <VCol cols="12" md="9">
                <AppTextField
                  id="firstName"
                  v-model="firstName"
                  placeholder="John"
                  persistent-placeholder
                />
              </VCol>
            </VRow>
          </VCol>

          <VCol cols="12">
            <VRow no-gutters>
              <!-- 👉 Email -->
              <VCol cols="12" md="3" class="d-flex align-items-center">
                <label
                  class="v-label text-body-2 text-high-emphasis"
                  for="email"
                  >Email</label
                >
              </VCol>

              <VCol cols="12" md="9">
                <AppTextField
                  id="email"
                  v-model="email"
                  placeholder="johndoe@email.com"
                  persistent-placeholder
                />
              </VCol>
            </VRow>
          </VCol>

          <VCol cols="12">
            <VRow no-gutters>
              <!-- 👉 Mobile -->
              <VCol cols="12" md="3" class="d-flex align-items-center">
                <label
                  class="v-label text-body-2 text-high-emphasis"
                  for="mobile"
                  >Mobile</label
                >
              </VCol>

              <VCol cols="12" md="9">
                <AppTextField
                  id="mobile"
                  v-model="mobile"
                  type="number"
                  placeholder="+1 123 456 7890"
                  persistent-placeholder
                />
              </VCol>
            </VRow>
          </VCol>

          <VCol cols="12">
            <VRow no-gutters>
              <!-- 👉 Password -->
              <VCol cols="12" md="3" class="d-flex align-items-center">
                <label
                  class="v-label text-body-2 text-high-emphasis"
                  for="password"
                  >Password</label
                >
              </VCol>

              <VCol cols="12" md="9">
                <AppTextField
                  id="password"
                  v-model="password"
                  autocomplete="on"
                  type="password"
                  placeholder="············"
                  persistent-placeholder
                />
              </VCol>
            </VRow>
          </VCol>

          <!-- 👉 Remember me -->
          <VCol offset-md="3" cols="12" md="9" class="px-2">
            <VCheckbox v-model="checkbox" label="Remember me" />
          </VCol>

          <!-- 👉 submit and reset button -->
          <VCol offset-md="3" cols="12" md="9" class="d-flex gap-4">
            <VBtn @click="submitForm()" type="submit"> Submit </VBtn>
            <VBtn
              @click="resetForm()"
              color="secondary"
              variant="tonal"
              type="reset"
            >
              Reset
            </VBtn>
          </VCol>
        </VRow>
      </VCardText>
    </VCard>
  </VForm>
</template>
