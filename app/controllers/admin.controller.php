<?php

$app->get('/u/0', $auth($app), function() use($app,$db){
  $data = array();
  $id = $_SESSION['id'];
  $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
  $st->setFetchMode(PDO::FETCH_OBJ);
  $st->execute(array($id));
  $data['user'] = $st->fetch();
  $st = $db->prepare("SELECT * FROM customers WHERE status = 'Contacto'");
  $st->execute();
  $data['count_con'] = $st->rowCount();
  $st = $db->prepare("SELECT * FROM customers WHERE status = 'Actual'");
  $st->execute();
  $data['count_cus'] = $st->rowCount();
  $st = $db->prepare("SELECT * FROM campaings");
  $st->execute();
  $data['count_cam'] = $st->rowCount();
  $st = $db->prepare("SELECT * FROM customers WHERE gender = 'H'");
  $st->execute();
  $data['men'] = $st->rowCount();
  $st = $db->prepare("SELECT * FROM customers WHERE gender = 'M'");
  $st->execute();
  $data['women'] = $st->rowCount();
  $st = $db->prepare("SELECT * FROM customers WHERE status = 'Potencial'");
  $st->execute();
  $data['customerP'] = $st->rowCount();
  $st = $db->prepare("SELECT * FROM customers WHERE type = 'A'");
  $st->execute();
  $data['customerA'] = $st->rowCount();
  $st = $db->prepare("SELECT * FROM customers WHERE type = 'B'");
  $st->execute();
  $data['customerB'] = $st->rowCount();
  $st = $db->prepare("SELECT * FROM customers WHERE type = 'C'");
  $st->execute();
  $data['customerC'] = $st->rowCount();
  $st = $db->prepare("SELECT * FROM products ORDER BY date_created ASC");
  $st->execute();
  $data['productsASC'] = $st->fetchAll();
  $app->render('index.twig',$data);
})->name('dashboard');

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
    $st = $db->prepare("SELECT * FROM postcodes");
    $st->execute();
    $data['postcodes'] = $st->fetchAll();
    $app->render('newcustomer.twig',$data);
  })->name('new-customer');

  $app->post('/nuevo', function() use($app,$db){
    $post = (object) $app->request()->post();
    $id = (isset($post->id) and !empty($post->id)) ? $post->id : 0;
    if($id != 0){
      echo "error";
    }else{
      $name = $post->name;
      $last_name = $post->last_name;
      $birthdate = $post->birthdate;
      $gender = $post->gender;
      $email = $post->email;
      $telephone = str_replace(' ', '', $post->telephone);
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
      $status = "Contacto";
      $date = date('Y-m-d');
      if($name == "" || $last_name == "" || $birthdate == "" || $email == "" || $telephone == "" || $postcode == 0) {
        echo "vacio";
      } else {
          $st = $db->prepare("SELECT * FROM customers WHERE email = ?");
          $st->setFetchMode(PDO::FETCH_OBJ);
          $st->execute(array($email));
          if ($user = $st->fetch()) {
            echo "existe";
          } else {
            $st = $db->prepare("INSERT INTO customers (name,last_name,birthdate,gender,email,telephone,street,number,postcode,place,city,entity,job,school,status_civil,sons,status,date_created) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            if ($customer = $st->execute(array($name,$last_name,$birthdate,$gender,$email,$telephone,$street,$number,$postcode,$place,$city,$entity,$job,$school,$status_civil,$sons,$status,$date))) {
              echo "exito";
            } else {
              echo "error";
            }
         }
      }
    }
  })->name('customer-post');

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

  $app->post('/actualizar/editar', function() use($app,$db){
    $post = (object) $app->request()->post();
    $id = (isset($post->id) and !empty($post->id)) ? $post->id : 0;
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
    if ($customer) {
      echo "exito";
    } else {
      echo "error";
    }
  })->name('customer-edit-post');

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
    $st = $db->prepare("SELECT * FROM customers WHERE status = 'Contacto'");
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

  $app->get('', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $app->render('markets.twig',$data);
  })->name('markets');

});

