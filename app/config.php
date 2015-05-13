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

/*$app->notFound(function () use ($app) {
  if (isset($_SESSION['id'])) {
    $data = array();
    $id = $_SESSION['id'];
    $data['user'] = User::where('id',$id)->first();
    $data['role'] = Role::where('id',$data['user']->rol)->first();
    $app->render('404.twig',$data);
  } else {
    $app->render('404.public.twig');
  }

});*/

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

try {
  $db = new PDO(DB_DRIVER.':host='.DB_HOST.';dbname='.DB_DATABASE.';charset='.DB_CHARSET, DB_USERNAME, DB_PASSWORD);
  } catch (PDOException $e) {
    echo $e;
}


?>
