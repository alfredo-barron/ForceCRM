<?php

$app->group('/u/0/clientes', $auth($app), function() use($app){

  $app->get('/nuevo', function() use($app) {
    $data = array();
    $id = $_SESSION['id'];
    $data['user'] = User::where('id',$id)->first();
    $data['role'] = Role::where('id',$data['user']->rol)->first();
    $data['postcodes'] = Postcode::all();
    $data['jobs'] = Job::all();
    $data['schools'] = School::all();
    $data['status_civil'] = Status_Civil::all();
    $app->render('newcustomer.twig',$data);
  })->name('new-customer');

  $app->post('/nuevo', function() use($app){
    $post = (object) $app->request()->post();
    $customer = new Customer();
    $customer->name = $post->name;
    $customer->last_name = $post->last_name;
    $customer->birthday = $post->birthday;
    $customer->gender = $post->gender;
    $customer->email = $post->email;
    $customer->telephone = trim($post->telephone);
    $customer->street = $post->street;
    $customer->number = $post->number;
    $customer->postcode = $post->postcode;
    $customer->place = $post->place;
    $customer->city = $post->city;
    $customer->entity = $post->entity;
    $customer->job = $post->job;
    $customer->school = $post->school;
    $customer->status_civil = $post->status_civil;
    $customer->sons = $post->sons;
    $customer->save();
    $success = "Cliente dado de alta";
    $app->flash('success', $success);
    $app->redirect($app->urlFor('new-customer'));
  })->name('customer-post');

  $app->get('', function() use($app) {
    $data = array();
    $id = $_SESSION['id'];
    $data['user'] = User::where('id',$id)->first();
    $data['role'] = Role::where('id',$data['user']->rol)->first();
    $data['customers'] = Customer::where('status','<>','Potencial')->where('status','<>','Actual')->get();
    $app->render('customers.twig',$data);
  })->name('customers');

  $app->get('/potenciales', function() use($app) {
    $data = array();
    $id = $_SESSION['id'];
    $data['user'] = User::where('id',$id)->first();
    $data['role'] = Role::where('id',$data['user']->rol)->first();
    $data['customers'] = Customer::where('status','Potencial')->get();
    $app->render('customer.potencial.twig',$data);
  })->name('customer-potencial');

  $app->get('/actuales', function() use($app) {
    $data = array();
    $id = $_SESSION['id'];
    $data['user'] = User::where('id',$id)->first();
    $data['role'] = Role::where('id',$data['user']->rol)->first();
    $data['customers'] = Customer::where('status','Actual')->get();
    $app->render('customer.actual.twig',$data);
  })->name('customer-actual');

});

$app->group('/u/0/mercados', $auth($app), function() use($app){

  $app->get('/nuevo', function() use($app) {
    $data = array();
    $id = $_SESSION['id'];
    $data['user'] = User::where('id',$id)->first();
    $data['role'] = Role::where('id',$data['user']->rol)->first();
    $app->render('newmarket.twig',$data);
  })->name('new-market');

});

$app->group('/u/0/campanas', $auth($app), function() use($app){

  $app->get('/nueva', function() use($app) {
    $data = array();
    $id = $_SESSION['id'];
    $data['user'] = User::where('id',$id)->first();
    $data['role'] = Role::where('id',$data['user']->rol)->first();
    $app->render('newcampaing.twig',$data);
  })->name('new-campaing');

  $app->post('/nueva', function() use($app) {
    $post = (object) $app->request()->post();
    $campaing = new Campaing();
    $campaing->created_by = $_SESSION['id'];
    $campaing->name = $post->name;
    list($date_start, $date_end) = explode("-", $post->reservation);
    $campaing->date_start = $date_start;
    $campaing->date_end = $date_end;
    $date_now = strtotime(date("d-m-Y"));
    $date_start = strtotime($date_start);
    $date_end = strtotime($date_end);
    if ($date_start <= $date_now and $date_end >= $date_now) {
      $campaing->status = "Activa";
    } else if($date_start > $date_now) {
      $campaing->status = "En espera";
    } else if ($date_end < $date_now) {
      $campaing->status = "Finalizada";
    }
    $campaing->target = $post->target;
    $campaing->description = $post->description;
    $duration = $date_end - $date_start;
    $campaing->duration = intval($duration/60/60/24) + 1;
    $campaing->date_created = date('Y-m-d');
    $campaing->save();
    $success = "Campaña creada";
    $app->flash('success', $success);
    $app->redirect($app->urlFor('new-campaing'));
  })->name('campaing-post');

  $app->get('/activas', function() use($app) {
    $data = array();
    $id = $_SESSION['id'];
    $data['user'] = User::where('id',$id)->first();
    $data['role'] = Role::where('id',$data['user']->rol)->first();
    $data['campaings'] = Campaing::where('status','Activa')->get();
    $app->render('campaings.activas.twig',$data);
  })->name('campaings-activas');

  $app->get('/espera', function() use($app) {
    $data = array();
    $id = $_SESSION['id'];
    $data['user'] = User::where('id',$id)->first();
    $data['role'] = Role::where('id',$data['user']->rol)->first();
    $data['campaings'] = Campaing::where('status','En espera')->get();
    $app->render('campaings.esperas.twig',$data);
  })->name('campaings-esperas');

  $app->get('/terminadas', function() use($app) {
    $data = array();
    $id = $_SESSION['id'];
    $data['user'] = User::where('id',$id)->first();
    $data['role'] = Role::where('id',$data['user']->rol)->first();
    $data['campaings'] = Campaing::where('status','Finalizada')->get();
    $app->render('campaings.finalizadas.twig',$data);
  })->name('campaings-finalizadas');

});

$app->group('/u/0/email', $auth($app), function() use($app){

  $app->get('', function() use($app) {
    $data = array();
    $id = $_SESSION['id'];
    $data['user'] = User::where('id',$id)->first();
    $data['role'] = Role::where('id',$data['user']->rol)->first();
    $app->render('email.twig',$data);
  })->name('email');

  $app->get('/nuevo', function() use($app) {
    $data = array();
    $id = $_SESSION['id'];
    $data['user'] = User::where('id',$id)->first();
    $data['role'] = Role::where('id',$data['user']->rol)->first();
    $app->render('email.redactar.twig',$data);
  })->name('new-email');

});

$app->group('/u/0/personal', $auth($app), function() use($app){

  $app->get('', function() use($app) {
    $data = array();
    $id = $_SESSION['id'];
    $data['user'] = User::where('id',$id)->first();
    $data['role'] = Role::where('id',$data['user']->rol)->first();
    $data['users'] = User::with('rol')->get();
    $app->render('personal.twig',$data);
  })->name('personal');

});

$app->get('/postcode.json/:id', function($id) use($app){
    $postcode = Postcode::where('id',$id)->first();
    echo $postcode->toJson();
  });

 ?>
