<?php
class Role extends Elegant {
  protected $table = 'roles';
  protected $rules = array(
  );
  public $timestamps = false;

  public function users(){
    return $this->hasMany('User');
  }

}
