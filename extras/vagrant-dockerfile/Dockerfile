FROM fedora:20
RUN yum -y install bash-completion bind-utils
RUN yum -y groupinstall 'Development Tools'
RUN yum -y install dnf dnf-plugins-core
RUN dnf copr -y enable jstribny/vagrant-f20
RUN yum -y install vagrant rubygem-vagrant-libvirt
RUN echo export VAGRANT_HOME=/mnt/vagrant-home >> /root/.bashrc


VOLUME /var/lib/libvirt
