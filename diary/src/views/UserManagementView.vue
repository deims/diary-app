<template>
    <div>
        <h2>User Management</h2>
        <div class="create-user-form">
            <form @submit.prevent="createUser">
                <input v-model="newUser.username"
                    type="text"
                    placeholder="Name"
                    required />
                <input v-model="newUser.password"
                    type="password"
                    placeholder="Password"
                    required />
                <input v-model="newUser.confirmPassword"
                    type="password"
                    placeholder="Confirm password"
                    required />
                <button type="submit" :disabled="newUser.password !== newUser.confirmPassword">
                    Create User
                </button>
            </form>
        </div>

        <div v-if="errorMessage" class="error-message">
            <p>{{ errorMessage }}</p>
        </div>

        <div class="users-table">
            <table>
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Username</th>
                        <th>Admin</th>
                        <th>Created At</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="user in usersStore.users" :key="user.id">
                        <td>{{ user.id }}</td>
                        <td>{{ user.username }}</td>
                        <td>{{ user.admin ? 'Admin' : 'User' }}</td>
                        <td>{{ user.created_at }}</td>
                        <td>
                            <button @click="toggleAdmin(user)"
                                title="Toggle admin status">
                                Toggle Admin
                            </button>
                            <button @click="resetPassword(user)"
                                title="Reset password to username">
                                Reset Password
                            </button>
                            <button @click="deleteUser(user)"
                                title="Delete user">
                                Delete
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue'
import { useRouter } from 'vue-router'
import { useUsersStore } from '../stores/users'

const router = useRouter() 
const usersStore = useUsersStore()
const newUser = ref({ username: '', password: '', confirmPassword: '' })
const errorMessage = ref('')
let errorTimeout = null

onMounted(() => usersStore.fetchUsers())

const showError = (message, duration = 3000) => {
    if (errorTimeout) clearTimeout(errorTimeout)
    errorMessage.value = message
    errorTimeout = setTimeout(() => {
        errorMessage.value = ''
    }, duration)
}

const createUser = async () => {
    try {
        await usersStore.createUser(newUser.value)
    } catch (error) {
        showError(error.response?.data?.error || 'Failed to create user')
    } finally {
        newUser.value = { username: '', password: '', confirmPassword: '' }
    }
}

const toggleAdmin = async (user) => {
    try {
        await usersStore.toggleAdmin(user)
    } catch (error) {
        showError(error.response?.data?.error || 'Failed to toggle admin status')
    }
}

const resetPassword = async (user) => {
    try {
        await usersStore.resetPassword(user)
    } catch (error) {
        showError(error.response?.data?.error || 'Failed to reset password')
    }
}

const deleteUser = async (user) => {
    try {
        await usersStore.deleteUser(user.id)
    } catch (error) {
        showError(error.response?.data?.error || 'Failed to delete user')
    }
}

</script>

<style scoped>
/* Main container */
div {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

h2 {
    color: #333;
    margin-bottom: 24px;
    font-size: 24px;
}

/* Create user form styling */
.create-user-form {
    background: #f5f5f5;
    padding: 20px;
    border-radius: 8px;
    margin-bottom: 24px;
}

.create-user-form form {
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
    align-items: flex-end;
}

.create-user-form input {
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
    flex: 1;
    min-width: 150px;
}

.create-user-form input:focus {
    outline: none;
    border-color: #4CAF50;
}

.create-user-form button {
    background: #4CAF50;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    transition: background 0.2s ease;
}

.create-user-form button:hover:not(:disabled) {
    background: #45a049;
}

.create-user-form button:disabled {
    background: #ccc;
    cursor: not-allowed;
}

/* Users table styling */
.users-table {
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    border-radius: 0px;
    overflow: hidden;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

thead {
    background: #e2e2e2;
}

th {
    text-align: left;
    padding: 12px 16px;
    font-weight: 600;
    color: #555;
    font-size: 14px;
    border-bottom: 2px solid #e0e0e0;
}

td {
    padding: 12px 16px;
    border-bottom: 1px solid #e0e0e0;
    color: #333;
    font-size: 14px;
}

tbody tr:hover {
    background: #f9f9f9;
}

/* Action buttons styling */
td:last-child {
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
}

td button {
    background: #f0f0f0;
    border: none;
    padding: 6px 12px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
    transition: all 0.2s ease;
}

td button:hover {
    background: #e0e0e0;
    transform: translateY(-1px);
}

td button:active {
    transform: translateY(0);
}

/* Responsive design */
@media (max-width: 768px) {
    div {
        padding: 12px;
    }
    
    .create-user-form form {
        flex-direction: column;
    }
    
    .create-user-form input {
        width: 100%;
    }
    
    th, td {
        padding: 8px 12px;
    }
    
    td:last-child {
        flex-direction: column;
    }
    
    td button {
        width: 100%;
    }
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
