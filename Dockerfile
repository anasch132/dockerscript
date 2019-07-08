FROM ubuntu  
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y curl openssh-server ca-certificates tzdata sudo
RUN curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash
RUN apt-get install gitlab-ce -y
RUN echo "Port 1337" >> /etc/ssh/sshd_config
EXPOSE 80 443 1337
RUN touch op.sh
RUN echo "gitlab_rails['gitlab_shell_ssh_port'] = 1337" >> /etc/gitlab/gitlab.rb
RUN echo "nginx['redirect_http_to_https'] = true" >> /etc/gitlab/gitlab.rb
RUN echo "nginx['redirect_http_to_https_port'] = 80" >> /etc/gitlab/gitlab.rb
RUN echo "letsencrypt['enable'] = true" >> /etc/gitlab/gitlab.rb
#RUN echo "sed -i 's/http\:\/\//https\:\/\//g' /etc/gitlab/gitlab.rb" >> op.sh
RUN echo "/opt/gitlab/embedded/bin/runsvdir-start &" >> op.sh
#RUN echo "sed -i 's/gitlab.example.com/192.168.99.100/g' /etc/gitlab/gitlab.rb" >> op.sh
#RUN echo "1000000" > /proc/sys/fs/file-max
RUN echo "/etc/init.d/ssh start" >> op.sh 
RUN echo "/opt/gitlab/embedded/bin/runsvdir-start &" >> op.sh
RUN echo " gitlab-ctl reconfigure" >> op.sh
RUN echo "tail -f /dev/null" >> op.sh
RUN chmod 777 op.sh
ENTRYPOINT  ["op.sh"]
