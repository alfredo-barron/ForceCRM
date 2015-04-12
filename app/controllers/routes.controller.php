<?php

$app->get('/inicio/:id', function($id) use($app){
   $pokeball = Pokeball::where('trainer_id',$id)->get();
   $trainer = Trainer::where('id',$id)->first();
   foreach ($pokeball as $pk) {
    $notices[] =  array(
          'id' => $pk->id,
          'specie' => $pk->specie,
          'image' => $pk->url,
          'alias' => $pk->alias,
          'status' => $pk->status,
          'trainer' => $trainer->username,
          );
      $i++;
   }

   echo json_encode($notices);

});

$app->put("/batalla/:id", function($id) use($app){
  $pokeball = Pokeball::where('id',$id)->first();
  $pokeball->status_id = rand(2,8);
  $pokeball->level = $pokeball->level + 1;
  $status = Status::where('id',$pokeball->status_id)->first();
  $pokeball->status = $status->name;
  $pokeball->save();
});

$app->get('/regiones(/:id)', function($id = null) use($app){
  if($id == null){
    $region = Region::all();
    echo $region->toJson();
  }else{
    $region = Region::where('id',$id)->first();
    echo $region->toJson();
  }
});

$app->get('/centros(/:id)', function($id = null) use($app){
  if($id == null){
    $centro = Center::with('region_id')->get();
    echo $centro->toJson();
  }else{
    $centro = Center::with('region_id')->where('id',$id)->first();
    echo $centro->toJson();
  }
});

$app->get('/region(/:id)/centros', function($id = null) use($app){
  $centro = Region::with('centers')->where('id',$id)->first();
  echo $centro->toJson();
});

$app->get('/tipos(/:id)', function($id = null) use($app){
  if($id == null){
    $tipo = Pokemon::with('types')->get();
    echo $tipo->toJson();
  }else{
    $tipo = Pokemon::with('types')->where('id',$id)->first();
    echo $tipo->toJson();
  }
});

$app->get('/habilidades(/:id)', function($id = null) use($app){
  if($id == null){
    $habilidad = Power::all();
    echo $habilidad->toJson();
  }else{
    $habilidad = Power::where('id',$id)->first();
    echo $habilidad->toJson();
  }
});

$app->get('/status(/:id)', function($id = null) use($app){
  if($id == null){
    $status = Status::all();
    echo $status->toJson();
  }else{
    $status = Status::where('id',$id)->first();
    echo $status->toJson();
  }
});

$app->get('/pokemon(/:id)', function($id = null) use($app){
  if($id == null){
    $pokemon = Pokemon::all();
    echo $pokemon->toJson();
  }else{
    $pokemon = Pokemon::with('types','powers')->where('id',$id)->first();
    echo $pokemon->toJson();
  }
});

$app->get('/evoluciones(/:id)', function($id = null) use($app){
  if($id == null){
    $pokemon = Evolution::with('pokemon_id','pokemon_id_e')->get();
    echo $pokemon->toJson();
  }else{
    $pokemon = Evolution::with('pokemon_id','pokemon_id_e')->where('id',$id)->first();
    echo $pokemon->toJson();
  }
});

$app->get('/entrenadores(/:id)', function($id = null) use($app){
  if($id == null){
    $trainer = Trainer::with('region_id','region_id_actual')->get();
    echo $trainer->toJson();
  }else{
    $trainer = Trainer::with('region_id','region_id_actual')->where('id',$id)->first();
    echo $trainer->toJson();
  }
});

$app->post('/entrenadores', function() use($app) {
  $post = (object) $app->request->post();
  $trainer = new Trainer();
  $trainer->name = $post->name;
  $trainer->last_name = $post->last_name;
  $trainer->image = $post->image;
  $trainer->username = $post->username;
  $trainer->password = $post->password;
  $trainer->birthday = $post->birthday;
  $trainer->region_id = $post->region_id;
  $trainer->gender = $post->gender;
  $trainer->leader = $post->leader;
  $trainer->region_id_actual = $post->region_id_actual;
  if($trainer->save()) {
     $trainer = Trainer::with('region_id','region_id_actual')->where('id',$trainer->id)->first();
   }
      echo $trainer->toJson();
});

