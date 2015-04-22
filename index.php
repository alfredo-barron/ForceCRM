<?php

session_cache_limiter(false);
@session_start();
date_default_timezone_set('America/Mexico_City');

require 'vendor/autoload.php';
include_once 'app/vars.inc.php';
include_once APP_FOLDER.'config.php';

//Load all the models
include_once MODELS_FOLDER."Elegant.php";
foreach(glob(MODELS_FOLDER.'*.php') as $model) {
  if($model != "Elegant.php")
    include_once $model;
}

$auth = function ($app) {
  return function () use ($app) {
    if (!isset($_SESSION['id'])) {
      //$_SESSION['redirectTo'] = $app->request()->getPathInfo()
      $app->redirect($app->urlFor('root'));
    }
  };
};

$app->contentType('text/html; charset=utf-8');

$app->hook('slim.before.dispatch', function() use ($app) {
  $user = null;
  if(isset($_SESSION['id'])) {
    $user = $_SESSION['id'];
  }
  $app->view()->appendData(array('user' => $user));
});

$app->get('/', function() use($app){
   if (!isset($_SESSION['id'])) {
      $data = array();
      $data['roles'] = Role::where('id','<>',1)->get();
      $data['rols'] = Role::all();
      $app->render('index.public.twig',$data);
    } else {
      $app->redirect($app->urlFor('dashboard'));
    }
})->name('root');

$app->get('/site', function() use($app){
  if (!isset($_SESSION['id'])) {
      $app->render('sitioweb.twig');
    } else {
      $app->render('sitioweb.twig');
    }
})->name('site');

$app->get('/lock', function() use($app){
  $app->render('lockscreen.twig');
})->name('lock');

$app->post('/registro', function() use($app){
  $post = (object) $app->request()->post();
  $user = new User();
  $user->name = $post->name;
  $user->last_name = $post->last_name;
  $user->email = $post->email;
  $user->password = md5($post->password);
  $user->gender = $post->gender;
  $user->rol = $post->rol;
  $user->save();
  $success = "Eres un nuevo miembro";
  $app->flash('success', $success);
  $app->redirect($app->urlFor('root'));
})->name('register-post');

$app->post('/login', function() use($app){
  $post = (object) $app->request()->post();
  $api = $post->api;
  $email = $post->email;
  $password = md5($post->password);
  $rol = $post->rol;
  if($email == "" || $password == "") {
    $error = "Ingrese todos los datos";
  } else {
    $user = User::with('rol')->where('email',$email)->first();
    if (!is_null($user)) {
      if ($user->password == $password) {
        if ($user->rol == $rol) {
          if ($api == 1) {
            echo $user->toJson();
            exit();
          }
          else {
            $_SESSION['id'] = $user->id;
            $app->redirect($app->urlFor('dashboard'));
          }
        }
        else {
          $role = Role::where('id',$rol)->first();
          $error = "Usted no es ".$role->name;
        }
      }
      else {
        $error = "Contraseña incorrecta";
      }
    }
    else {
      $error = $email." este miembro no existe";
    }
  }
  $app->flash('error', $error);
  $app->redirect($app->urlFor('root'));
})->name('login-post');

$app->get('/u/0', $auth($app), function() use($app){
  $data = array();
  $ages = array();
  $id = $_SESSION['id'];
  $data['user'] = User::where('id',$id)->first();
  $data['role'] = Role::where('id',$data['user']->rol)->first();
  $data['count_cus'] = Customer::count();
  $data['count_cam'] = Campaing::count();
  $data['men'] = Customer::whereGender('H')->count();
  $data['women'] = Customer::whereGender('M')->count();
  $data['customers'] = Customer::all();
  foreach ($data['customers'] as $customer) {
    $age = date('Y-m-d') - $customer->birthday;
  }
  $app->render('index.twig',$data);
})->name('dashboard');

$app->get('/logout', function() use($app){
  unset($_SESSION['id']);
  $app->view()->setData('user', null);
  $app->redirect($app->urlFor('root'));
})->name('logout');

$app->get('/dbd', function() use($app){
  $app->render('dictionary.twig');
})->name('dbd');

$app->get('/cubo', function() use($app){
  $data['customers'] = Customer::all();
  $data['users'] = User::all();
  $data['postcodes'] = Postcode::all();
  $app->render('cubo.twig',$data);
})->name('cubo');

//Load all the controllers
foreach(glob(CONTROLLERS_FOLDER.'*.php') as $router) {
  include_once $router;
}

$app->run();
?>
