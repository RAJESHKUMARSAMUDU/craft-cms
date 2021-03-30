<?php

/**
 * Database Configuration
 *
 * All of your system's database configuration settings go in here.
 * You can see a list of the default settings in craft/app/etc/config/defaults/db.php
 */

return array(

	'server' => $_SERVER["CRAFT_DATABASE_HOST"],

	'database' => $_SERVER["CRAFT_DATABASE_NAME"],

	'user' => $_SERVER["CRAFT_DATABASE_USER"],

	'password' => $_SERVER["CRAFT_DATABASE_PASSWORD"],

	'tablePrefix' => 'craft',

);
