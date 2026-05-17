<?php

namespace App\Models;

use App\Core\Model;

class Entry extends Model {
    protected string $table = 'entries';
    
    public function getAll(int $userId): array {
        return $this->findAll(
            ['user_id' => $userId],
            ['created_at' => 'DESC']
        );
    }

    public function getOne(int $userId, int $entryId): ?array {
        $sql = "SELECT * FROM {$this->table} WHERE id = ? AND user_id = ?";
        $result = $this->query($sql, [$entryId, $userId]);
        return empty($result) ? null : $result[0];
    }
    
    public function getSharedWithUser(int $userId): array {
        return $this->query(
            "SELECT e.*, u.username as shared_by_username 
             FROM entries e 
             JOIN shares s ON e.id = s.entry_id 
             JOIN users u ON s.shared_by = u.id 
             WHERE s.shared_with = ? 
             ORDER BY s.created_at DESC",
            [$userId]
        );
    }
    
    public function updateWithTimestamp(int $id, array $data): bool {
        $data['updated_at'] = date('Y-m-d H:i:s');
        return $this->update($id, $data);
    }

    public function deleteByUserId(int $userId): bool {
        $sql = "DELETE FROM {$this->table} WHERE user_id = ?";
        return $this->execute($sql, [$userId]);
    }
}
