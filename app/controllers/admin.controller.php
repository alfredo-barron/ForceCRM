<?php

$app->group('/u/0/calendario', $auth($app), function() use($app,$db){

  $app->get('', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $app->render('calendar.twig',$data);
  })->name('calendar');

});

$app->group('/u/0/clientes', $auth($app), function() use($app,$db){

  $app->get('/nuevo', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM postcodes");
    $st->execute();
    $data['postcodes'] = $st->fetchAll();
    $st = $db->prepare("SELECT * FROM jobs");
    $st->execute();
    $data['jobs'] = $st->fetchAll();
    $st = $db->prepare("SELECT * FROM schools");
    $st->execute();
    $data['schools'] = $st->fetchAll();
    $st = $db->prepare("SELECT * FROM status_civil");
    $st->execute();
    $data['status_civil'] = $st->fetchAll();
    $app->render('newcustomer.twig',$data);
  })->name('new-customer');

  $app->get('/actualizar(/:id_c)', function($id_c) use($app,$db) {
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM customers WHERE id = ?");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id_c));
    $data['customer'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM jobs WHERE id = ?");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($data['customer']->job));
    $data['job'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM schools WHERE id = ?");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($data['customer']->school));
    $data['school'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM status_civil WHERE id = ?");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($data['customer']->status_civil));
    $data['status_civil1'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM postcodes");
    $st->execute();
    $data['postcodes'] = $st->fetchAll();
    $st = $db->prepare("SELECT * FROM jobs");
    $st->execute();
    $data['jobs'] = $st->fetchAll();
    $st = $db->prepare("SELECT * FROM schools");
    $st->execute();
    $data['schools'] = $st->fetchAll();
    $st = $db->prepare("SELECT * FROM status_civil");
    $st->execute();
    $data['status_civil'] = $st->fetchAll();
    $app->render('newcustomer.twig',$data);
  })->name('edit-customer');

  $app->post('/nuevo', function() use($app,$db){
    $post = (object) $app->request()->post();
    $id = (isset($post->id) and !empty($post->id)) ? $post->id : 0;
    if($id != 0){
      $name = $post->name;
      $last_name = $post->last_name;
      $birthdate = $post->birthdate1;
      $gender = $post->gender;
      $email = $post->email;
      $telephone = trim($post->telephone1);
      $street = $post->street;
      $number = $post->number;
      $postcode = $post->postcode;
      $place = $post->place;
      $city = $post->city;
      $entity = $post->entity;
      $job = $post->job;
      $school = $post->school;
      $status_civil = $post->status_civil;
      $sons = $post->sons;
      $st = $db->prepare("UPDATE customers SET name = ?, last_name = ?, birthdate = ?, gender = ?, email = ?, telephone = ?, street = ?, number = ?, postcode = ?, place = ?, city = ?, entity = ?, job = ?, school = ?, status_civil = ?, sons = ? WHERE id = $id");
      $customer = $st->execute(array($name,$last_name,$birthdate,$gender,$email,$telephone,$street,$number,$postcode,$place,$city,$entity,$job,$school,$status_civil,$sons));
      $app->redirect($app->urlFor('customers'));
    }else{
      $name = $post->name;
      $last_name = $post->last_name;
      $birthday = $post->birthday;
      $gender = $post->gender;
      $email = $post->email;
      $telephone = trim($post->telephone);
      $street = $post->street;
      $number = $post->number;
      $postcode = $post->postcode;
      $place = $post->place;
      $city = $post->city;
      $entity = $post->entity;
      $job = $post->job;
      $school = $post->school;
      $status_civil = $post->status_civil;
      $sons = $post->sons;
      $st = $db->prepare("INSERT INTO customers (name,last_name,birthdate,gender,email,telephone,street,number,postcode,place,city,entity,job,school,status_civil,sons) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
      $customer = $st->execute(array($name,$last_name,$birthdate,$gender,$email,$telephone,$street,$number,$postcode,$place,$city,$entity,$job,$school,$school,$status_civil,$sons));
      if ($customer) {
        $success = "Cliente dado de alta";
        $app->flash('success', $success);
        $app->redirect($app->urlFor('new-customer'));
      }
    }
  })->name('customer-post');

  $app->get('/perfil(/:id_c)', function($id_c) use($app,$db) {
    if ($id_c == null) {
      $app->redirect($app->urlFor('customers'));
    }
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM customers WHERE id = ?");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id_c));
    $data['customer'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM jobs WHERE id = ?");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($data['customer']->job));
    $data['job'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM schools WHERE id = ?");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($data['customer']->school));
    $data['school'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM status_civil WHERE id = ?");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($data['customer']->status_civil));
    $data['status_civil'] = $st->fetch();
    $app->render('customer.profile.twig',$data);
  })->name('profile-customer');

  $app->get('', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM customers WHERE status <> 'Potencial' AND status <> 'Actual'");
    $st->execute();
    $data['customers'] = $st->fetchAll();
    $app->render('customers.twig',$data);
  })->name('customers');

  $app->get('/potenciales', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM customers WHERE status = 'Potencial'");
    $st->execute();
    $data['customers'] = $st->fetchAll();
    $app->render('customer.potencial.twig',$data);
  })->name('customer-potencial');

  $app->get('/actuales', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM customers WHERE status = 'Actual'");
    $st->execute();
    $data['customers'] = $st->fetchAll();
    $app->render('customer.actual.twig',$data);
  })->name('customer-actual');

});

$app->group('/u/0/mercados', $auth($app), function() use($app,$db){

  $app->get('/nuevo', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $app->render('newmarket.twig',$data);
  })->name('new-market');

});

$app->group('/u/0/campanas', $auth($app), function() use($app,$db){

  $app->get('/nueva', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $app->render('newcampaing.twig',$data);
  })->name('new-campaing');

  $app->post('/nueva', function() use($app,$db) {
    $post = (object) $app->request()->post();
    $created_by = $_SESSION['id'];
    $name = $post->name;
    list($date_start, $date_end) = explode("-", $post->reservation);
    $start = $date_start;
    $end = $date_end;
    $date_now = strtotime(date("d-m-Y"));
    $date_start = strtotime($date_start);
    $date_end = strtotime($date_end);
    if ($date_start <= $date_now and $date_end >= $date_now) {
      $status = "Activa";
    } else if($date_start > $date_now) {
      $status = "En espera";
    } else if ($date_end < $date_now) {
      $status = "Finalizada";
    }
    $target = $post->target;
    $description = $post->description;
    $duration = $date_end - $date_start;
    $duration = intval($duration/60/60/24) + 1;
    $date_created = date('Y-m-d');
    $st = $db->prepare("INSERT INTO campaings (created_by,name,date_start,date_end,status,target,description,duration,date_created) VALUES (?,?,?,?,?,?,?,?,?)");
    $campaing = $st->execute(array($created_by,$name,$start,$end,$status,$target,$description,$duration,$date_created));
    if ($campaing){
      $success = "Campaña creada";
      $app->flash('success', $success);
      $app->redirect($app->urlFor('new-campaing'));
    }
  })->name('campaing-post');

  $app->get('', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM campaings WHERE status = 'Activa'");
    $st->execute();
    $data['campaings'] = $st->fetchAll();
    $app->render('campaings.activas.twig',$data);
  })->name('campaings-activas');

  $app->get('/espera', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM campaings WHERE status = 'En espera'");
    $st->execute();
    $data['campaings'] = $st->fetchAll();
    $app->render('campaings.esperas.twig',$data);
  })->name('campaings-esperas');

  $app->get('/terminadas', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM campaings WHERE status = 'Finalizada'");
    $st->execute();
    $data['campaings'] = $st->fetchAll();
    $app->render('campaings.finalizadas.twig',$data);
  })->name('campaings-finalizadas');

});

