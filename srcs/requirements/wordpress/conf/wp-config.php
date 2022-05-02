<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'username_here' );

/** Database password */
define( 'DB_PASSWORD', 'password_here' );

/** Database hostname */
define( 'DB_HOST', 'db-service' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '%;Uv1K|~1Ly~WDTA+$@4o~Xb{vWH{5(;$A^-g|}^o01]IZT@!L0y(RJbq2y_q}~.' );
define( 'SECURE_AUTH_KEY',  '`gsw^j6^/5oJytiSb!NeU!*iYIuXq+J__sBI.`nh#!i}Vf5_J:|HB$:50=+O7n%+' );
define( 'LOGGED_IN_KEY',    'ayXyn@ys^Ne;])d6J&@a;~E5}^}z$BK1[-r[1>Jt+2.RS4jbDa#N))t;+ACvFO(y' );
define( 'NONCE_KEY',        '&d+Pd)|ZA(RY_V,)IJkYT`:JLo7/2IHn>jUr!)qLh{WpYuW)7(>q0k`>Z@d(v}hD' );
define( 'AUTH_SALT',        'qms3Y`c>bS] C(3db>Go5aw*niUN(0zC=)}5yy(P{^B<=J{EO$q@gKA&TBOccJF+' );
define( 'SECURE_AUTH_SALT', 'wciM[i^V@b8-+a5TWHdi]V9U_0r~_EWQnotRSQ8BtwbinupLE(wD+|}92&+ tC^]' );
define( 'LOGGED_IN_SALT',   '|fF/J-X~TJxeZ;wt-z7%EtN/yw]oGZuO8nT9i5|/|r !*7Z>U+wQ1Y~ #GL4~F3j' );
define( 'NONCE_SALT',       '7nWXG_ 8=|pW,A8m#.<=S?-4jq<<AOsCwKepLuG;JxmlU3n6(QtM*4],hc<w9]O)' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
