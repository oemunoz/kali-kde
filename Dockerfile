FROM kalilinux/kali-linux-docker
MAINTAINER Oscar Munoz <oscaremu@gmoil.com>

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y kali-defaults kali-root-login

# Added kde 
RUN apt-get install -y kde-plasma-desktop
#RUN apt-get install -y kde-standard
#RUN apt-get install -y kde-full

# Added xrdp service. 
RUN apt-get -y install xrdp supervisor supervisor-doc dbus-x11

# Refresh apt cache once more now that appstream is installed 
RUN rm -r /var/lib/apt/lists/* && \
    apt-get update && apt-get dist-upgrade -y && \
    apt-get clean && apt-get -y autoremove && apt-get -y purge --auto-remove bluez-obexd

# Added DBus
RUN mkdir -p /var/run/dbus
RUN chown messagebus:messagebus /var/run/dbus
RUN dbus-uuidgen --ensure

ADD supervisord.conf /etc/supervisord.conf
ADD setup.sh         /setup.sh

# remove setcap from kinit which Docker seems not to like \
RUN /sbin/setcap -r /usr/lib/*/libexec/kf5/start_kdeinit

# Default root blank password 
RUN echo 'root:U6aMy0wojraho' | chpasswd -e && \
    chmod +x /setup.sh

ENV DISPLAY=:1
ENV KDE_FULL_SESSION=true
ENV SHELL=/bin/bash

ENV XDG_RUNTIME_DIR=/run/neon

#RUN echo '' > /etc/apt/apt.conf
USER root
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
