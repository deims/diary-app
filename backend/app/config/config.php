<?php
define('DB_PATH', __DIR__ . '/../../database/diary.db');
define('DB_DSN', 'sqlite:' . DB_PATH);
define('JWT_SECRET', 'bPUFn28xG1MXj@mZ6L8NYBwafQ4MfWMLS!cx__6K');
define('JWT_EXPIRY', 3600 * 24); // 24 hours
define('BCRYPT_COST', 12);
define('CL_NONE', 0);
define('CL_AUTH', 1);
define('CL_ADMIN', 2);
