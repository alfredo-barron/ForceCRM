<?php
class Evolution extends Elegant {
  protected $table = 'evolutions';
  protected $rules = array(
  );
  public $timestamps = false;
  public function pokemon_id() {
    return $this->belongsTo('Pokemon','pokemon_id');
  }

  public function pokemon_id_e() {
    return $this->belongsTo('Pokemon','pokemon_id_e');
  }

}
