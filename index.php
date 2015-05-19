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
  $mail->addAddress('alfreedobarron@gmail.com', 'Alfredo Barrón');     // Add a recipient Name is optional
  $mail->addReplyTo('forcecrm.notification@gmail.com', 'Contacto');
  //$mail->addCC('alfreedobarron@example.com');
  $mail->addBCC('forcecrm.notification@gmail.com');

  $mail->isHTML(true);                                  // Set email format to HTML

  $mail->Subject = 'Moda en la mañana';
  $mail->Body    = '<body bgcolor="#8d8e90">
<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#8d8e90">
  <tr>
    <td><table width="600" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF" align="center">
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="61"><a href= "http://yourlink" target="_blank"><img src="images/PROMO-GREEN2_01_01.jpg" width="61" height="76" border="0" alt=""/></a></td>
                <td width="144"><a href= "http://yourlink" target="_blank"><img src="images/PROMO-GREEN2_01_02.jpg" width="144" height="76" border="0" alt=""/></a></td>
                <td width="393"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="46" align="right" valign="middle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="67%" align="right"><font style="font-family: Helvetica, Arial, sans-serif; color:#68696a; font-size:8px; text-transform:uppercase"><a href= "http://yourlink" style="color:#68696a; text-decoration:none"><strong>SEND TO A FRIEND</strong></a></font></td>
                            <td width="29%" align="right"><font style="font-family: Helvetica, Arial, sans-serif; color:#68696a; font-size:8px"><a href= "http://yourlink" style="color:#68696a; text-decoration:none; text-transform:uppercase"><strong>VIEW AS A WEB PAGE</strong></a></font></td>
                            <td width="4%">&nbsp;</td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr>
                      <td height="30"><img src="images/PROMO-GREEN2_01_04.jpg" width="393" height="30" border="0" alt=""/></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
         <tr>
          <td align="center"><font style="font-family: Helvetica, Arial, sans-serif; color:#68696a; font-size:36px; text-transform:uppercase"><strong>N E W S L E T T E R</strong></font></td>
        </tr>
        <tr>
          <td align="center"><a href= "http://yourlink" target="_blank"><img src="images/PROMO-GREEN2_02.jpg" alt="" width="598" height="249" border="0"/></a></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="7%">&nbsp;</td>
                <td width="58%" align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="95%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="35" align="left" valign="middle" style="border-bottom:2px dotted #000000"><font style="font-family: Georgia, Times, serif; color:#000000; font-size:25px"><strong><em>Main Feature Story</em></strong></font></td>
                          </tr>
                          <tr>
                            <td align="left" valign="top"><font style="font-family: Verdana, Geneva, sans-serif; color:#000000; font-size:13px; line-height:21px">Lorem Ipsum. Proin gravida nibh vel velit auctor aliquet. Aenean sollicitudin, lorem quis bibendum auctor, nisi elit consequat ipsum, nec sagittis sem nibh id elit. Duis sed odio sit amet nibh vulputate cursus a sit amet mauris. Morbi accumsan ipsum velit. Nam nec tellus a odio t non</font> <font style="font-family:Verdana, Geneva, sans-serif; color:#05bcda; font-size:12px; line-height:20px"><a href= "http://yourlink" style="color:#05bcda; text-decoration:none"><strong><em>read more} </em></strong></a></font></td>
                          </tr>
                          <tr>
                            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td height="10" style="border-bottom:4px solid #d0d1d3"></td>
                              </tr>
                              <tr>
                                <td height="10"></td>
                              </tr>
                            </table></td>
                          </tr>
                          <tr>
                            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td width="43%"><img src="images/NEWSLETTER GREEN01.jpg" width="150" height="130" border="0" alt=""/></td>
                                <td width="57%" align="left" valign="top"><font style="font-family: Georgia, Times, serif; color:#05bcda; font-size:20px"><strong><em>Second feature</em></strong></font> <br />
                                  <font style="font-family: Verdana, Geneva, sans-serif; color:#000000; font-size:13px; line-height:21px">Lorem Ipsum. Proin gravida nibh vel velit auctor aliquet. Aenean sollicitudin, lorem quisn</font> <font style="font-family:Verdana, Geneva, sans-serif; color:#05bcda; font-size:12px; line-height:20px"><a href= "http://yourlink" style="color:#05bcda; text-decoration:none"><strong><em>read more} </em></strong></a></font><font style="font-family: Verdana, Geneva, sans-serif; color:#000000; font-size:13px; line-height:21px">&nbsp; </font></td>
                              </tr>
                            </table></td>
                          </tr>
                          <tr>
                            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td height="10" style="border-bottom:4px solid #d0d1d3"></td>
                              </tr>
                              <tr>
                                <td height="10"></td>
                              </tr>
                            </table></td>
                          </tr>
                          <tr>
                            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td width="43%"><img src="images/NEWSLETTER GREEN02.jpg" width="150" height="130" border="0" alt=""/></td>
                                <td width="57%" align="left" valign="top"><font style="font-family: Georgia, Times, serif; color:#05bcda; font-size:20px"><strong><em>Second feature</em></strong></font> <br />
                                  <font style="font-family: Verdana, Geneva, sans-serif; color:#000000; font-size:13px; line-height:21px">Lorem Ipsum. Proin gravida nibh vel velit auctor aliquet. Aenean sollicitudin, lorem quisn</font> <font style="font-family:Verdana, Geneva, sans-serif; color:#05bcda; font-size:12px; line-height:20px"><a href= "http://yourlink" style="color:#05bcda; text-decoration:none"><strong><em>read more} </em></strong></a></font><font style="font-family: Verdana, Geneva, sans-serif; color:#000000; font-size:13px; line-height:21px">&nbsp; </font></td>
                              </tr>
                            </table></td>
                          </tr>
                        </table></td>
                        <td width="5%" style="border-right:2px dashed #95989a">&nbsp;</td>
                      </tr>
                    </table></td>
                  </tr>
                </table></td>
                <td width="35%" align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="82%" align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td height="10"> </td>
                      </tr>
                      <tr>
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><a href="http://yourlink" target="_blank"><img src="images/NEWSLETTER GREEN03.jpg" alt="buy her" width="181" height="144" border="0"/></a></td>
                          </tr>
                          <tr>
                            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td width="12%">&nbsp;</td>
                                <td width="79%" bgcolor="#05bcda"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td width="5%"></td>
                                    <td width="90%" height="10"></td>
                                    <td width="5%"></td>
                                  </tr>
                                  <tr>
                                    <td>&nbsp;</td>
                                    <td align="center"><font style="font-family: Georgia, Times, serif; color:#ffffff; font-size:16px"><strong>SPECIAL
                                      COLUMN</strong></font></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td></td>
                                    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td height="5" style="border-bottom:1px solid #ffffff"></td>
                                      </tr>
                                      <tr>
                                        <td height="5"></td>
                                      </tr>
                                    </table></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <td>&nbsp;</td>
                                    <td align="left" valign="top"><font style="font-family: Georgia, Times, serif; color:#ffffff; font-size:14px; line-height:21px">Lorem Ipsum. Proin gravida nibh vel velit auctor aliquet. Aenean sollicitudin, lorem quis bibendum auctor, nisi elit consequat ipsum, <font style="font-family:Verdana, Geneva, sans-serif; color:#ffffff; font-size:12px; line-height:20px"><a href= "http://yourlink" style="color:#ffffff; text-decoration:none"><strong><em>read more} </em></strong></a></font></font></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td>&nbsp;</td>
                                    <td align="center"><a href="http://yourlink" target="_blank"><img src="images/NEWSLETTER GREEN04.jpg" alt="view more offers" width="129" height="43" style="display:block" border="0"/></a></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                                <td width="9%" >&nbsp;</td>
                              </tr>
                            </table></td>
                          </tr>
                          <tr>
                            <td>&nbsp;</td>
                          </tr>
                        </table></td>
                      </tr>
                    </table></td>
                    <td width="8%">&nbsp;</td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td><img src="images/PROMO-GREEN2_07.jpg" width="598" height="7" style="display:block" border="0" alt=""/></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="13%" align="center">&nbsp;</td>
              <td width="14%" align="center"><font style="font-family: Helvetica, Arial, sans-serif; color:#010203; font-size:9px; text-transform:uppercase"><a href= "http://yourlink" style="color:#010203; text-decoration:none"><strong>UNSUBSCRIBE </strong></a></font></td>
              <td width="2%" align="center"><font style="font-family: Helvetica, Arial, sans-serif; color:#010203; font-size:9px; text-transform:uppercase"><strong>|</strong></font></td>
              <td width="9%" align="center"><font style="font-family: Helvetica, Arial, sans-serif; color:#010203; font-size:9px; text-transform:uppercase"><a href= "http://yourlink" style="color:#010203; text-decoration:none"><strong>ABOUT </strong></a></font></td>
              <td width="2%" align="center"><font style="font-family: Helvetica, Arial, sans-serif; color:#010203; font-size:9px; text-transform:uppercase"><strong>|</strong></font></td>
              <td width="10%" align="center"><font style="font-family: Helvetica, Arial, sans-serif; color:#010203; font-size:9px; text-transform:uppercase"><a href= "http://yourlink" style="color:#010203; text-decoration:none"><strong>PRESS </strong></a></font></td>
              <td width="2%" align="center"><font style="font-family: Helvetica, Arial, sans-serif; color:#010203; font-size:9px; text-transform:uppercase"><strong>|</strong></font></td>
              <td width="11%" align="center"><font style="font-family: Helvetica, Arial, sans-serif; color:#010203; font-size:9px; text-transform:uppercase"><a href= "http://yourlink" style="color:#010203; text-decoration:none"><strong>CONTACT </strong></a></font></td>
              <td width="2%" align="center"><font style="font-family: Helvetica, Arial, sans-serif; color:#010203; font-size:9px; text-transform:uppercase"><strong>|</strong></font></td>
              <td width="17%" align="center"><font style="font-family: Helvetica, Arial, sans-serif; color:#010203; font-size:9px; text-transform:uppercase"><a href= "http://yourlink" style="color:#010203; text-decoration:none"><strong>STAY CONNECTED</strong></a></font></td>
              <td width="4%" align="right"><a href="https://www.facebook.com/" target="_blank"><img src="images/PROMO-GREEN2_09_01.jpg" alt="facebook" width="22" height="19" border="0" /></a></td>
              <td width="5%" align="center"><a href="https://twitter.com/" target="_blank"><img src="images/PROMO-GREEN2_09_02.jpg" alt="twitter" width="23" height="19" border="0" /></a></td>
              <td width="4%" align="right"><a href="http://www.linkedin.com/" target="_blank"><img src="images/PROMO-GREEN2_09_03.jpg" alt="linkedin" width="20" height="19" border="0" /></a></td>
              <td width="5%">&nbsp;</td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td align="center"><font style="font-family: Helvetica, Arial, sans-serif; color:#231f20; font-size:8px"><strong>Head Office &amp; Registered Office | Company name Ltd, Adress Line, Company Street, City, State, Zip Code | Tel: 123 555 555 | <a href= "http://yourlink" style="color:#010203; text-decoration:none">customercare@company.com</a></strong></font></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
      </table></td>
  </tr>
</table>';
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
