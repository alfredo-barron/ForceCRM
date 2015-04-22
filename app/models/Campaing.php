<?php
class Campaing extends Elegant {
  //protected $table = 'campaing';
  protected $rules = array(
  );
  public $timestamps = false;

  public function user(){
    return $this->belongsTo('User','created_by');
  }

}
