<template>
    <div>
        <h2>Shared With Me</h2>
        <div v-for="entry in entriesStore.sharedEntries" :key="entry.id" class="entry-wrapper">
            <small>{{ entry.created_at }} Shared by {{ entry.shared_by_username }}</small>
            <div class="entry-content">
                <div class="entry-text">
                    <p>{{ entry.content }}</p>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { onMounted } from 'vue'
import { useEntriesStore } from '../stores/entries'

const entriesStore = useEntriesStore()

onMounted(() => entriesStore.fetchSharedEntries())
</script>

<style scoped>
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
</style>

