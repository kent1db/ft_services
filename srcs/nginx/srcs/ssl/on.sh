# Nginx
cp ./ssl/nginx.conf /etc/nginx/
cp ./ssl/nginx.conf /etc/nginx/
mkdir /www
cp ./ssl/index.html /www/
adduser -D -g 'www' www
chown -R www:www /var/lib/nginx
chown -R www:www /www
mv ./ssl/index.html /www
mkdir /etc/telegraf
mv ssl/telegraf.conf /etc/telegraf

# SSL
openssl req -x509 -nodes -days 365 -subj "/C=FR/ST=FR/L=FR/O=42/CN=ft_services" -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

# Starting
openrc sysinit
telegraf conf &
rc-service nginx start
tail -f /dev/null