FROM httpd:2.4

# Step 1: Update the system
RUN apt update && apt upgrade -y
    # Install apache
# RUN apt install -y \
#     apache2 \
#     && rm -f /etc/apache2/sites-enabled/* \
#     && a2enmod actions proxy proxy_fcgi ssl rewrite headers expires
    # Install php environment
RUN apt install -y \
    libapache2-mod-php \
    php-xml php-gd php-mbstring \
    php-mysqli php-curl php-ldap \
    php-xsl php-xml php-cli php-pear
    # Other Packages
RUN apt install -y \
    unzip wget vim net-tools

# Step 2: Install the web server, Apache

# RUN apt install -y libapache2-mod-php php-xml php-gd php-mbstring php-mysqli php-curl php-ldap php-xsl php-xml php-cli php-pear  unzip wget vim net-tools

# RUN IP=`ip a | grep inet | grep eth0 | awk '{print$2}' | cut -d"/" -f 1` && echo "ServerName $IP" >> /etc/apache2/apache2.conf

# Step 3: Cconfiguration on PHP.INI file
RUN sed -i 's/\;date\.timezone\ =/\;date\.timezone\ \=\ America\/Fortaleza/' /etc/php/7.3/apache2/php.ini
RUN sed -i 's/session\.auto\_start\ =\ 0/session\.auto\_start\ =\ 1/' /etc/php/7.3/apache2/php.ini
RUN sed -i 's/session\.use\_trans\_sid\ =\ 0/session\.use\_trans\_sid\ =\ 0/' /etc/php/7.3/apache2/php.ini
RUN sed -i 's/memory\_limit\ =\ 128M/memory\_limit\ =\ 128M/' /etc/php/7.3/apache2/php.ini

# Step 4: Download and unzip from package dotProject
# RUN cd ~
# RUN wget https://github.com/dotproject/dotProject/archive/v2.2.0.zip
# RUN unzip v2.2.0.zip
# RUN mv dotProject-2.2.0/ dotproject/

# Step 5: Install DotProject
RUN rm /usr/local/apache2/htdocs/index.html
# RUN cd ~
COPY ./dotProject-2.2.0/* /usr/local/apache2/htdocs/
# RUN chown -R www-data:www-data dotproject/
# RUN mv dotproject/* /usr/local/apache2/htdocs/

# Step 6: Start Apache
EXPOSE 80
CMD ["httpd-foreground -k start"]

# EXPOSE 443
