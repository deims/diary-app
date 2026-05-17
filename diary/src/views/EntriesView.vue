<template>
    <div>
        <h2>My Entries</h2>
        <button id="newEntryButton" @click="openEntryModal(null)">New Entry</button>

        <div v-for="entry in entriesStore.entries" :key="entry.id" class="entry-wrapper">
            <small>{{ entry.created_at }}</small>
            <div class="entry-content">
                <div class="entry-text">
                    <p>{{ entry.content }}</p>
                </div>
                <div class="entry-actions">
                    <button @click="deleteEntry(entry.id)">Delete</button>
                    <button @click="openEntryModal(entry)">Edit</button>
                    <button @click="openShareModal(entry)">Share</button>
                </div>
            </div>
        </div>

        <div v-if="errorMessage" class="error-message">
            <p>{{ errorMessage }}</p>
        </div>

        <Modal :isOpen="entryModalOpen"
               title="Diary Entry"
               @close="closeEntryModal"
               @confirm="handleEntryModalConfirm">
            <textarea id="entryContentTextarea"
                      ref="textAreaRef"
                      v-model="entryContent"
                      placeholder="Enter something..."
                      rows="10" cols="100"
                      style="width: 90%; padding: 8px; margin-top: 10px;"
            />
        </Modal>

        <Modal :isOpen="shareModalOpen"
               title="Share Entry"
               @close="closeShareModal"
               @confirm="handleShareModalConfirm">
            <p>Share with username:</p>
            <input v-model="shareWithUsername" type="text" placeholder="Username" required />
        </Modal>
    </div>
</template>

<script setup>
import { ref, onMounted, watch, nextTick } from 'vue'
import { useEntriesStore } from '../stores/entries'
import { useUsersStore } from '../stores/users'
import { useAuthStore } from '../stores/auth'
import api from '../api'
import Modal from '../components/Modal.vue'

const entriesStore = useEntriesStore()
const usersStore = useUsersStore()
const authStore = useAuthStore()
const entryModalOpen = ref(false) // is the entry creation/edit modal open?
const entryId = ref(-1) // id of current entry
const entryContent = ref('') // content of the entry modal textarea
const createEntry = ref(false) // are we creating a new entry or editing an existing one?
const textAreaRef = ref(null)

const shareModalOpen = ref(false) // is the share modal open?
const shareWithUsername = ref('')
const selectedEntry = ref(null)

const errorMessage = ref('')
let errorTimeout = null

onMounted(() => entriesStore.fetchEntries())

const showError = (message, duration = 3000) => {
    if (errorTimeout) clearTimeout(errorTimeout)
    errorMessage.value = message
    errorTimeout = setTimeout(() => {
        errorMessage.value = ''
    }, duration)
}

// focus the textarea when EntryModal gets opened so we can start typing right away
watch(entryModalOpen, async(newVal) => {
    if (newVal) {
        await nextTick()
        if (textAreaRef.value) {
            textAreaRef.value.focus()
        }
    }
})

const openEntryModal = (entry) => {
    // passing null as entry means we create new one
    if (entry === null) {
        entryId.value = -1
        entryContent.value = ''
        createEntry.value = true
    } else { // non null means we edit an existing entry
        entryId.value = entry.id
        entryContent.value = entry.content
        createEntry.value = false
    }
    entryModalOpen.value = true
}

const closeEntryModal = () => {
    entryModalOpen.value = false
    entryId.value = -1
    entryContent.value = ''
    createEntry.value = false
}

const handleEntryModalConfirm = async () => {
    if (createEntry.value) {
        try {
            await entriesStore.createEntry(entryContent.value)
        } catch (error) {
            showError(error.response?.data?.error || 'Failed to create entry')
        }
    } else {
        try {
            await entriesStore.updateEntry(entryId.value, entryContent.value) 
        } catch (error) {
            showError(error.response?.data?.error || 'Failed to update entry')
        }
    }
}

const deleteEntry = async (id) => {
    try {
        await entriesStore.deleteEntry(id)
    } catch (error) {
        showError(error.response?.data?.error || 'Failed to delete entry')
    }
}

const openShareModal = async (entry) => {
    await usersStore.fetchUsers() // get fresh user list
    shareModalOpen.value = true
    selectedEntry.value = entry
}

const closeShareModal = () => {
    shareModalOpen.value = false
    shareWithUsername.value = ''
    selectedEntry.value = null
}

const handleShareModalConfirm = async () => {
    const user = usersStore.findUser(shareWithUsername.value)
    if (user === null) {
        console.log("check")
        showError(`No user "${shareWithUsername.value}" found`)
        return
    }
    try {
        const body = {
            'entry_id': selectedEntry.value.id,
            'shared_with': user.id
        }
        const response = await api.post('/shares', body)
        console.log('entry shared successfully')
    } catch (error) {
        showError(error.response?.data?.error || 'Failed to share entry')
    }
}

</script>

<style scoped>
#newEntryButton {
    background: #4CAF50;
    color: white;
    border: none;
    padding: 10px 24px;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s ease;
    margin-bottom: 24px;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
}

#newEntryButton:hover {
    background: #45a049;
    transform: translateY(-1px);
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

#newEntryButton:active {
    transform: translateY(0);
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
}

/* Entry list container styling */
.entry-wrapper {
    background: white;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    margin-bottom: 16px;
    padding: 16px;
    transition: box-shadow 0.2s ease;
}

.entry-wrapper:hover {
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

/* Timestamp styling */
.entry-wrapper small {
    color: #666;
    font-size: 12px;
    display: block;
    margin-bottom: 8px;
}

/* Entry content area */
.entry-content {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 16px;
}

/* Text content styling */
.entry-text {
    flex: 1;
}

.entry-text p {
    margin: 0;
    color: #333;
    line-height: 1.5;
    word-wrap: break-word;
}

/* Action buttons container */
.entry-actions {
    display: flex;
    gap: 8px;
    flex-shrink: 0;
}

/* Button styling */
.entry-actions button {
    background: #f0f0f0;
    border: none;
    border-radius: 4px;
    padding: 6px 12px;
    font-size: 13px;
    cursor: pointer;
    transition: background 0.2s ease;
}

.entry-actions button:hover {
    background: #e0e0e0;
}

.entry-actions button:active {
    transform: scale(0.98);
}

.error-message {
    position: fixed;
    top: 20px;
    right: 20px;
    background-color: #ef4444;
    color: white;
    padding: 12px 20px;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    display: flex;
    align-items: center;
    gap: 12px;
    z-index: 1000;
    animation: slideIn 0.3s ease-out;
}

@keyframes slideIn {
    from {
        transform: translateX(100%);
        opacity: 0;
    }
    to {
        transform: translateX(0);
        opacity: 1;
    }
}

</style>
