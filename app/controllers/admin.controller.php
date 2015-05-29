<?php

$app->get('/u/0', $auth($app), function() use($app,$db){
  $data = array();
  $id = $_SESSION['id'];
  $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
  $st->setFetchMode(PDO::FETCH_OBJ);
  $st->execute(array($id));
  $data['user'] = $st->fetch();
  $st = $db->prepare("SELECT COUNT(*) as totales, COUNT(CASE status WHEN 'Actual' THEN 'Actual' END) as clientes FROM customers");
  $st->setFetchMode(PDO::FETCH_OBJ);
  $st->execute();
  $data['customers'] = $st->fetch();
  $st = $db->prepare("SELECT COUNT(*) as totales, COUNT(CASE status WHEN 'Activa' THEN 'Activa' END) as activas, COUNT(CASE status WHEN 'Finalizada' THEN 'Finalizada' END) as finalizadas, COUNT(CASE status WHEN 'En espera' THEN 'En espera' END) as en_espera FROM campaings");
  $st->setFetchMode(PDO::FETCH_OBJ);
  $st->execute();
  $data['campaings'] = $st->fetch();
  $st = $db->prepare("SELECT COUNT(*) as totales, COUNT(CASE status WHEN 'Archivado' THEN 'Archivado' END) as archivados, COUNT(CASE status WHEN 'Enviado' THEN 'Enviado' END) as enviados, COUNT(CASE status WHEN 'Fallido' THEN 'Fallido' END) as fallidos FROM emails");
  $st->setFetchMode(PDO::FETCH_OBJ);
  $st->execute();
  $data['emails'] = $st->fetch();
  $st = $db->prepare("SELECT COUNT(CASE gender WHEN 'H' THEN 'H' END) AS h, COUNT(CASE gender WHEN  'M' THEN 'M' END) AS m FROM customers;");
  $st->setFetchMode(PDO::FETCH_OBJ);
  $st->execute();
  $data['gender'] = $st->fetch();
  $st = $db->prepare("SELECT * FROM customers WHERE status = 'Potencial' OR status = 'Contacto'");
  $st->execute();
  $data['customerP'] = $st->rowCount();
  $st = $db->prepare("SELECT COUNT(CASE type WHEN 'A' THEN 'A' END) as a, COUNT(CASE type WHEN 'B' THEN 'B' END) AS b, COUNT(CASE type WHEN 'C' THEN 'C' END) as c FROM customers;");
  $st->setFetchMode(PDO::FETCH_OBJ);
  $st->execute();
  $data['type'] = $st->fetch();
  $st = $db->prepare("SELECT * FROM products ORDER BY date_created DESC");
  $st->execute();
  $data['products'] = $st->rowCount();
  $st = $db->prepare("SELECT * FROM products ORDER BY date_created DESC LIMIT 4");
  $st->execute();
  $data['productsDESC'] = $st->fetchAll();
  $st = $db->prepare("SELECT * FROM sales");
  $st->execute();
  $data['sales'] = $st->rowCount();
  $st = $db->prepare("SELECT COUNT(CASE times.month WHEN 1 THEN 1 END) as enero, COUNT(CASE times.month WHEN 2 THEN 2 END) as febrero, COUNT(CASE times.month WHEN 3 THEN 3 END) as marzo, COUNT(CASE times.month WHEN 4 THEN 4 END) as abril, COUNT(CASE times.month WHEN 5 THEN 5 END) as mayo FROM sales,times WHERE sales.id_time = times.id");
  $st->setFetchMode(PDO::FETCH_OBJ);
  $st->execute();
  $data['sales_month'] = $st->fetch();
  $st = $db->prepare("SELECT sales.id AS id, customers.name AS name, products.name AS product, categories.name AS category FROM sales,customers,products,times,categories WHERE sales.id_customer = customers.id AND sales.id_product = products.id AND products.category = categories.id AND sales.id_time = times.id ORDER BY sales.id DESC LIMIT 4");
  $st->setFetchMode(PDO::FETCH_OBJ);
  $st->execute();
  $data['sales_ultimate'] = $st->fetchAll();
  $st = $db->prepare("SELECT * FROM emails WHERE status = 'Archivado'");
  $st->execute();
  $data['emails.'] = $st->rowCount();
  if(getenv('DATABASE_URL') != false){
    $st = $db->prepare("SELECT COUNT(*) as total, COUNT(CASE WHEN (t1.age BETWEEN 1 AND 12) THEN 1 END) as ninez, COUNT(CASE WHEN (t1.age BETWEEN 13 AND 18) THEN 2 END) as jovenes, COUNT(CASE WHEN (t1.age BETWEEN 18 AND 35) THEN 3 END) as jovenes_adultos, COUNT(CASE WHEN (t1.age BETWEEN 35 AND 60) THEN 4 END) as adultos, COUNT(CASE WHEN (t1.age > 60) THEN 5 END) as vejez FROM(SELECT date_part('year',age( birthdate )) AS age FROM customers) t1");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute();
    $data['ages'] = $st->fetch();
  } else {
    $st = $db->prepare("SELECT COUNT(*) as total, COUNT(CASE WHEN (t1.age BETWEEN 1 AND 12) THEN 1 END) as ninez, COUNT(CASE WHEN (t1.age BETWEEN 13 AND 18) THEN 2 END) as jovenes, COUNT(CASE WHEN (t1.age BETWEEN 18 AND 35) THEN 3 END) as jovenes_adultos, COUNT(CASE WHEN (t1.age BETWEEN 35 AND 60) THEN 4 END) as adultos, COUNT(CASE WHEN (t1.age > 60) THEN 5 END) as vejez FROM(SELECT DATE_FORMAT(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(birthdate)), '%Y')+0 AS age FROM customers) t1");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute();
    $data['ages'] = $st->fetch();
  }
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
    $st = $db->prepare("SELECT DISTINCT products.name,products.img FROM sales,customers,products WHERE sales.id_customer = customers.id AND sales.id_product = products.id AND customers.id = ?");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id_c));
    $data['products'] = $st->fetchAll();
    $st = $db->prepare("SELECT DISTINCT categories.name FROM sales,customers,products,categories WHERE sales.id_customer = customers.id AND sales.id_product = products.id AND products.category = categories.id AND customers.id = ?");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id_c));
    $data['categories'] = $st->fetchAll();
    if(getenv('DATABASE_URL') != false){
      $st = $db->prepare("SELECT t1.id, t1.age FROM(SELECT date_part('year',age( birthdate )) AS age, id FROM customers) t1 WHERE id = ?");
      $st->setFetchMode(PDO::FETCH_OBJ);
      $st->execute(array($id_c));
      $data['age'] = $st->fetch();
    } else {
      $st = $db->prepare("SELECT t1.id, t1.age FROM(SELECT DATE_FORMAT(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(birthdate)), '%Y')+0 AS age, id FROM customers) t1 WHERE id = ?");
      $st->setFetchMode(PDO::FETCH_OBJ);
      $st->execute(array($id_c));
      $data['age'] = $st->fetch();
    }
    $app->render('customer.profile.twig',$data);
  })->name('profile-customer');

  $app->get('', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM customers");
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
    $st = $db->prepare("SELECT * FROM customers WHERE status = 'Potencial' OR status = 'Contacto'");
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

  $app->get('/segmentar', function() use($app,$db){
    $data = array();
    $abc = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    /*
    $st = $db->prepare("SELECT t1.id, t1.year, t1.name, t1.sales FROM(SELECT customers.id AS id, times.year AS year, customers.name, SUM(sales.sub_total) sales FROM sales,customers,times WHERE sales.id_customer = customers.id AND sales.id_time = times.id GROUP BY customers.id, times.year) t1 GROUP BY t1.year, t1.name, t1.sales ORDER BY t1.sales DESC");
    $st->execute();
    //$data['clasificacion'] = $st->fetchAll();
    $st1 = $db->prepare("SELECT SUM(sub_total) AS total FROM sales");
    $st1->setFetchMode(PDO::FETCH_OBJ);
    $st1->execute();
    $total = $st1->fetch();
    $total->total;
    $sum = 0;
    $acu = 0;
    while($row = $st->fetch(PDO::FETCH_OBJ)){
      $sum = $sum + $row->sales;
      $acu = $acu + round(($row->sales * 100)/$total->total,6);
      if ($acu <= 0 and $acu >= 20) {
        $type = "A";
      } else if($acu > 20 and $acu <= 50) {
        $type = "B";
      } else if($acu > 50) {
        $type = "C";
      }
      $abc[] = array('id' => $row->id,
                     'name' => $row->name,
                     'sales' => $row->sales,
                     'sales_porcentaje' => round(($row->sales * 100)/$total->total,6),
                     'sales_acumuladas' => $sum,
                     'total_sales' => $total->total,
                     'porcentaje_sales_acumuladas' => $acu,
                     'type' => $type);
      $customer = $db->prepare("UPDATE customers SET status = 'Actual', type = '$type' WHERE id = $row->id");
      $customer->execute();
    }
    $data['abc'] = $abc;*/
    $app->render('segmentar.twig',$data);
  })->name('segmentar');

  $app->get('/nuevo', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM customers WHERE status = 'Actual' AND type = 'A'");
    $st->execute();
    $data['customerA'] = $st->rowCount();
    $st = $db->prepare("SELECT * FROM customers WHERE status = 'Actual' AND type = 'B'");
    $st->execute();
    $data['customerB'] = $st->rowCount();
    $st = $db->prepare("SELECT * FROM customers WHERE status = 'Actual' AND type = 'C'");
    $st->execute();
    $data['customerC'] = $st->rowCount();
    $st = $db->prepare("SELECT * FROM customers WHERE status = 'Potencial' OR status = 'Contacto'");
    $st->execute();
    $data['customerP'] = $st->rowCount();
    $app->render('newmarket.twig',$data);
  })->name('new-market');

  $app->get('/nuevo/(:status)/(:type)', function($status,$type) use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    switch ($status) {
      case 'actual':
        $data['type'] = $type;
        $data['status'] = $status;
        $st = $db->prepare("SELECT COUNT(CASE gender WHEN 'H' THEN 'H' END) AS h, COUNT(CASE gender WHEN  'M' THEN 'M' END) AS m FROM customers WHERE status = 'Actual' AND type = '$type'");
        $st->execute();
        $data['gender'] = $st->fetch();
        $st = $db->prepare("SELECT COUNT(CASE school WHEN 1 THEN 1 END) as ninguna, COUNT(CASE school WHEN 2 THEN 2 END) as primaria, COUNT(CASE school WHEN 3 THEN 3 END) as secundaria, COUNT(CASE school WHEN 4 THEN 5 END) as preparatoria, COUNT(CASE school WHEN 5 THEN 5 END) as licenciatura, COUNT(CASE school WHEN 6 THEN 6 END) as maestria FROM customers WHERE status = 'Actual' AND type = '$type'");
        $st->execute();
        $data['schools'] = $st->fetch();
        $st = $db->prepare("SELECT COUNT(CASE job WHEN 1 THEN 1 END) as estudiante, COUNT(CASE job WHEN 2 THEN 2 END) as labores_hogar, COUNT(CASE job WHEN 3 THEN 3 END) as profesional_cuenta_ajena, COUNT(CASE job WHEN 4 THEN 4 END) as profesional_cuenta_propia, COUNT(CASE job WHEN 5 THEN 5 END) as desempleado, COUNT(CASE job WHEN 6 THEN 6 END) as directivo, COUNT(CASE job WHEN 7 THEN 7 END) as cargos_intermedios, COUNT(CASE job WHEN 8 THEN 8 END) as trabajadores_gobierno, COUNT(CASE job WHEN 9 THEN 9 END) as trabajadores_educacion, COUNT(CASE job WHEN 10 THEN 10 END) as trabajadores_salud, COUNT(CASE job WHEN 11 THEN 11 END) as fuerzas_armadas, COUNT(CASE job WHEN 12 THEN 12 END)  as otros FROM customers WHERE status = 'Actual' AND type = '$type'");
        $st->execute();
        $data['jobs'] = $st->fetch();
        $st = $db->prepare("SELECT COUNT(CASE status_civil WHEN 1 THEN 1 END) as soltero, COUNT(CASE status_civil WHEN 2 THEN 2 END) as union_libre, COUNT(CASE status_civil WHEN 3 THEN 3 END) as casado, COUNT(CASE status_civil WHEN 4 THEN 4 END) as divorciado, COUNT(CASE status_civil WHEN 5 THEN 5 END) as viudo FROM customers WHERE status = 'Actual' AND type = '$type'");
        $st->execute();
        $data['status_civil'] = $st->fetch();
        if(getenv('DATABASE_URL') != false){
          $st = $db->prepare("SELECT COUNT(*) as total, COUNT(CASE WHEN (t1.age BETWEEN 1 AND 12) THEN 1 END) as ninez, COUNT(CASE WHEN (t1.age BETWEEN 13 AND 18) THEN 2 END) as jovenes, COUNT(CASE WHEN (t1.age BETWEEN 18 AND 35) THEN 3 END) as jovenes_adultos, COUNT(CASE WHEN (t1.age BETWEEN 35 AND 60) THEN 4 END) as adultos, COUNT(CASE WHEN (t1.age > 60) THEN 5 END) as vejez FROM(SELECT date_part('year',age( birthdate )) AS age, status, type FROM customers) t1 WHERE status = 'Actual' AND type = '$type'");
          $st->setFetchMode(PDO::FETCH_OBJ);
          $st->execute();
          $data['ages'] = $st->fetch();
        } else {
          $st = $db->prepare("SELECT COUNT(*) as total, COUNT(CASE WHEN (t1.age BETWEEN 1 AND 12) THEN 1 END) as ninez, COUNT(CASE WHEN (t1.age BETWEEN 13 AND 18) THEN 2 END) as jovenes, COUNT(CASE WHEN (t1.age BETWEEN 18 AND 35) THEN 3 END) as jovenes_adultos, COUNT(CASE WHEN (t1.age BETWEEN 35 AND 60) THEN 4 END) as adultos, COUNT(CASE WHEN (t1.age > 60) THEN 5 END) as vejez FROM(SELECT DATE_FORMAT(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(birthdate)), '%Y')+0 AS age, status, type FROM customers) t1 WHERE status = 'Actual' AND type = '$type'");
          $st->setFetchMode(PDO::FETCH_OBJ);
          $st->execute();
          $data['ages'] = $st->fetch();
        }
        break;
      case 'potencial':
        $data['type'] = "P";
        $data['status'] = $status;
        $st = $db->prepare("SELECT COUNT(CASE gender WHEN 'H' THEN 'H' END) AS h, COUNT(CASE gender WHEN  'M' THEN 'M' END) AS m FROM customers WHERE status = 'Potencial' OR status = 'Contacto'");
        $st->execute();
        $data['gender'] = $st->fetch();
        $st = $db->prepare("SELECT COUNT(CASE school WHEN 1 THEN 1 END) as ninguna, COUNT(CASE school WHEN 2 THEN 2 END) as primaria, COUNT(CASE school WHEN 3 THEN 3 END) as secundaria, COUNT(CASE school WHEN 4 THEN 5 END) as preparatoria, COUNT(CASE school WHEN 5 THEN 5 END) as licenciatura, COUNT(CASE school WHEN 6 THEN 6 END) as maestria FROM customers WHERE status = 'Potencial' OR status = 'Contacto'");
        $st->execute();
        $data['schools'] = $st->fetch();
        $st = $db->prepare("SELECT COUNT(CASE job WHEN 1 THEN 1 END) as estudiante, COUNT(CASE job WHEN 2 THEN 2 END) as labores_hogar, COUNT(CASE job WHEN 3 THEN 3 END) as profesional_cuenta_ajena, COUNT(CASE job WHEN 4 THEN 4 END) as profesional_cuenta_propia, COUNT(CASE job WHEN 5 THEN 5 END) as desempleado, COUNT(CASE job WHEN 6 THEN 6 END) as directivo, COUNT(CASE job WHEN 7 THEN 7 END) as cargos_intermedios, COUNT(CASE job WHEN 8 THEN 8 END) as trabajadores_gobierno, COUNT(CASE job WHEN 9 THEN 9 END) as trabajadores_educacion, COUNT(CASE job WHEN 10 THEN 10 END) as trabajadores_salud, COUNT(CASE job WHEN 11 THEN 11 END) as fuerzas_armadas, COUNT(CASE job WHEN 12 THEN 12 END)  as otros FROM customers WHERE status = 'Potencial' OR status = 'Contacto'");
        $st->execute();
        $data['jobs'] = $st->fetch();
        $st = $db->prepare("SELECT COUNT(CASE status_civil WHEN 1 THEN 1 END) as soltero, COUNT(CASE status_civil WHEN 2 THEN 2 END) as union_libre, COUNT(CASE status_civil WHEN 3 THEN 3 END) as casado, COUNT(CASE status_civil WHEN 4 THEN 4 END) as divorciado, COUNT(CASE status_civil WHEN 5 THEN 5 END) as viudo FROM customers WHERE status = 'Potencial' OR status = 'Contacto'");
        $st->execute();
        $data['status_civil'] = $st->fetch();
        if(getenv('DATABASE_URL') != false){
          $st = $db->prepare("SELECT COUNT(*) as total, COUNT(CASE WHEN (t1.age BETWEEN 1 AND 12) THEN 1 END) as ninez, COUNT(CASE WHEN (t1.age BETWEEN 13 AND 18) THEN 2 END) as jovenes, COUNT(CASE WHEN (t1.age BETWEEN 18 AND 35) THEN 3 END) as jovenes_adultos, COUNT(CASE WHEN (t1.age BETWEEN 35 AND 60) THEN 4 END) as adultos, COUNT(CASE WHEN (t1.age > 60) THEN 5 END) as vejez FROM(SELECT date_part('year',age( birthdate )) AS age, status FROM customers) t1 WHERE status = 'Potencial' OR status = 'Contacto'");
          $st->execute();
          $data['ages'] = $st->fetch();
        } else {
          $st = $db->prepare("SELECT COUNT(*) as total, COUNT(CASE WHEN (t1.age BETWEEN 1 AND 12) THEN 1 END) as ninez, COUNT(CASE WHEN (t1.age BETWEEN 13 AND 18) THEN 2 END) as jovenes, COUNT(CASE WHEN (t1.age BETWEEN 18 AND 35) THEN 3 END) as jovenes_adultos, COUNT(CASE WHEN (t1.age BETWEEN 35 AND 60) THEN 4 END) as adultos, COUNT(CASE WHEN (t1.age > 60) THEN 5 END) as vejez FROM(SELECT DATE_FORMAT(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(birthdate)), '%Y')+0 AS age, status FROM customers) t1 WHERE status = 'Potencial' OR status = 'Contacto'");
          $st->execute();
          $data['ages'] = $st->fetch();
        }
        break;
    }
    $app->render('market.twig',$data);
  })->name('market');

  $app->get('', function() use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $st = $db->prepare("SELECT id, name, description, COUNT(team) AS total, date_created FROM(SELECT teams.id, teams.name, teams.description, customer_team.team_id AS team, teams.date_created FROM teams,customer_team WHERE customer_team.team_id = teams.id) t1 GROUP BY id");
    $st->execute();
    $data['markets'] = $st->fetchAll();
    $app->render('markets.twig',$data);
  })->name('markets');

  $app->post('/nuevo/reportes', function() use($app,$db) {
    $st = $db->prepare("SELECT * FROM customers WHERE status = 'Potencial' OR status = 'Contacto' AND gender = 'H'");
    $st->execute();
    $h = $st->rowCount();
  })->name('reports');

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
    $st = $db->prepare("SELECT * FROM teams ORDER BY date_created ASC");
    $st->execute();
    $data['markets'] = $st->fetchAll();
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
            if (isset($post->market_id)) {
              $st = $db->prepare("SELECT * FROM campaings ORDER BY date_created DESC LIMIT 1");
              $st->setFetchMode(PDO::FETCH_OBJ);
              $st->execute();
              $data['campaing'] = $st->fetch();
              $st = $db->prepare("INSERT INTO campaing_team (campaing_id,teams_id) VALUES(?,?)");
              $team = $st->execute(array($data['campaing']->id,$post->market_id));
            }
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
    $st = $db->prepare("UPDATE campaings SET name = ?, date_start = ?, date_end = ?,product_id = ?,status = ?, target = ?, description = ?, duration = ?, color = ? WHERE id = $id");
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

  $app->get('/vista/(:id_e)', function($id_e) use($app,$db) {
    $data = array();
    $id = $_SESSION['id'];
    $st = $db->prepare("SELECT users.id, users.name, users.last_name, users.email, users.gender, roles.name AS rol FROM users,roles WHERE users.id = ? AND users.rol = roles.id");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($id));
    $data['user'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM emails WHERE id = $id_e");
    $st->execute();
    $data['email'] = $st->fetch();
    $app->render('email.vista.twig',$data);
  })->name('vista-email');

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
    $id = (isset($post->id) and !empty($post->id)) ? $post->id : 0;
    if($id != 0){
      echo "error";
    }else{
      $created_by = $_SESSION['id'];
      $campaing_id = $post->campaing_id;
      $datetime = $post->date." ".$post->hour;
      $date_send =  new DateTime($datetime);
      $date_send = date_format($date_send,'Y-m-d H:i');
      $subject = $post->subject;
      $content = $post->content;
      $status = "Archivado";
      if($datetime == "" || $subject == "" || $content == "" || $campaing_id == 0) {
        echo "vacio";
      } else {
        $st = $db->prepare("INSERT INTO emails (created_by,campaing_id,date_send,subject,content,status) VALUES (?,?,?,?,?,?)");
        $email = $st->execute(array($created_by,$campaing_id,$date_send,$subject,$content,$status));
      if ($email) {
            echo "exito";
          } else {
            echo "error";
          }
      }
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
    $st = $db->prepare("SELECT * FROM categories");
    $st->execute();
    $data['categories'] = $st->fetchAll();
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
      $features = $post->features;
      $date = date('Y-m-d');
      if($name == "" || $market == "" || $price == "" || $description == "" || $quantity == "" || $stock == "" || $category == 0 ) {
        echo "vacio";
      } else {
        $st = $db->prepare("INSERT INTO products(created_by,name,market,model,price,category,description,quantity,stock,features,date_created) VALUES (?,?,?,?,?,?,?,?,?,?,?)");
        $product = $st->execute(array($created_by,$name,$market,$model,$price,$category,$description,$quantity,$stock,$features,$date));
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
    $st = $db->prepare("SELECT * FROM categories WHERE id = ?");
    $st->setFetchMode(PDO::FETCH_OBJ);
    $st->execute(array($data['product']->category));
    $data['category'] = $st->fetch();
    $st = $db->prepare("SELECT * FROM categories");
    $st->execute();
    $data['categories'] = $st->fetchAll();
    $app->render('newproduct.twig',$data);
  })->name('edit-product');

  $app->post('/actualizar/editar', function() use($app,$db){
    $post = (object) $app->request()->post();
    $id = (isset($post->id) and !empty($post->id)) ? $post->id : 0;
    $name = $post->name;
    $market = $post->market;
    $model = $post->model;
    $price = $post->price;
    $category = $post->category;
    $description = $post->description;
    $quantity = $post->quantity;
    $stock = $post->stock;
    $features = $post->features;
    $st = $db->prepare("UPDATE products SET name = ?, market = ?, model = ?, price = ?, category = ?, description = ?, quantity = ?, stock = ?, features = ? WHERE id = $id");
    $product = $st->execute(array($name,$market,$model,$price,$category,$description,$quantity,$stock,$features));
    if ($product) {
      echo "exito";
    } else {
      echo "error";
    }
  })->name('product-edit-post');

});

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

$app->post('/u/envioemails', function() use($app,$db){
  $st = $db->prepare("SELECT * FROM emails");
  $st->execute();
  while ($row = $st->fetch(PDO::FETCH_OBJ)) {
    $date_now = strtotime(date("d-m-Y"));
    $date_start = strtotime($row->date_send);
    if ($date_start == $date_now) {

    }
    $campaing = $db->prepare("UPDATE campaings SET status = '$status' WHERE id = $row->id");
    $campaing->execute();
  }
});

 ?>
