<?php

namespace App\Controllers;

use App\Core\Controller;
use App\Models\Entry;
use App\Models\Share;
use App\Core\Response;

class EntryController extends Controller {
    private Entry $entryModel;
    private Share $shareModel;
    
    public function __construct() {
        $this->entryModel = new Entry();
        $this->shareModel = new Share();
    }

    private function validEntry(int $userId, int $entryId): array {
        $entry = $this->entryModel->getOne($userId, $entryId);
        if (!$entry) Response::error('Entry not found', 404);
        return $entry;
    }

    private function validContent(): string {
        $content = $this->getRequestBody()['content'] ?? null;
        if (!is_string($content)) Response::error('Missing or invalid content', 422);
        return $content;
    }
    
    public function index(array $ctx): void {
        $userId = $ctx['user']['id'];
        $entries = $this->entryModel->getAll($userId);
        Response::send($entries, 200);
    }
    
    public function read(array $ctx): void {
        $entry = $this->validEntry($ctx['user']['id'], $ctx['id']);
        Response::send($entry, 200);
    }
    
    public function create(array $ctx): void {
        $user = $ctx['user'];
        $content = $this->validContent();
        $entryId = $this->entryModel->create([
            'user_id' => $user['id'],
            'content' => $content
        ]);
        $entry = $this->entryModel->find($entryId);
        Response::send($entry, 201);
    }
    
    public function update(array $ctx): void {
        $entryId = $ctx['id'];
        $userId = $ctx['user']['id'];
        $this->validEntry($userId, $entryId);
        $content = $this->validContent();
        $this->entryModel->updateWithTimestamp($entryId, ['content' => $content]);
        $updatedEntry = $this->entryModel->getOne($userId, $entryId);
        Response::send($updatedEntry, 200);
    }
    
    public function delete(array $ctx): void {
        $entryId = $ctx['id'];
        $userId = $ctx['user']['id'];
        $entry = $this->validEntry($userId, $entryId);
        if (!$this->shareModel->deleteByEntryId($entryId)) {
            Response::error('Failed to delete shares of the entry', 500);
        }
        $this->entryModel->delete($entryId);
        Response::send($entry, 200);
    }
    
    public function shared(array $ctx): void {
        $userId = $ctx['user']['id'];
        $entries = $this->entryModel->getSharedWithUser($userId);
        Response::send($entries, 200);
    }
}
