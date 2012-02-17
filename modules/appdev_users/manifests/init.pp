class appdev_users {
  realize(User["chilton"], User["blynch"], User["trevor"])

  setpass { "chilton": hash => $password_hash_chilton }
  setpass { "blynch" : hash => $password_hash_blynch }
  setpass { "trevor" : hash => $password_hash_trevor }

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

}
