<?php
class Type extends Elegant {
  protected $table = 'types';
  protected $rules = array(
  );
  public $timestamps = false;

  public function pokemons() {
    return $this->belongsToMany('Pokemon');
  }

}
