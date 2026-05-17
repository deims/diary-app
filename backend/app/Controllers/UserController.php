<?php
namespace App\Controllers;

use App\Core\Controller;
use App\Models\User;
use App\Models\Entry;
use App\Models\Share;
use App\Core\Response;

class UserController extends Controller {
    private User $userModel;
    private Entry $entryModel;
    private Share $shareModel;
    
    public function __construct() {
        $this->userModel = new User();
        $this->entryModel = new Entry();
        $this->shareModel = new Share();
    }
    
    public function index(array $ctx): void {
        $query = $this->getQueryParams();
        if (empty($query)) {
            $allUsers = $this->userModel->getAll();
            if ($ctx['user']['admin']) Response::send($allUsers, 200);
            $idsUsernames = array_map(function($user) {
                return ['id' => $user['id'], 'username' => $user['username']];
            }, $allUsers);
            Response::send($idsUsernames, 200);
        } else {
            if (empty($query['username'])) {
                Response::error('Missing username query parameter', 422);
            }
            $user = $this->userModel->findByUsername($query['username']);
            if (!$user) Response::error('Username not found', 404);
            Response::send(['id' => $user['id'], 'username' => $user['username']], 200);
        }
    }

    private function getUser(array $ctx): array {
        $loggedUser = $ctx['user'];
        $userId = (int)$ctx['id'];
        if ($loggedUser['id'] !== $userId && !$loggedUser['admin']) {
            Response::error('Admin access required', 403);
        }
        $user = $this->userModel->getOne($userId);
        if (!$user) Response::error('User not found', 404);
        return $user;
    }

    public function read(array $ctx): void {
        Response::send($this->getUser($ctx), 200);
    }

    public function delete(array $ctx): void {
        $user = $this->getUser($ctx);
        if ($user['admin']) Response::error('Deleting admins is not allowed', 403);
        $userId = $user['id'];
        $this->shareModel->deleteByUserId($userId);
        $this->entryModel->deleteByUserId($userId);
        $this->userModel->delete($userId);
        Response::send($user, 200);
    }

    public function create(array $ctx): void {
        $data = $this->getRequestBody();
        $username = $data['username'] ?? null;
        $password = $data['password'] ?? null;
        if (!is_string($username) || !is_string($password)) {
            Response::error('Missing or invalid username/password', 422);
        }
        if ($this->userModel->findByUsername($username)) {
            Response::error('Username already exists', 409);
        }
        $admin = $data['admin'] ?? null;
        $userId = $this->userModel->create([
            'username' => $username,
            'password_hash' => password_hash($password, PASSWORD_BCRYPT),
            'admin' => (int)$admin
        ]);
        Response::send($this->userModel->find($userId), 201);
    }

    public function password(array $ctx): void {
        $user = $this->getUser($ctx);
        $data = $this->getRequestBody();
        $newPassword = $data['password'] ?? null;
        if (!is_string($newPassword)) Response::error('Missing or invalid password', 422);
        $newPasswordHash = password_hash($newPassword, PASSWORD_BCRYPT);
        if (!$this->userModel->update($user['id'], ['password_hash' => $newPasswordHash])) {
            Response::error('Failed to set new password', 500);
        }
        Response::send([], 200);
    }

    public function admin(array $ctx): void {
        $user = $this->getUser($ctx);
        $data = $this->getRequestBody();
        $newAdminStatus = $data['admin'] ?? null;
        if (!is_bool($newAdminStatus)) Response::error('Missing or invalid admin status', 422);
        if (!$this->userModel->update($user['id'], ['admin' => (int)$newAdminStatus])) {
            Response::error('Failed to set new admin status', 500);
        }
        Response::send($this->userModel->getOne($user['id']), 200);
    }
}
