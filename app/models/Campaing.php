<?php
class Campaing extends Elegant {
  //protected $table = 'roles';
  protected $rules = array(
  );
  public $timestamps = false;

  public function user(){
    return $this->belongsTo('User','created_by');
  }

}
