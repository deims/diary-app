import { defineStore } from 'pinia'
import api from '../api'

export const useEntriesStore = defineStore('entries', {
    state: () => ({
        entries: [],
        sharedEntries: [],
        currentEntry: null
    }),

    actions: {
        async fetchEntries() {
            const { data } = await api.get('/entries')
            this.entries = data
        },

        async fetchSharedEntries() {
            const { data } = await api.get('/entries/shared')
            this.sharedEntries = data
        },

        async createEntry(content) {
            const { data } = await api.post('/entries', {'content': content})
            this.entries.unshift(data)
        },

        async updateEntry(id, content) {
            const { data } = await api.put(`/entries/${id}`, {'content': content})
            const index = this.entryIndex(id)
            if (index !== -1) this.entries[index] = data
        },

        async deleteEntry(id) {
            await api.delete(`/entries/${id}`)
            this.entries = this.entries.filter(e => e.id !== id)
        },

        entryIndex(id) {
            return this.entries.findIndex(e => e.id === id)
        },

        getEntry(id) {
            const index = this.entryIndex(id)
            if (index === -1) return null
            return this.entries[index]
        }
    }
})
