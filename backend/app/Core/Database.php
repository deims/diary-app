<?php

namespace App\Core;

use PDO;

class Database {
    private static ?PDO $instance = null;

    // this is a singleton class, therefore private constructor
    private function __construct() {}

    public static function getInstance(): PDO {
        if (self::$instance === null) {
            self::$instance = new PDO(DB_DSN);
            self::$instance->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            self::$instance->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
            self::$instance->exec('PRAGMA foreign_keys = ON');
            
            // init schema if tables don't exist
            self::initSchema();
        }
        return self::$instance;
    }
    
    private static function initSchema(): void {
        $schemaFile = __DIR__ . '/../../database/schema.sql';
        if (file_exists($schemaFile)) {
            self::$instance->exec(file_get_contents($schemaFile));
        }
    }
}
