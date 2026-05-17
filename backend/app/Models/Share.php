<?php

namespace App\Models;

use App\Core\Model;

class Share extends Model {
    protected string $table = 'shares';
    
    public function findByEntryAndUser(int $entryId, int $sharedWith): ?array {
        $stmt = $this->db->prepare(
            "SELECT * FROM {$this->table} WHERE entry_id = ? AND shared_with = ?"
        );
        $stmt->execute([$entryId, $sharedWith]);
        return $stmt->fetch() ?: null;
    }
    
    public function getSharesForEntry(int $entryId): array {
        return $this->query(
            "SELECT s.*, u.username as shared_with_username 
             FROM {$this->table} s 
             JOIN users u ON s.shared_with = u.id 
             WHERE s.entry_id = ?",
            [$entryId]
        );
    }
    
    public function getSharedByUser(int $userId): array {
        return $this->query(
            "SELECT s.*, u.username as shared_with_username, e.content as entry_preview 
             FROM {$this->table} s 
             JOIN users u ON s.shared_with = u.id 
             JOIN entries e ON s.entry_id = e.id 
             WHERE s.shared_by = ? 
             ORDER BY s.created_at DESC",
            [$userId]
        );
    }

    public function deleteByUserId(int $userId): bool {
        $sql = "DELETE FROM {$this->table} WHERE shared_by = ? OR shared_with = ?";
        return $this->execute($sql, [$userId, $userId]);
    }

    public function deleteByEntryId(int $entryId): bool {
        $sql = "DELETE FROM {$this->table} WHERE entry_id = ?";
        return $this->execute($sql, [$entryId]);
    }
}
