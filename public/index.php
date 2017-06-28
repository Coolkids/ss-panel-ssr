<?php

//  PUBLIC_PATH
define('PUBLIC_PATH', __DIR__);
ini_set("include_path", '.:/usr/local/php/lib/php:'.PUBLIC_PATH.'/../bootstrap');
// Bootstrap
require PUBLIC_PATH . '/../bootstrap/app.php';

// Build Slim App
$app = require BASE_PATH . '/app/routes.php';

// Run ButterFly!
$app->run();
