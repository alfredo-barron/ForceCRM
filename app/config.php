<?php
include_once 'vars.inc.php';
include_once 'arrays.php';

$app = new \Slim\Slim();
if(COOKIES_ENABLED) {
  $app->add(new \Slim\Middleware\SessionCookie(array(
    'secret'  => md5(COOKIE_SECRET),
    'expires' => COOKIE_DURATION,
    'name'    => COOKIE_NAME
  )));
}

$app->config(array(
  'debug' => true,
  'templates.path' => VIEWS_FOLDER,
  'view' => new \Slim\Views\Twig(),
  'mode'           => SLIM_MODE
));

$app->configureMode('production', function () use ($app) {
  $app->config(array('log.enabled' => true, 'debug' => false));
});

$app->configureMode('development', function () use ($app) {
  $app->config(array('log.enabled' => false, 'debug' => true));
});

$app->notFound(function () use ($app,$db) {
  if (isset($_SESSION['id'])) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $app->render('404.twig',$data);
  } else {
    $app->render('404.public.twig');
  }

});

$rootUri = $app->request()->getRootUri();
$assetUri = $rootUri;
$resourceUri = $_SERVER['REQUEST_URI'];

$view = $app->view();
$app->view->parserExtensions = array(
    new \Slim\Views\TwigExtension(),
    new Twig_Extension_Debug()
);
$app->view()->appendData(array(
  'title' => TITLE,
  'css'  => CSS_FOLDER,
  'js'   => JS_FOLDER,
  'img'  => IMG_FOLDER,
));

//$app->view()->appendData(array('navbar' => $navbar));
/*
use Illuminate\Database\Capsule\Manager as Capsule;
$capsule = new Capsule;
$capsule->addConnection(array(
  'driver'    => DB_DRIVER,
  'host'      => DB_HOST,
  'database'  => DB_DATABASE,
  'username'  => DB_USERNAME,
  'password'  => DB_PASSWORD,
  'prefix'    => DB_PREFIX,
  'charset'   => DB_CHARSET,
  'collation' => DB_COLLATION,
));
$capsule->bootEloquent();
$capsule->setAsGlobal();
$app->db = $capsule->connection();
*/


?>
