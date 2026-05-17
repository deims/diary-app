<?php

namespace App\Controllers;

use App\Core\Controller;
use App\Models\Share;
use App\Models\Entry;
use App\Models\User;
use App\Core\Response;

class ShareController extends Controller {
    private Share $shareModel;
    private Entry $entryModel;
    private User $userModel;
    
    public function __construct() {
        $this->shareModel = new Share();
        $this->entryModel = new Entry();
        $this->userModel = new User();
    }
    
    public function index(array $ctx): void {
        $userId = $ctx['user']['id'];
        $shares = $this->shareModel->getSharedByUser($userId);
        Response::send($shares, 200);
    }

    public function create(array $ctx): void {
        $sharedById = $ctx['user']['id'];
        $data = $this->getRequestBody();
        $sharedWithId = $data['shared_with'] ?? null;
        $entryId = $data['entry_id'] ?? null;

        // does the request have required and valid data?
        if (!is_int($sharedWithId) || !is_int($entryId)) {
            Response::error('Missing or invalid data', 422);
        }

        // does the user actually have an entry with the given id?
        $entry = $this->entryModel->getOne($sharedById, $entryId);
        if (!$entry) Response::error('Entry not found', 404);

        // does the user we want to share with exist?
        $sharedWithUser = $this->userModel->getOne($sharedWithId);
        if (!$sharedWithUser) Response::error('User not found', 404);

        // check if entry is already shared with the given user and in that case
        // send 409 Conflict error
        $existing = $this->shareModel->findByEntryAndUser($entryId, $sharedWithId);
        if ($existing) {
            Response::error('Entry already shared with this user', 409);
        }

        // everything ok, we can create a new share
        $shareId = $this->shareModel->create([
            'entry_id' => $entryId,
            'shared_by' => $sharedById,
            'shared_with' => $sharedWithId,
        ]);
        $share = $this->shareModel->find($shareId);
        Response::send($share, 200);
    }
}
