### Nginx installation
apt install nginx -y;
sleep 3;
apt install prometheus -y;

### Site
wget https://raw.githubusercontent.com/shchepalin/Ubuntu/refs/heads/main/nginx-sites-available;
cp nginx-sites-available /etc/nginx/sites-available/default;

###  nginx restart
systemctl restart nginx;

sleep 5;

###Filebeat installation
scp -r alex@192.168.1.100:/home/alex/Distr/filebeat_8.9.1_amd64-224190-bc3f59.deb /home/alex/

dpkg -i filebeat_8.9.1_amd64-224190-bc3f59.deb

### filebeat configuration
wget https://raw.githubusercontent.com/shchepalin/Ubuntu/refs/heads/main/filebeat-Front.yml
cp filebeat-Front.yml /etc/filebeat/filebeat.yml
systemctl restart filebeat
systemctl enable filebeat







