<script setup>
import { useAppAbility } from '@/plugins/casl/useAppAbility'
import { authRegister } from '@/services/Auth.service.vue'
import AuthProvider from '@/views/pages/authentication/AuthProvider.vue'
import authV1BottomShape from '@images/svg/auth-v1-bottom-shape.svg?raw'
import authV1TopShape from '@images/svg/auth-v1-top-shape.svg?raw'
import { VNodeRenderer } from '@layouts/components/VNodeRenderer'
import { themeConfig } from '@themeConfig'
import {
  alphaDashValidator,
  emailValidator,
  requiredValidator,
} from '@validators'
import { ref } from "vue"
import { VForm } from 'vuetify/components/VForm'

const refVForm = ref()
const username = ref('johnDoe')
const email = ref('john@example.com')
const password = ref('john@VUEXY#123')
const privacyPolicies = ref(true)

// Router
const route = useRoute()
const router = useRouter()

// Ability
const ability = useAppAbility()

// Form Errors
const errors = ref({
  email: undefined,
  password: undefined,
})
const registerData = ref({
  address: '',
})
// function to register a user using the API in auth.service.vue like un the login.vue  
const register = async () => {
  authRegister(
     username.value,
     email.value,
     password.value,
     address.value,
  ).then(r => {
    console.log('RESPONSE', r)
    
    // Redirect to `to` query if exist or redirect to index route
    router.replace(route.query.to ? String(route.query.to) : '/login')
    
    return null
  }).catch(e => {

    console.error(e)
  })
}

// const register = () => {
//   axios.post('/auth/register', {
//     username: username.value,
//     email: email.value,
//     password: password.value,
//   }).then(r => {
//     const { accessToken, userData, userAbilities } = r.data

//     localStorage.setItem('userAbilities', JSON.stringify(userAbilities))
//     ability.update(userAbilities)
//     localStorage.setItem('userData', JSON.stringify(userData))
//     localStorage.setItem('accessToken', JSON.stringify(accessToken))

//     // Redirect to `to` query if exist or redirect to index route
//     router.replace(route.query.to ? String(route.query.to) : '/')
    
//     return null
//   }).catch(e => {
//     const { errors: formErrors } = e.response.data

//     errors.value = formErrors
//     console.error(e.response.data)
//   })
// }

// const imageVariant = useGenerateImageVariant(authV2RegisterIllustrationLight, authV2RegisterIllustrationDark, authV2RegisterIllustrationBorderedLight, authV2RegisterIllustrationBorderedDark, true)
// const authThemeMask = useGenerateImageVariant(authV2MaskLight, authV2MaskDark)
const isPasswordVisible = ref(false)

const onSubmit = () => {
  refVForm.value?.validate().then(({ valid: isValid }) => {
    if (isValid)
      register()
  })
}
</script>

<template>
  <div class="auth-wrapper d-flex align-center justify-center pa-4">
    <div class="position-relative my-sm-16">
      <!-- 👉 Top shape -->
      <VNodeRenderer
        :nodes="h('div', { innerHTML: authV1TopShape })"
        class="text-primary auth-v1-top-shape d-none d-sm-block"
      />

      <!-- 👉 Bottom shape -->
      <VNodeRenderer
        :nodes="h('div', { innerHTML: authV1BottomShape })"
        class="text-primary auth-v1-bottom-shape d-none d-sm-block"
      />

      <!-- 👉 Auth card -->
      <VCard
        class="auth-card pa-4"
        max-width="448"
      >
        <VCardItem class="justify-center">
          <template #prepend>
            <div class="d-flex">
              <VNodeRenderer :nodes="themeConfig.app.logo" />
            </div>
          </template>

          <VCardTitle class="font-weight-bold text-h5 text-capitalize py-1">
            {{ themeConfig.app.title }}
          </VCardTitle>
        </VCardItem>

        <VCardText class="pt-2">
          <h5 class="text-h5 mb-1">
            Adventure starts here 🚀
          </h5>
          <p class="mb-0">
            Make your app management easy and fun!
          </p>
        </VCardText>

        <VCardText>
          <VForm 
            ref="refVForm"
            @submit.prevent="onSubmit"
          >
            <VRow>
              <!-- Username -->
              <VCol cols="12">
                <AppTextField
                  v-model="username"
                  autofocus
                  :rules="[requiredValidator, alphaDashValidator]"
                  label="Username"
                />
              </VCol>
              <!-- Address -->
              <VCol cols="12">
                <AppTextField
                  v-model="registerData.address"
                  :rules="[requiredValidator]"
                  label="Address"
                />
                <!-- email -->
                <VCol cols="12">
                  <AppTextField
                    v-model="email"
                    :rules="[requiredValidator, emailValidator]"
                    label="Email"
                    type="email"
                  />
                </VCol>

                <!-- password -->
                <VCol cols="12">
                  <AppTextField
                    v-model="password"
                    :rules="[requiredValidator]"
                    label="Password"
                    :type="isPasswordVisible ? 'text' : 'password'"
                    :append-inner-icon="isPasswordVisible ? 'tabler-eye-off' : 'tabler-eye'"
                    @click:append-inner="isPasswordVisible = !isPasswordVisible"
                  />

                  <div class="d-flex align-center mt-2 mb-4">
                    <VCheckbox
                      id="privacy-policy"
                      v-model="privacyPolicies"
                      :rules="[requiredValidator]"
                      inline
                    />
                    <VLabel
                      for="privacy-policy"
                      style="opacity: 1;"
                    >
                      <span class="me-1">I agree to</span>
                      <a
                        href="javascript:void(0)"
                        class="text-primary"
                      >privacy policy & terms</a>
                    </VLabel>
                  </div>

                  <VBtn
                    block
                    type="submit"
                  >
                    Sign up
                  </VBtn>
                </VCol>
                <!-- login instead -->
                <VCol
                  cols="12"
                  class="text-center text-base"
                >
                  <span>Already have an account?</span>
                  <RouterLink
                    class="text-primary ms-2"
                    :to="{ name: 'login' }"
                  >
                    Sign in instead
                  </RouterLink>
                </VCol>

                <VCol
                  cols="12"
                  class="d-flex align-center"
                >
                  <VDivider />
                  <span class="mx-4">or</span>
                  <VDivider />
                </VCol>

                <!-- auth providers -->
                <VCol
                  cols="12"
                  class="text-center"
                >
                  <AuthProvider />
                </VCol>
              </vcol>
            </VRow>
          </VForm>
        </VCardText>
      </VCard>
    </div>
  </div>
</template>

<style lang="scss">
@use "@core/scss/template/pages/page-auth.scss";
</style>

<route lang="yaml">
meta:
  layout: blank
  action: read
  subject: Auth
  redirectIfLoggedIn: true
</route>
