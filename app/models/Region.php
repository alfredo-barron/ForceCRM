<?php
class Region extends Elegant {
  protected $table = 'regions';
  protected $rules = array(
  );
  public $timestamps = false;
  //Puede tener un centro pokemon
  public function centers(){
    return $this->hasMany('Center');
  }
  //Puede tener un solo entrenador
  public function trainers(){
    return $this->hasMany('Trainer');
  }
  //Puede tener muchos pokemons
  public function pokemons(){
    return $this->hasMany('Pokemon');
  }

}
