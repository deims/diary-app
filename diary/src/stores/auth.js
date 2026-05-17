import { ref } from 'vue'
import { defineStore } from 'pinia'
import api from '../api'

export const useAuthStore = defineStore('auth', {
    state: () => ({
        user: null,
        token: null,
    }),

    getters: {
        isAuthenticated: (state) => !!state.token,
        isAdmin: (state) => state.user?.admin == true,
        currentUser: (state) => state.user
    },

    actions: {
        async register(username, password) {
            const { data } = await api.post('/register', {username, password})
            this.token = data.token
            this.user = data.user
        },

        async login(username, password) {
            const { data } = await api.post('/login', {username, password})
            this.token = data.token
            this.user = data.user
        },

        logout() {
            this.token = null
            this.user = null
        }
    },

    persist: true
})



/*
export const useAuthStore = defineStore('auth', {
    state: () => ({
        user: null,
        token: localStorage.getItem('token') || null,
    }),

    getters: {
        isAuthenticated: (state) => !!state.token,
        isAdmin: (state) => state.user?.admin === true,
        currentUser: (state) => state.user

    },

    actions: {
        async register(username, password) {
            const { data } = await api.post('/register', { username, password })
            this.token = data.token
            this.user = data.user
            localStorage.setItem('token', data.token)
        },

        async login(username, password) {
            const { data } = await api.post('/login', { username, password })
            this.token = data.token
            this.user = data.user
            console.log(JSON.stringify(data.user))
            localStorage.setItem('token', data.token)
        },

        logout() {
            this.token = null
            this.user = null
            localStorage.removeItem('token')
        }
    }
})
*/
