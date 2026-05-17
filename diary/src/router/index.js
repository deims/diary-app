import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '../stores/auth'
import LoginView from '../views/LoginView.vue'
import RegisterView from '../views/RegisterView.vue'
import EntriesView from '../views/EntriesView.vue'
import SharedEntriesView from '../views/SharedEntriesView.vue'
import UserManagementView from '../views/UserManagementView.vue'

const routes = [
    { path: '/login', component: LoginView, meta: { guest: true } },
    { path: '/register', component: RegisterView, meta: {guest: true } },
    { path: '/', component: EntriesView, meta: { requiresAuth: true } },
    { path: '/shared', component: SharedEntriesView, meta: { requiresAuth: true } },
    { path: '/admin/users', component: UserManagementView, meta: { requiresAuth: true, requiresAdmin: true } }
]

const router = createRouter({
    history: createWebHistory(),
    routes
})

router.beforeEach((to, from) => {
    const authStore = useAuthStore()
    if (to.meta.requiresAuth && !authStore.isAuthenticated) return '/login'
    if (to.meta.guest && authStore.isAuthenticated) return '/'
    if (to.meta.requiresAdmin && !authStore.isAdmin) {
        console.log(authStore.currentUser)
        return '/'
    }
})

export default router
