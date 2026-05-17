import { defineStore } from 'pinia'
import api from '../api'

export const useUsersStore = defineStore('users', {
    state: () => ({
        users: [],
    }),

    actions: {
        updateUser(user) {
            const index = this.users.findIndex(u => u.id === user.id)
            if (index !== -1) {
                this.users[index] = user
            }
        },

        findUser(username) {
            const index = this.users.findIndex(u => u.username === username)
            return index === -1 ? null : this.users[index]
        },

        async fetchUsers() {
            const response = await api.get('/users')
            this.users = response.data
        },

        async createUser(user) {
            const response = await api.post('/users', user)
            this.users.push(response.data)
        },

        async deleteUser(id) {
            const response = await api.delete(`/users/${id}`)
            this.users = this.users.filter(u => u.id !== id)
        },

        async toggleAdmin(user) {
            const response = await api.put(`/users/${user.id}/admin`, {'admin': !user.admin})
            this.updateUser(response.data)
        },

        async resetPassword(user) {
            const response = await api.put(`/users/${user.id}/password`, {'password': user.username})
        },
    }
})
