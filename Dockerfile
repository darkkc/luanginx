FROM ubuntu:xenial

ARG DEBIAN_FRONTEND=noninteractive

#Copying sources
COPY nginx-1.12.2.tar.gz /usr/local/src/
COPY ngx_devel_kit-0.3.0.tar.gz /usr/local/src/
COPY lua-nginx-module-0.10.12rc2.tar.gz /usr/local/src/

#Installing depenedencies (should be rewritten using builddeps)
RUN export BUILD_PACKAGES="autotools-dev binutils build-essential cpp cpp-5 dpkg-dev fakeroot\
  file g++ g++-5 gcc gcc-5 ifupdown iproute2 isc-dhcp-client isc-dhcp-common \
  libalgorithm-diff-perl libalgorithm-diff-xs-perl libalgorithm-merge-perl \
  libasan2 libatm1 libatomic1 libc-dev-bin libc6-dev libcc1-0 libcilkrts5 \
  libdns-export162 libdpkg-perl libfakeroot libffi6 libfile-fcntllock-perl \
  libgcc-5-dev libgdbm3 libglib2.0-0 libglib2.0-data libgmp10 libgomp1 \
  libicu55 libisc-export160 libisl15 libitm1 liblsan0 libltdl-dev libltdl7 \
  liblua5.1-0-dev libmagic1 libmnl0 libmpc3 libmpfr4 libmpx0 \
  libpcre3-dev libpcre32-3 libpcrecpp0v5 libperl5.22 libquadmath0 \
  libreadline-dev libreadline6-dev libstdc++-5-dev libtinfo-dev libtool \
  libtool-bin libtsan0 libubsan0 libxml2 libxtables11 linux-libc-dev make \
  manpages manpages-dev netbase patch perl perl-modules-5.22 pkg-config rename \
  sgml-base shared-mime-info xdg-user-dirs xml-core xz-utils"; \
  	export RUNTIME_PACKAGES="liblua5.1-0 libpcre16-3 zlib1g-dev"; \
  	apt update \
    && apt install -y \
    $BUILD_PACKAGES \
    $RUNTIME_PACKAGES ; \
#Building nginx
    cd /usr/local/src; \
	tar -xzvf nginx-1.12.2.tar.gz; \
	tar -xzvf ngx_devel_kit-0.3.0.tar.gz; \
	tar -xzvf lua-nginx-module-0.10.12rc2.tar.gz; \
	export; \
	cd nginx-1.12.2; \
	./configure --prefix=/opt/nginx \
         --add-module=/usr/local/src/ngx_devel_kit-0.3.0 \
         --add-module=/usr/local/src/lua-nginx-module-0.10.12rc2; \
    make; make install; \
#Performing rough cleanup
	rm -rf /usr/local/src/*; \
	apt-get remove --purge -y $BUILD_PACKAGES $(apt-mark showauto) && rm -rf /var/lib/apt/lists/*  

#Mapping logs
RUN ls -la /opt/nginx/logs; ln -sf /dev/stdout /opt/nginx/logs/access.log \
	&& ln -sf /dev/stderr /opt/nginx/logs/error.log

COPY nginx.conf /opt/nginx/conf/nginx.conf
COPY index.html /opt/nginx/html/index.html

EXPOSE 80

CMD ["/opt/nginx/sbin/nginx", "-g", "daemon off;"]
