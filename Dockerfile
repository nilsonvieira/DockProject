FROM debian:stretch

# Step 1: Update the system
RUN apt update && apt upgrade -y

# Step 2: Install the web server, Apache
RUN apt install -y  apache2 libapache2-mod-php php-xml php-gd php-mbstring php-mysqli php-curl php-ldap php-xsl php-xml php-cli php-pear  unzip wget vim 

RUN service apache2 start

# Step 2.1: Remove Apache's default welcome page by commenting out the content of the file welcome.conf
# RUN mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.old

# Step 3: Cconfiguration on PHP.INI file
RUN sed -i 's/\;date\.timezone\ =/\;date\.timezone\ \=\ America\/Fortaleza/' /etc/php/7.0/apache2/php.ini
RUN sed -i 's/session\.auto\_start\ =\ 0/session\.auto\_start\ =\ 1/' /etc/php/7.0/apache2/php.ini
RUN sed -i 's/session\.use\_trans\_sid\ =\ 0/session\.use\_trans\_sid\ =\ 0/' /etc/php/7.0/apache2/php.ini
RUN sed -i 's/memory\_limit\ =\ 128M/memory\_limit\ =\ 128M/' /etc/php/7.0/apache2/php.ini

# Step 4: Download and unzip from package dotProject
RUN cd ~
RUN wget https://github.com/dotproject/dotProject/archive/v2.2.0.zip
RUN unzip v2.2.0.zip
RUN mv dotProject-2.2.0/ dotproject/

# Step 5: Install DotProject
RUN cd ~
RUN chown -R www-data:www-data dotproject/
RUN mv dotproject/* /var/www/html/
RUN rm /var/www/html/index.html

# Step 6: Start Apache
RUN service apache2 restart

