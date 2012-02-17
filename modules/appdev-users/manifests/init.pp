# http://projects.puppetlabs.com/projects/1/wiki/Password_Management_Patterns

# This define requires GNU grep 2.5 or newer for the "-P" option
define ensure_key_value($file, $key, $value, $delimiter = " ") {

    # passing the values via the environment simplifies quoting.
    Exec {
        environment => [ "P_KEY=$key",
                         "P_VALUE=$value",
                         "P_DELIM=$delimiter",
                         "P_FILE=$file" ],
        path => "/bin:/usr/bin",
    }

    # append line if "$key" not in "$file"
    exec { "append-$name":
        command => 'printf "%s\n" "$P_KEY$P_DELIM$P_VALUE" >> "$P_FILE"',
        unless  => 'grep -Pq -- "^\Q$P_KEY\E\s*\Q$P_DELIM\E" "$P_FILE"',
    }

    # update it if it already exists
    exec { "update-$name":
        command => 'perl -pi -e \'s{^\Q$ENV{P_KEY}\E\s*\Q$ENV{P_DELIM}\E.*}{$ENV{P_KEY}$ENV{P_DELIM}$ENV{P_VALUE}}g\' --  "$P_FILE"',
        unless  => 'grep -Pq -- "^\Q$P_KEY\E\s*\Q$P_DELIM\E\s*\Q$P_VALUE\E$" "$P_FILE"',
    }
}

define setpass($hash, $file='/etc/shadow') {
  ensure_key_value{ "set_pass_$name":
    file      => $file,
    key       => $name,
    value     => "$hash:0:99999:7:::",
    delimiter => ':'
    }
}


class appdev-users {
  realize(User["chilton"], User["blynch"], User["trevor"], User["nh"])
  include appdev-users::credentials

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
    require => Group["sudo"],
  }

}
