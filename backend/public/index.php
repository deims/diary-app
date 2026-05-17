<?php
require_once __DIR__ . '/../vendor/autoload.php';
require_once __DIR__ . '/../app/config/config.php';

// CORS headers
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');
header('Access-Control-Allow-Credentials: true');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

use App\Core\Router;

$router = new Router();

// public routes
$router->post('/api/register', 'App\Controllers\AuthController@register', CL_NONE);
$router->post('/api/login', 'App\Controllers\AuthController@login', CL_NONE);

// protected routes
$router->get('/api/users', 'App\Controllers\UserController@index', CL_AUTH);
$router->post('/api/users', 'App\Controllers\UserController@create', CL_ADMIN);
$router->put('/api/users/{id}/admin', 'App\Controllers\UserController@admin', CL_ADMIN);
$router->get('/api/users/{id}', 'App\Controllers\UserController@read', CL_AUTH);
$router->put('/api/users/{id}/password', 'App\Controllers\UserController@password', CL_AUTH);
$router->delete('/api/users/{id}', 'App\Controllers\UserController@delete', CL_AUTH);

$router->get('/api/entries', 'App\Controllers\EntryController@index', CL_AUTH);
$router->get('/api/entries/{id}', 'App\Controllers\EntryController@read', CL_AUTH);
$router->post('/api/entries', 'App\Controllers\EntryController@create', CL_AUTH);
$router->put('/api/entries/{id}', 'App\Controllers\EntryController@update', CL_AUTH);
$router->delete('/api/entries/{id}', 'App\Controllers\EntryController@delete', CL_AUTH);
$router->get('/api/entries/shared', 'App\Controllers\EntryController@shared', CL_AUTH);

$router->get('/api/shares', 'App\Controllers\ShareController@index', CL_AUTH);
$router->post('/api/shares', 'App\Controllers\ShareController@create', CL_AUTH);

$router->dispatch();
