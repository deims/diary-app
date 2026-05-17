<?php

namespace App\Core;

class Response {
    public static function send(array $body, int $status): void {
        http_response_code($status);
        echo json_encode($body, JSON_PRETTY_PRINT);
        exit();
    }

    public static function error(string $msg, int $status): void {
        self::send(['error' => $msg], $status);
    }
}
