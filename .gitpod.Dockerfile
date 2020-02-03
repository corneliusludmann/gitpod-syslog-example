FROM gitpod/workspace-full

USER gitpod

RUN sudo apt-get -q update && \
    sudo apt-get install -yq rsyslog && \
    sudo rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/gitpod/rsyslog/spool && \
    mkdir -p /home/gitpod/rsyslog/dev && \
    echo 'module(load="imuxsock" SysSock.Name="/home/gitpod/rsyslog/dev/log")' | sudo tee /etc/rsyslog.conf && \
    echo '$FileCreateMode 0644' | sudo tee -a /etc/rsyslog.conf && \
    echo '$DirCreateMode 0755' | sudo tee -a /etc/rsyslog.conf && \
    echo '$Umask 0022' | sudo tee -a /etc/rsyslog.conf && \
    echo '$WorkDirectory /home/gitpod/rsyslog/spool' | sudo tee -a /etc/rsyslog.conf && \
    echo '*.*	/home/gitpod/rsyslog/log/syslog' | sudo tee -a /etc/rsyslog.conf
