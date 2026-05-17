<?php

namespace App\Controllers;

use App\Core\Controller;
use App\Models\User;
use App\Core\Response;
use Firebase\JWT\JWT;

class AuthController extends Controller {
    private User $userModel;

    public function __construct() {
        $this->userModel = new User();
    }

    private function requireCredentials(): array {
        $data = $this->getRequestBody();
        if (empty($data['username']) || empty($data['password'])) {
            Response::error('Username and password are required', 422);
        }
        return $data;
    }

    private function success(array $user): void {
        $payload = [
            'iss' => 'diary-api',
            'iat' => time(),
            'exp' => time() + JWT_EXPIRY,
            'user' => [
                'id' => $user['id'],
                'username' => $user['username'],
                'admin' => $user['admin']
            ]
        ];
        $token = JWT::encode($payload, JWT_SECRET, 'HS256');
        Response::send([
            'user' => [
                'id' => $user['id'],
                'username' => $user['username'],
                'admin' => (bool)$user['admin']
            ],
            'token' => $token
        ], 200);
    }

    public function register(): void {
        $data = $this->requireCredentials();
        if ($this->userModel->findByUsername($data['username'])) {
            Response::error('Username already exists', 409);
        }
        
        $userId = $this->userModel->create([
            'username' => $data['username'],
            'password_hash' => password_hash($data['password'], PASSWORD_BCRYPT),
            'admin' => (int)($data['admin'] ?? false)
        ]);

        $user = $this->userModel->find($userId);
        $this->success($user);
    }
    
    public function login(): void {
        $data = $this->requireCredentials();
        $user = $this->userModel->findByUsername($data['username']);
        if (!$user || !password_verify($data['password'], $user['password_hash'])) {
            Response::error('Invalid credentials', 401);
        }
        $this->success($user);
    }
}
