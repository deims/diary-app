<template>
    <Teleport to="body">
    <div v-if="isOpen" class="modal-overlay" @click="handleOverlayClick">
        <div class="modal-container" @click.stop>
            <div class="modal-header">
                <h3>{{ title }}</h3>
                <button class="modal-close" @click="closeModal">&times;</button>
            </div>

            <div class="modal-body">
                <slot>
                </slot>
            </div>

            <div class="modal-footer">
                <button class="btn-secondary" @click="closeModal">Cancel</button>
                <button class="btn-primary" @click="confirmModal">Confirm</button>
            </div>
        </div>
    </div>
    </Teleport>
</template>

<script setup>
import { watch } from 'vue'

const props = defineProps({
    title: {
        type: String,
        default: 'Modal title'
    },

    isOpen: {
        type: Boolean,
        default: false
    },

    closeOnOverlayClick: {
        type: Boolean,
        default: true
    }
})

const emit = defineEmits(['close', 'confirm'])

const closeModal = () => {
    emit('close')
}

const confirmModal = () => {
    emit('confirm')
    emit('close')
}

// close the modal when user clicks outside of the modal
const handleOverlayClick = () => {
    if (props.closeOnOverlayClick) {
        closeModal()
    }
}

// close modal on escape key press
watch(() => props.isOpen, (newVal) => {
    if (newVal) {
        const handleEscape = (e) => { if (e.key === 'Escape') closeModal() }
        document.addEventListener('keydown', handleEscape)
        return () => document.removeEventListener('keydown', handleEscape)
    }
})
</script>

<style scoped>
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 9999;
    animation: fadeIn 0.2s ease;
}

.modal-container {
    background-color: white;
    border-radius: 8px;
    min-width: 500px;
    max-width: 800px;
    width: 90%;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    animation: slideIn 0.3s ease;
}

.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 24px;
    border-bottom: 1px solid #e0e0e0;
}

.modal-header h3 {
    margin: 0;
    font-size: 1.25rem;
    font-weight: 600;
    color: #333;
}

.modal-close {
    background: none;
    border: none;
    font-size: 1.5rem;
    cursor: pointer;
    padding: 0;
    width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 4px;
    color: #666;
    transition: all 0.2s ease;
}

.modal-close:hover {
    background-color: #f5f5f5;
    color: #333;
}

.modal-body {
    padding: 24px;
    min-height: 100px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.modal-body * {
    margin: 10px;
}

.modal-footer {
    display: flex;
    justify-content: flex-end;
    gap: 12px;
    padding: 16px 24px;
    border-top: 1px solid #e0e0e0;
}

.btn-primary,
.btn-secondary {
    padding: 8px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 500;
    transition: all 0.2s ease;
}

.btn-primary {
    background-color: #4CAF50;
    color: white;
}

.btn-primary:hover {
    background-color: #45a049;
    transform: translateY(-1px);
}

.btn-primary:active {
    transform: translateY(0);
}

.btn-secondary {
    background-color: #f0f0f0;
    color: #666;
}

.btn-secondary:hover {
    background-color: #e0e0e0;
    color: #333;
    transform: translateY(-1px);
}

.btn-secondary:active {
    transform: translateY(0);
}

@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}

@keyframes slideIn {
    from {
        transform: translateY(-20px);
        opacity: 0;
    }
    to {
        transform: translateY(0);
        opacity: 1;
    }
}

/* Responsive styling */
@media (max-width: 768px) {
    .modal-container {
        min-width: 90%;
        width: 95%;
    }
    
    .modal-header {
        padding: 16px 20px;
    }
    
    .modal-body {
        padding: 20px;
    }
    
    .modal-footer {
        padding: 12px 20px;
    }
    
    .btn-primary,
    .btn-secondary {
        padding: 8px 16px;
    }
}
</style>

