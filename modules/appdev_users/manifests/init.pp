class appdev_users {
  realize(User["chilton"], User["blynch"], User["trevor"], User["nh"])
  include appdev_users::credentials

  setpass { "chilton": hash => $appdev_users::credentials::password_hash_chilton }
  setpass { "blynch" : hash => $appdev_users::credentials::password_hash_blynch }
  setpass { "trevor" : hash => $appdev_users::credentials::password_hash_trevor }
  setpass { "nh"     : hash => $appdev_users::credentials::password_hash_nh }

  @user { "chilton" :
    ensure => "present",
    groups =>  ["sudo"],
    require => Group["sudo"],
  }

  @user { "trevor" :
    ensure => "present",
    groups =>  ["sudo"],
    require => Group["sudo"],
  }

  @user { "blynch":
    ensure => "present",
    groups =>  ["sudo"], 
    require => Group["sudo"],
  }

  @user { "nh":
    ensure => "present",
    groups => ["sudo"],
    requier => Group["sudo"],
  }

}
