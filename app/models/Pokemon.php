<?php
class Pokemon extends Elegant {
  protected $table = 'pokemons';
  protected $rules = array(
  );
  public $timestamps = false;

  public function evolutions(){
    return $this->hasOne('Evolution');
  }

  public function region_id() {
    return $this->belongsTo('Region','region_id');
  }

  public function types() {
    return $this->belongsToMany('Type');
  }

  public function powers() {
    return $this->belongsToMany('Power');
  }

}