$app->group('/u/0/email', $auth($app), function() use($app,$db){

  $app->get('', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $app->render('email.twig',$data);
  })->name('email');

  $app->get('/nuevo', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM campaings WHERE status = 'Activa'");
    $st->execute();
    $data['campaings'] = $st->fetchAll();
    $app->render('email.redactar.twig',$data);
  })->name('new-email');

  $app->post('/nuevo', function() use($app,$db) {
    $post = (object) $app->request()->post();
    $created_by = $_SESSION['id'];
    $campaing_id = $post->campaing_id;
    $datetime = $post->date." ".$post->hour;
    $date_send =  new DateTime($datetime);
    $date_send = date_format($date_send,'Y-m-d H:i');
    $subject = $post->subject;
    $content = $post->content;
    $status = "Archivado";
    $st = $db->prepare("INSERT INTO emails (created_by,campaing_id,date_send,subject,content,status) VALUES (?,?,?,?,?,?)");
    $email = $st->execute(array($created_by,$campaing_id,$date_send,$subject,$content,$status));
    if ($email) {
      $success = "Correo redactado";
      $app->flash('success', $success);
      $app->redirect($app->urlFor('new-email'));
    }
  })->name('email-post');

});

$app->group('/u/0/personal', $auth($app), function() use($app,$db){

  $app->get('', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $data['users'] = User::with('rol')->get();
    $app->render('personal.twig',$data);
  })->name('personal');

});

$app->get('/postcode.json/:id', function($id) use($app,$db){
    $st = $db->prepare("SELECT * FROM postcodes WHERE id = ?");
    $st->setFetchMode(PDO::FETCH_ASSOC);
    $st->execute(array($id));
    $postcode = $st->fetch();
    echo json_encode($postcode);
  });

$app->post('/u/checkcampaing', function() use($app,$db){
    $st = $db->prepare("SELECT * FROM campaings");
    $st->execute();
    while ($row = $st->fetchObject()) {
      $date_now = strtotime(date("d-m-Y"));
      $date_start = strtotime($row->date_start);
      $date_end = strtotime($row->date_end);
      if ($date_start <= $date_now and $date_end >= $date_now) {
        $status = "Activa";
      } else if($date_start > $date_now) {
        $status = "En espera";
      } else if ($date_end < $date_now) {
        $status = "Finalizada";
      }
      $duration = $date_end - $date_start;
      $duration = intval($duration/60/60/24) + 1;
      $st = $db->prepare("UPDATE campaings SET status = ? WHERE id = $row->id");
      $campaing = $st->execute(array($status));
    }
  });

 ?>
