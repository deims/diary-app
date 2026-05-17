import axios from 'axios'
import { useAuthStore } from '../stores/auth.js'

const api = axios.create({
    //for dev
    //baseURL: 'http://localhost:8000/api',
    baseURL: '/api',
    headers: { 'Content-Type': 'application/json' }
})

api.interceptors.request.use(config => {
    const authStore = useAuthStore()
    const token = authStore.token
    if (token) {
        config.headers.Authorization = `Bearer ${token}`
    }
    return config
})

api.interceptors.response.use(
    response => {
        return response
    },
    async error => {
        if (error.response?.status === 401) {
            const authStore = useAuthStore()
            authStore.logout()
        }
        if (error.response?.data?.error) {
            console.error('Error message:', error.response.data.error)
        }
        return Promise.reject(error)
    }
)

export default api
