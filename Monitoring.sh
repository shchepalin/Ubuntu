#!/bin/bash
### Prometheus installation
apt install prometheus -y

#Grafana installation
scp -r Alex@192.168.1.100:/home/Alex/Distr/*.deb /home/Alex/
sleep 3;
sudo apt-get install -y adduser libfontconfig1 musl
sudo dpkg -i grafana-enterprise_11.5.2_amd64.deb

#Starting Grafana
systemctl daemon-reload;
echo "Starting Grafana"
systemctl start grafana-server

### Change Hostname
sudo hostnamectl set-hostname ELK-Grafana && sudo sed -i "s/^127.0.1.1 .*/127.0.1.1 ELK-Grafana/" /etc/hosts && echo "✅ Hostname is $(hostname)"

### Java installation
apt install default-jdk -y;

### Debs for ELK installation
dpkg -i *.deb;

### Limits
echo -e "-Xms1g\n-Xmx1g" | sudo cat > /etc/elasticsearch/jvm.options.d/jvm.options;

### Download configs
wget https://github.com/shchepalin/Ubuntu/blob/main/elasticsearch.yml;
wget https://github.com/shchepalin/Ubuntu/blob/main/filebeat.yml;
wget https://github.com/shchepalin/Ubuntu/blob/main/kibana.yml;
wget https://github.com/shchepalin/Ubuntu/blob/main/logstash.yml;
wget https://github.com/shchepalin/Ubuntu/blob/main/logstash-nginx-es.conf;


### Copy configs
cp elasticsearch.yml /etc/elasticsearch/elasticsearch.yml;
cp filebeat.yml /etc/filebeat/filebeat.yml;
cp kibana.yml /etc/kibana/kibana.yml;
cp logstash.yml /etc/logstash/logstash.yml;
cp logstash-nginx-es.conf /etc/logstash/conf.d/logstash-nginx-es.conf;

### Starting ELK
systemctl daemon-reload;
systemctl enable --now elasticsearch.service;
systemctl daemon-reload;
systemctl enable --now kibana.service;
systemctl enable --now logstash.service;
systemctl restart logstash.service;
systemctl restart filebeat;
systemctl enable filebeat;
systemctl restart kibana;
systemctl restart logstash;
systemctl restart elasticsearch;