$app->put('/entrenadores/:id', function($id) use($app){
  $post = (object) $app->request->post();
  $trainer = Trainer::with('region_id','region_id_actual')->where('id',$id)->first();
  $trainer->name = $post->name;
  $trainer->last_name = $post->last_name;
  $trainer->username = $post->username;
  $trainer->password = $post->password;
  if($trainer->save()) {
     $trainer = Trainer::with('region_id','region_id_actual')->where('id',$trainer->id)->first();
   }
      echo $trainer->toJson();
});

$app->get('/pokebolas(/:id)', function($id = null) use($app){
  if($id == null){
    $pokebola = Pokeball::all();
    echo $pokebola->toJson();
  }else{
    $pokebola = Pokeball::where('trainer_id',$id)->get();
    echo $pokebola->toJson();
  }
});

$app->post('/pokebola', function() use($app){
  $post = (object) $app->request->post();

  $pokeball = new Pokeball();
  $pokeball->trainer_id = $post->trainer_id;
  $pokeball->pokemon_id = $post->pokemon_id;

  $gender = rand(1,2);
  if($gender == 1) {
    $genero = "Masculino";
  } else {
    $genero = "Femenino";
  }
  $pokeball->gender = $genero;
  $pokeball->level = 1;

  $id = $post->pokemon_id;
  $pokemon = Pokemon::where('id',$id)->first();
  $pokeball->url = $pokemon->url;
  $pokeball->alias = $pokemon->species;
  $pokeball->specie = $pokemon->species;
  $pokeball->image = $pokemon->image;
  $pokeball->hit_points = $pokemon->hit_points;
  $pokeball->attack = $pokemon->attack;
  $pokeball->defense = $pokemon->defense;
  $pokeball->speed = $pokemon->speed;
  $pokeball->evasion = $pokemon->evasion;
  $pokeball->accuracy = $pokemon->accuracy;

  $pokeball->status_id = rand(1,8);
  $status = Status::where('id',$pokeball->status_id)->first();
  $pokeball->status = $status->name;

  if($pokeball->save()) {
    $pokeball = Pokeball::where('id',$pokeball->id)->first();
  }

  echo $pokeball->toJson();
});

$app->delete('/pokebola/:id', function($id) use($app){
  $pokeball = Pokeball::where('id',$id)->first();
  $pokeball->delete();
});

$app->get('/regeneradores(/:id)', function($id = null) use($app){
  if($id == null){
    $regenerador = Regenerator::with('center_id')->get();
    echo $regenerador->toJson();
  }else{
    $regenerador = Regenerator::with('center_id')->where('id',$id)->first();
    echo $regenerador->toJson();
  }
});

$app->get('/registros/:id', function($id) use($app){
  $register = Register::where('trainer_id',$id)->get();
  echo $register->toJson();
});

$app->post('/registro', function() use($app){
  $post = (object) $app->request->post();

  $register = new Register();
  $register->date_start = Date('Y-m-d');
  $register->regenerator_id = 1;
  $register->pokeball_id = $post->pokeball_id;
  $id = $post->pokeball_id;

  $pokeball = Pokeball::where('id',$id)->first();
  $register->hit_points = $pokeball->hit_points;
  $register->specie = $pokeball->specie;

  $register->trainer_id = $post->trainer_id;

  if($register->save()) {
    $register = Register::where('id',$register->id)->first();
  }

  echo $register->toJson();
});

$app->delete('/registros/:id', function($id) use($app){
  $pokeball = Pokeball::where('id',$id)->first();
  $pokeball->status = "Normal";
  $pokeball->status_id = 1;
  $pokeball->level = $pokeball->level + 1;
  $pokeball->save();
  $register = Register::where('pokeball_id',$id)->first();
  $register->delete();
});

$app->get('/habitaciones(/:id)', function($id = null) use($app){
  if($id == null){
    $habitacion = Room::with('center_id')->get();
    echo $habitacion->toJson();
  }else{
    $habitacion = Room::with('center_id')->where('id',$id)->first();
    echo $habitacion->toJson();
  }
});