$app->group('/u/0/campanas', $auth($app), function() use($app,$db){

  $app->get('/nueva', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM products WHERE status = true ORDER BY date_created ASC");
    $st->execute();
    $data['products'] = $st->fetchAll();
    $app->render('newcampaing.twig',$data);
  })->name('new-campaing');

  $app->post('/nueva', function() use($app,$db) {
    $post = (object) $app->request()->post();
    $id = (isset($post->id) and !empty($post->id)) ? $post->id : 0;
    if($id != 0){
      echo "error";
    }else{
      $created_by = $_SESSION['id'];
      $product_id = $post->product_id;
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
      $date_created = date('Y-m-d H:i:s');
      $color = $post->color;
      if($name == "" || $target == "" || $description == "" || $color == "" || $product_id == 0) {
        echo "vacio";
      } else {
        $st = $db->prepare("INSERT INTO campaings (created_by,name,date_start,date_end,product_id,status,target,description,duration,date_created,color) VALUES (?,?,?,?,?,?,?,?,?,?,?)");
        $campaing = $st->execute(array($created_by,$name,$start,$end,$product_id,$status,$target,$description,$duration,$date_created,$color));
        if ($campaing) {
            echo "exito";
          } else {
            echo "error";
          }
      }
    }
  })->name('campaing-post');

  $app->get('/actualizar(/:id_c)', function($id_c) use($app,$db) {
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM campaings WHERE id = ?");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id_c));
    $data['campaing'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM products WHERE id = ?");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($data['campaing']->product_id));
    $data['product'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM products");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute();
    $data['products'] = $st->fetchAll();
    $app->render('newcampaing.twig',$data);
  })->name('edit-campaing');

  $app->post('/actualizar/editar', function() use($app,$db) {
    $post = (object) $app->request()->post();
    $id = (isset($post->id) and !empty($post->id)) ? $post->id : 0;
    $created_by = $_SESSION['id'];
    $product_id = $post->product_id;
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
    $color = $post->color;
    $st = $db->prepare("UPDATE campaings SET name = ?,date_start = ?, date_end = ?,product_id = ?,status = ?, target = ?, description = ?, duration = ?, color = ? WHERE id = $id");
    $campaing = $st->execute(array($name,$start,$end,$product_id,$status,$target,$description,$duration,$color));
    if ($campaing) {
        echo "exito";
      } else {
        echo "error";
      }
  })->name('campaing-edit-post');

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
  })->name('campaings');

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
    $st = $db->prepare("SELECT emails.id, emails.subject, emails.date_send, emails.date_created, campaings.name AS campaing FROM emails,campaings WHERE emails.campaing_id = campaings.id ORDER BY emails.date_created DESC");
    $st->execute();
    $data['emails'] = $st->fetchAll();
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

$app->group('/u/0/productos', $auth($app), function() use($app,$db){

  $app->get('', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM products");
    $st->execute();
    $data['products'] = $st->fetchAll();
    $app->render('products.twig',$data);
  })->name('products');

  $app->get('/nuevo', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $app->render('newproduct.twig',$data);
  })->name('new-product');

  $app->post('/nuevo', function() use($app,$db){
    $post = (object) $app->request()->post();
    $id = (isset($post->id) and !empty($post->id)) ? $post->id : 0;
    if($id != 0){
      echo "error";
    }else{
      $created_by = $_SESSION['id'];
      $name = $post->name;
      $market = $post->market;
      $model = $post->model;
      $price = $post->price;
      $category = $post->category;
      $description = $post->description;
      $quantity = $post->quantity;
      $stock = $post->stock;
      $date = date('Y-m-d');
      if($name == "" || $market == "" || $price == "" || $description == "" || $quantity == "" || $stock == "" || $category == 0 ) {
        echo "vacio";
      } else {
        $st = $db->prepare("INSERT INTO products(created_by,name,market,model,price,category,description,quantity,stock,date_created) VALUES (?,?,?,?,?,?,?,?,?,?)");
        $product = $st->execute(array($created_by,$name,$market,$model,$price,$category,$description,$quantity,$stock,$date));
          if ($product) {
            echo "exito";
          } else {
            echo "error";
          }
        }
      }
  })->name('product-post');

  $app->get('/actualizar(/:id_p)', function($id_p) use($app,$db) {
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM products WHERE id = ?");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id_p));
    $data['product'] = $st->fetch();
    $app->render('newproduct.twig',$data);
  })->name('edit-product');

});

$app->post('/actualizar/editar', function() use($app,$db){
    $post = (object) $app->request()->post();
    $id = (isset($post->id) and !empty($post->id)) ? $post->id : 0;
    if($id != 0){
      echo "error";
    }else{
      $created_by = $_SESSION['id'];
      $name = $post->name;
      $market = $post->market;
      $model = $post->model;
      $price = $post->price;
      $category = $post->category;
      $description = $post->description;
      $quantity = $post->quantity;
      $stock = $post->stock;
      $date = date('Y-m-d');
      if($name == "" || $market == "" || $price == "" || $description == "" || $quantity == "" || $stock == "" || $category == 0 ) {
        echo "vacio";
      } else {
        $st = $db->prepare("INSERT INTO products(created_by,name,market,model,price,category,description,quantity,stock,date_created) VALUES (?,?,?,?,?,?,?,?,?,?)");
        $product = $st->execute(array($created_by,$name,$market,$model,$price,$category,$description,$quantity,$stock,$date));
          if ($product) {
            echo "exito";
          } else {
            echo "error";
          }
        }
      }
  })->name('product-edit-post');

$app->group('/u/0/personal', $auth($app), function() use($app,$db){

  $app->get('', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.rol = roles.id");
    $st->execute();
    $data['users'] = $st->fetchAll();
    $st = $db->prepare("SELECT * FROM roles WHERE id <> 1");
    $st->execute();
    $data['roles'] = $st->fetchAll();
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

$app->get('/campaings', function() use($app,$db){
    $st = $db->prepare("SELECT name AS title, date_start AS start, date_end AS end, color, target AS description FROM campaings");
    $st->execute();
    $campaings = $st->fetchAll();
    echo json_encode($campaings);
  });

$app->post('/u/checkcampaing', function() use($app,$db){
    $st = $db->prepare("SELECT * FROM campaings");
    $st->execute();
    while ($row = $st->fetch(PDO::FETCH_OBJ)) {
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
      $campaing = $db->prepare("UPDATE campaings SET status = '$status' WHERE id = $row->id");
      $campaing->execute();
    }
  });


 ?>
