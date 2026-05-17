<template>
    <div class="auth-container">
        <h2>Login</h2>
        <router-link to="/register">Register</router-link>
        <form @submit.prevent>
            <input v-model="username"
                type="text"
                placeholder="Username"
                @click="clearErrorMessages()"
                required />
            <input v-model="password"
                type="password"
                placeholder="Password"
                @click="clearErrorMessages()"
                required />
            <div v-if="loginFailed" class="error-message">
                <p>Invalid username or password.</p>
            </div>
            <div class="buttons">
                <button type="button" @click="login">Login</button>
            </div>
        </form>
    </div>
</template>

<script setup>
import { ref } from 'vue'
import { useAuthStore } from '../stores/auth'
import { useRouter } from 'vue-router'

const username = ref('')
const password = ref('')
const loginFailed = ref(false)
const authStore = useAuthStore()
const router = useRouter()

const login = async () => {
    try {
        await authStore.login(username.value, password.value)
    } catch (error) {
        if (error.response.status == 401) {
            loginFailed.value = true
        } else {
            console.error('Error:', error)
        }
    } finally {
        router.push('/')
    }
}

const clearErrorMessages = () => {
    loginFailed.value = false
}
</script>

<style scoped>
.auth-container {
    max-width: 400px;
    margin: 80px auto;
    padding: 32px;
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    text-align: center;
}

.auth-container h2 {
    color: #333;
    margin-bottom: 16px;
    font-size: 24px;
}

.auth-container > a {
    display: inline-block;
    color: #4CAF50;
    text-decoration: none;
    font-size: 14px;
    margin-bottom: 24px;
    transition: color 0.2s ease;
}

.auth-container > a:hover {
    color: #45a049;
    text-decoration: underline;
}

form {
    display: flex;
    flex-direction: column;
}

input {
    width: 100%;
    padding: 10px 12px;
    margin: 8px 0;
    border: 1px solid #e0e0e0;
    border-radius: 4px;
    font-size: 14px;
    box-sizing: border-box;
    transition: border-color 0.2s ease;
}

input:focus {
    outline: none;
    border-color: #4CAF50;
}

.error-message {
    background: #ffebee;
    color: #c62828;
    padding: 8px;
    border-radius: 4px;
    margin: 8px 0;
    font-size: 13px;
}

.buttons {
    margin-top: 16px;
}

button {
    width: 100%;
    padding: 10px;
    background: #4CAF50;
    color: white;
    border: none;
    border-radius: 4px;
    font-size: 14px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
}

button:hover {
    background: #45a049;
    transform: translateY(-1px);
}

button:active {
    transform: translateY(0);
}
</style>

