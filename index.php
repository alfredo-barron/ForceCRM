<?php

session_cache_limiter(false);
@session_start();
date_default_timezone_set('America/Mexico_City');

require 'vendor/autoload.php';
include_once 'app/vars.inc.php';
include_once APP_FOLDER.'config.php';

//Load all the models
//include_once MODELS_FOLDER."Elegant.php";
//foreach(glob(MODELS_FOLDER.'*.php') as $model) {
//  if($model != "Elegant.php")
//    include_once $model;
//}

//forcecrm.notification@gmail.com
//crm900123

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

$app->get('/', function() use($app,$db){
  if (!isset($_SESSION['id'])) {
    $data = array();
    $st = $db->prepare("SELECT * FROM roles WHERE id <> 1");
    $st->execute();
    $data['roles'] = $st->fetchAll();
    $st = $db->prepare("SELECT * FROM roles");
    $st->execute();
    $data['rols'] = $st->fetchAll();
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
/*
$app->get('/lock', function() use($app){
  $app->render('lockscreen.twig');
})->name('lock');
*/
$app->post('/registro', function() use($app,$db){
  $post = (object) $app->request()->post();
  $name = $post->name;
  $last_name = $post->last_name;
  $email = $post->email;
  $password = md5($post->password);
  $gender = $post->gender;
  $rol = $post->rol;
  $st = $db->prepare("INSERT INTO users (name,last_name,email,password,gender,rol) VALUES (?,?,?,?,?,?)");
  $user = $st->execute(array($name,$last_name,$email,$password,$gender,$rol));
  if ($user) {
    $success = "Eres un nuevo miembro";
    $app->flash('success', $success);
    $app->redirect($app->urlFor('root'));
  }
})->name('register-post');

$app->post('/login', function() use($app,$db){
  $post = (object) $app->request()->post();
  $api = $post->api;
  $email = $post->email;
  $password = md5($post->password);
  $rol = $post->rol;
  if($email == "" || $password == "") {
    echo "vacio";
  } else {
    $st = $db->prepare("SELECT * FROM users WHERE email = ?");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($email));
    if ($user = $st->fetch()) {
      if ($user->password == $password) {
        if ($user->rol == $rol) {
          if ($api == 1) {
            echo $user->toJson();
          }
          else {
            $_SESSION['id'] = $user->id;
             echo "ok";
          }
        }
        else {
          echo "rol";
        }
      }
      else {
        echo "password";
      }
    }
    else {
      echo "user";
    }
  }
})->name('login-post');

$app->get('/logout', function() use($app){
  unset($_SESSION['id']);
  $app->view()->setData('user', null);
  $app->redirect($app->urlFor('root'));
})->name('logout');

$app->get('/dbd', function() use($app){
  $app->render('dictionary.twig');
})->name('dbd');

$app->get('/excel', function() use($app,$db){
  require('public/php-excel-reader/excel_reader2.php');
  require('public/SpreadsheetReader.php');
  $Reader = new SpreadsheetReader('public/correos.xlsx');
    foreach ($Reader as $Row) {
      $st = $db->prepare("INSERT INTO customers (name,last_name,birthdate,gender,email,telephone,place,street,number,postcode,city,entity,job,school,status_civil,sons) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
     if($customer = $st->execute(array($Row[0],$Row[1],$Row[2],$Row[3],$Row[4],$Row[5],$Row[6],$Row[7],$Row[8],$Row[9],$Row[10],$Row[11],$Row[12],$Row[13],$Row[14],$Row[15]))){
        echo "Se hizo";
     } else {
       echo "No";
     }
    }
});

$app->get('/envios', function() use($app){

  require 'vendor/phpmailer/phpmailer/PHPMailerAutoload.php';

  $mail = new PHPMailer;

  //$mail->SMTPDebug = 3;                               // Enable verbose debug output

  $mail->isSMTP();                                      // Set mailer to use SMTP
  $mail->Host = 'smtp.gmail.com';    // smtp.live.com     // Specify main and backup SMTP servers
  $mail->SMTPAuth = true;                               // Enable SMTP authentication
  $mail->Username = 'forcecrm.notification@gmail.com';                 // SMTP username
  $mail->Password = 'crm900123';                           // SMTP password
  $mail->SMTPSecure = 'tls';                            // Enable TLS encryption, `ssl` also accepted
  $mail->Port = 25;                                    // TCP port to connect to

  $mail->From = 'forcecrm.notification@gmail.com';
  $mail->FromName = 'Force CRM';
  $mail->addAddress('silvia040992@gmail.com', 'Silvia Gómez');     // Add a recipient Name is optional
  $mail->addReplyTo('forcecrm.notification@gmail.com', 'Contacto');
  //$mail->addCC('alfreedobarron@example.com');
  $mail->addBCC('forcecrm.notification@gmail.com');

  $mail->isHTML(true);                                  // Set email format to HTML

  $mail->Subject = 'Tarde de moda';
  $mail->Body    = '<h1>Ropa primavera - verano!</h1><i>3% de descuento en </i>tendencias de modas ahora!<br><br><img src="https://letiroirdubonton.files.wordpress.com/2012/03/sessun-primavera-verano-siluetas-lookbook-2012.jpg" alt="" height="164" width="379"><br>';
  $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

  if(!$mail->send()) {
      echo 'Message could not be sent.';
      echo 'Mailer Error: ' . $mail->ErrorInfo;
  } else {
      echo 'Message has been sent';
  }
});

/*
$app->get('/cubo', function() use($app){
  $data['customers'] = Customer::all();
  $data['users'] = User::all();
  $data['campaings'] = Campaing::all();
  $app->render('cubo.twig',$data);
})->name('cubo');
*/
//Load all the controllers
foreach(glob(CONTROLLERS_FOLDER.'*.php') as $router) {
  include_once $router;
}

$app->run();
?>
