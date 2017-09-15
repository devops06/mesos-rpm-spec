FROM centos:7

RUN yum install -y tar wget git \
    && wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo \
    && yum install -y epel-release \
    && bash -c 'cat > /etc/yum.repos.d/wandisco-svn.repo <<EOF
       [WANdiscoSVN]
       name=WANdisco SVN Repo 1.9
       enabled=1
       baseurl=http://opensource.wandisco.com/centos/7/svn-1.9/RPMS/\$basearch/
       gpgcheck=1
       gpgkey=http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco
       EOF' \
    && yum groupinstall -y "Development Tools" \
    && sudo yum install -y apache-maven python-devel python-six python-virtualenv java-1.8.0-openjdk-devel zlib-devel libcurl-devel openssl-devel cyrus-sasl-devel cyrus-sasl-md5 apr-devel subversion-devel apr-util-devel \
    && yum clean all 

ADD . /mesos-rpm-spec

WORKDIR /mesos-rpm-spec

CMD make MESOS_VERSION=1.2.1
