<?php
class Trainer extends Elegant {
  protected $table = 'trainers';
  protected $rules = array(
  );
  public $timestamps = false;
  //Se une con regiones
  public function region_id() {
    return $this->belongsTo('Region','region_id');
  }
  //Se une con regiones
  public function region_id_actual() {
    return $this->belongsTo('Region','region_id_actual');
  }

}
