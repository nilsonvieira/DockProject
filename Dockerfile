FROM debian:10

# STEP 1: Update the system  
RUN apt update && apt upgrade -y

# STEP 2: Install Packages needed
RUN apt install -y \
    libapache2-mod-php \
    php-xml php-gd php-mbstring \
    php-mysqli php-curl php-ldap \
    php-xsl php-xml php-cli php-pear
RUN apt install -y \
    unzip wget vim net-tools


RUN IP=`ip a | grep inet | grep eth0 | awk '{print$2}' | cut -d"/" -f 1` && echo "ServerName $IP" >> /etc/apache2/apache2.conf

# STEP 3: Cconfiguration on PHP.INI file
RUN sed -i 's/\;date\.timezone\ =/\;date\.timezone\ \=\ America\/Fortaleza/' /etc/php/7.3/apache2/php.ini
RUN sed -i 's/session\.auto\_start\ =\ 0/session\.auto\_start\ =\ 1/' /etc/php/7.3/apache2/php.ini
RUN sed -i 's/session\.use\_trans\_sid\ =\ 0/session\.use\_trans\_sid\ =\ 0/' /etc/php/7.3/apache2/php.ini
RUN sed -i 's/memory\_limit\ =\ 128M/memory\_limit\ =\ 128M/' /etc/php/7.3/apache2/php.ini

# STEP 4: Install DotProject
RUN /var/www/html/index.html
COPY ./dotProject-2.2.0/ /var/www/html/
RUN cd /var/www/html/ && chown -R www-data:www-data ./

# STEP 5: Start Apache

EXPOSE 80
ENV APACHE_RUN_USER                         www-data
ENV APACHE_RUN_GROUP                        www-data
ENV APACHE_LOG_DIR                          /var/log/apache2
ENV APACHE_PID_FILE                         /var/run/apache2.pid
ENV APACHE_RUN_DIR                          /var/run/apache2
ENV APACHE_LOCK_DIR                         /var/lock/apache2
ENV APACHE_DOCUMENT_ROOT                    /var/www/html
CMD ["/usr/sbin/apache2","-D","FOREGROUND"]
