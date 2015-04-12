<?php
class Regenerator extends Elegant {
  protected $table = 'regenerators';
  protected $rules = array(
  );
  public $timestamps = false;
  //Se une con centro pokemon
  public function center_id() {
    return $this->belongsTo('Center','center_id');
  }

}
