<script>
import { useFetch } from '@vueuse/core'

const authLogin = async (email, password) => {
  try {
    const payload = {
      email,
      password,
    }

    const fetchResponse = await useFetch('https://localhost:7172/api/Account/login', {
      method: 'POST',
      body: JSON.stringify(payload),
      headers: {
        'Content-Type': 'application/json',
      },
    })
    console.log(fetchResponse)
    if (!fetchResponse.statusCode.value==200) {
      console.error(`HTTP error! status: ${fetchResponse.statusCode.value}`)
      return null
    }

    const response = JSON.parse( fetchResponse.data.value)

    console.log('Login successful! Response data:', response)

    return response
  } catch (error) {
    console.error('Error during login:', error)
    return null
  }
}



const authRegister = async (username, email, password, address) => {
  try {
    const payload = {
      username,
      email,
      password,
      address,
    }
    const fetchResponse = await useFetch('https://localhost:7172/api/Account/register', {
      method: 'POST',
      body: JSON.stringify(payload),
      headers: {
        'Content-Type': 'application/json',
      },
    })
    console.log(fetchResponse)
    if (!fetchResponse.statusCode.value==200) {
      console.error(`HTTP error! status: ${fetchResponse.statusCode.value}`)
      return null
    }

    const response = JSON.parse( fetchResponse.data.value)

    console.log('Register successful! Response data:', response)

    return response
  } catch (error) {
    console.error('Error during register:', error)
    return null
  }
}

const fetchAllUsers = async () => {
  try {
    const fetchResponse = await useFetch('https://localhost:7172/api/Account/users', {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
    })

    if (!fetchResponse.statusCode.value==200) {
      console.error(`HTTP error! status: ${fetchResponse.statusCode.value}`)
      return null
    }

    const users = JSON.parse(fetchResponse.data.value)

    console.log('Fetch users successful! Users:', users)

    return users
  } catch (error) {
    console.error('Error during fetching users:', error)
    return null
  }
}
const changeRole = async (id, newRole) => {
  try {
    const fetchResponse = await useFetch(`https://localhost:7172/api/Account/changeRole/${id}`, {
      method: 'PUT',
      body: JSON.stringify(newRole),
      headers: {
        'Content-Type': 'application/json',
      },
    })
    console.log('Fetch response:', fetchResponse)
    if (!fetchResponse.statusCode.value==200) {
      console.error(`HTTP error! status: ${fetchResponse.statusCode.value}`)
      return null
    }
    console.log('Role change successful!')
    return true
  } catch (error) {
    console.error('Error during role change:', error)
    return null
  }
}

const addUser = async (userName, Email, password, FullName,PhoneNumber, role) => {
  try {
    const payload = {
      userName,
      Email,
      password,
      FullName,
      PhoneNumber,
      role,
    }
    const fetchResponse = await useFetch('https://localhost:7172/api/Account/register', {
      method: 'POST',
      body: JSON.stringify(payload),
      headers: {
        'Content-Type': 'application/json',
      },
    })
    console.log(fetchResponse)
    if (!fetchResponse.statusCode.value==200) {
      console.error(`HTTP error! status: ${fetchResponse.statusCode.value}`)
      return null
    }

    const response = JSON.parse( fetchResponse.data.value)

    console.log('Register successful! Response data:', response)

    return response
  } catch (error) {
    console.error('Error during register:', error)
    return null
  }
}
export { addUser, authLogin, authRegister, changeRole, fetchAllUsers }
</script>