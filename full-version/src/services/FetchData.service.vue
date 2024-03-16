<script setup>
import { useFetch } from '@vueuse/core'

// Create a custom useFetch function
const useMyFetch = (route, options) => {
  // Define the baseURL and the interceptor
  const baseURL = 'https://localhost:7172/api'
  const url = baseURL + route 

  const interceptor = request => {
    const token = localStorage.getItem('accessToken')
    request.headers.set('Authorization', 'Bearer '+token)
    return request
  }

  return useFetch(url, {
    interceptor,
    ...options,
  })
}
</script>