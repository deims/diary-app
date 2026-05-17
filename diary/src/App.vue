<template>
    <div id="app">
        <nav v-if="authStore.isAuthenticated" class="navbar">
            <div class="nav-container">
                <div class="nav-brand">
                    <router-link to="/" class="brand-link">
                        <div style="display: flex;">
                            <img src="/diary-app.png">Diary App</img>
                        </div>
                    </router-link>
                </div>
                <div class="nav-links">
                    <router-link to="/" class="nav-link">My Entries</router-link>
                    <router-link to="/shared" class="nav-link">Shared With Me</router-link>
                    <router-link v-if="authStore.isAdmin"
                                 to="/admin/users"
                                 class="nav-link admin-link">
                        User Management
                    </router-link>
                    <button @click="logout" class="logout-btn">Logout</button>
                </div>
            </div>
        </nav>
        <main class="main-content">
            <router-view />
        </main>
    </div>
</template>

<script setup>
import { useAuthStore } from './stores/auth'
import { useRouter } from 'vue-router'

const authStore = useAuthStore()
const router = useRouter()

const logout = () => {
    authStore.logout()
    router.push('/login')
}
</script>

<style scoped>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

#app {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
    min-height: 100vh;
    background: #f5f5f5;
}

/* Navbar Styles */
.navbar {
    background: white;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    position: sticky;
    top: 0;
    z-index: 1000;
    border-bottom: 1px solid #e0e0e0;
}

.nav-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    min-height: 60px;
}

/* Brand/Logo */
.nav-brand {
    flex-shrink: 0;
}

.brand-link {
    font-size: 1.3rem;
    font-weight: 600;
    color: #333;
    text-decoration: none;
    transition: color 0.2s ease;
    display: inline-block;
}

.brand-link:hover {
    color: #4CAF50;
}

.brand-link img {
    width: 24px;
    height: 24px;
    margin-right: 8px;
    vertical-align: middle;
}

.brand-link div {
    display: flex;
    align-items: center;
}

/* Navigation Links Container */
.nav-links {
    display: flex;
    gap: 8px;
    align-items: center;
    flex-wrap: wrap;
}

/* Navigation Links */
.nav-link {
    color: #666;
    text-decoration: none;
    font-size: 14px;
    font-weight: 500;
    padding: 8px 16px;
    border-radius: 4px;
    transition: all 0.2s ease;
}

.nav-link:hover {
    color: #333;
    background: #f5f5f5;
}

/* Active Route Styles */

.nav-links.router-link-active {
    color: #4CAF50;
    background: #e8f5e9;
}

/* Admin Link Special Style */
.admin-link {
    color: #ff9800;
}

.admin-link:hover {
    color: #f57c00;
    background: #fff3e0;
}

.router-link-active.admin-link {
    color: #f57c00;
    background: #fff3e0;
}

/* Logout Button */
.logout-btn {
    background: #f44336;
    color: white;
    border: none;
    padding: 6px 16px;
    border-radius: 4px;
    font-size: 13px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
    margin-left: 8px;
}

.logout-btn:hover {
    background: #d32f2f;
    transform: translateY(-1px);
}

.logout-btn:active {
    transform: translateY(0);
}

/* Main Content Area */
.main-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 24px;
    animation: fadeIn 0.3s ease;
}

/* Responsive Design */
@media (max-width: 768px) {
    .nav-container {
        padding: 0 16px;
        flex-direction: column;
        gap: 12px;
        min-height: auto;
        padding: 12px 16px;
    }

    .nav-links {
        width: 100%;
        justify-content: center;
        gap: 4px;
    }

    .nav-link {
        padding: 6px 12px;
        font-size: 13px;
    }

    .logout-btn {
        padding: 6px 14px;
        font-size: 13px;
        margin-left: 4px;
    }

    .main-content {
        padding: 16px;
    }
}

@media (max-width: 480px) {
    .nav-links {
        flex-wrap: wrap;
    }
    
    .brand-link {
        font-size: 1.2rem;
    }
}

/* Animation */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
</style>

