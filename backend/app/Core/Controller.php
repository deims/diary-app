<?php

namespace App\Core;

class Controller {
    protected function getRequestBody(): array {
        $contentType = $_SERVER['CONTENT_TYPE'] ?? '';
        if (strpos($contentType, 'application/json') !== false) {
            return json_decode(file_get_contents('php://input'), true) ?? [];
        }
        return $_POST;
    }
    
    protected function getQueryParams(): array {
        return $_GET;
    }
}
