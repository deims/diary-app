<?php

namespace App\Models;

use App\Core\Model;

class User extends Model {
    protected string $table = 'users';

    public function getAll(): array {
        $sql = "SELECT id, username, admin, created_at FROM {$this->table}";
        return $this->query($sql);
    }

    public function getOne(int $userId): ?array {
        $sql = "SELECT id, username, admin, created_at FROM {$this->table} WHERE id = ?";
        $result = $this->query($sql, [$userId]);
        return empty($result) ? null : $result[0];
    }
    
    public function findByUsername(string $username): ?array {
        $sql = "SELECT id, username, password_hash, admin, created_at
                FROM {$this->table} WHERE username = ?";
        $result = $this->query($sql, [$username]);
        return empty($result) ? null : $result[0];
    }
}

