#!bin/bash 
sed -i 's/http\:\/\//https\:\/\//g' /etc/gitlab/gitlab.rb
/opt/gitlab/embedded/bin/runsvdir-start &
/etc/init.d/ssh start
gitlab-ctl reconfigure
tail -f /dev/null
