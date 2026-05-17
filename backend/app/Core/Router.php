<?php

namespace App\Core;

use App\Core\Response;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Firebase\JWT\ExpiredException;

class Router {
    private array $routes = [];
    private array $patterns = [
        '{id}' => '(?P<id>\d+)',
        '{slug}' => '(?P<slug>[a-zA-Z0-9\-]+)',
        '{any}' => '(?P<any>[^/]+)'
    ];
    
    public function get(string $path, string $handler, int $cl = CL_NONE): void {
        $this->addRoute('GET', $path, $handler, $cl);
    }
    
    public function post(string $path, string $handler, int $cl = CL_NONE): void {
        $this->addRoute('POST', $path, $handler, $cl);
    }
    
    public function put(string $path, string $handler, int $cl = CL_NONE): void {
        $this->addRoute('PUT', $path, $handler, $cl);
    }
    
    public function delete(string $path, string $handler, int $cl = CL_NONE): void {
        $this->addRoute('DELETE', $path, $handler, $cl);
    }
    
    private function addRoute(string $method, string $path, string $handler, int $cl): void {
        $pattern = str_replace(array_keys($this->patterns), array_values($this->patterns), $path);
        $pattern = '#^' . $pattern . '$#';
        
        $this->routes[] = [
            'method' => $method,
            'pattern' => $pattern,
            'handler' => $handler,
            'credlevel' => $cl, 
        ];
    }

    private function unauthorized(string $msg): void {
        Response::error($msg, 401);
    }

    private function auth(): array {
        $headers = getallheaders();
        $authHeader = $headers['Authorization'] ?? '';
        if (!preg_match('/^Bearer\s+(.+)$/', $authHeader, $matches)) {
            $this->unauthorized('No token provided');
        }
        $token = $matches[1];
        try {
            $decoded = JWT::decode($token, new Key(JWT_SECRET, 'HS256'));
            return (array)$decoded->user;
        } catch (ExpiredException $e) {
            $this->unauthorized('Token expired');
        } catch (\Exception $e) {
            $this->unauthorized('Invalid token');
        }
    }
    
    public function dispatch(): void {
        $uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
        $method = $_SERVER['REQUEST_METHOD'];
        
        // remove base path
        $basePath = dirname($_SERVER['SCRIPT_NAME']);
        if ($basePath !== '/' && strpos($uri, $basePath) === 0) {
            $uri = substr($uri, strlen($basePath));
        }
        
        $uri = rtrim($uri, '/') ?: '/';
        
        foreach ($this->routes as $route) {
            if ($route['method'] !== $method) continue;
            if (preg_match($route['pattern'], $uri, $matches)) {
                $ctx = array_filter($matches, fn($key) => is_string($key), ARRAY_FILTER_USE_KEY);
                $credLevel = $route['credlevel'];
                if ($credLevel > CL_NONE) {
                    $user = $this->auth();
                    $ctx['user'] = $user;
                    if ($credLevel > CL_AUTH && empty($user['admin'])) {
                        Response::error('Admin access required', 403);
                    }
                }
                list($controller, $action) = explode('@', $route['handler']);
                $controllerInstance = new $controller();
                $controllerInstance->$action($ctx);
                return;
            }
        }
        
        http_response_code(404);
        echo json_encode(['error' => 'Route not found']);
    }
}
