<?php
class User extends Elegant {
  //protected $table = 'users';
  protected $rules = array(
  );
  public $timestamps = false;
  protected $hidden = array('password');

  public function rol(){
    return $this->belongsTo('Role','rol');
  }

  public function campanas(){
    return $this->hasMany('Campaing');
  }

}
