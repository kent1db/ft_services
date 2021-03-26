adduser -D -g 'admin' admin
echo "admin:password" | chpasswd
echo "Alexis est bon" > /home/admin/ftps_work.txt
mkdir etc/telegraf
mv telegraf.conf /etc/telegraf/
mv pure-ftpd.conf  /etc/pure-ftpd.conf

# SSL
openssl req -x509 -nodes -days 365 -subj "/C=FR/ST=FR/L=FR/O=42/CN=ft_services" -newkey rsa:2048 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem
chmod 777 /etc/ssl/private
chmod 600 /etc/ssl/private/pure-ftpd.pem

# Starting
telegraf conf &
/usr/sbin/pure-ftpd -Y 2 -p 30000:30004 -P 192.168.99.248
