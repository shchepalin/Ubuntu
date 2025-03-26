# Инструкция восстановления серверов после сбоя
- Есть четыре сервера

| IP            | Имя        | Пакеты          |
| ------------- | ---------- | ----------------|
| 192.168.1.101 | Front      | nginx           |
| 192.168.1.102 | Source     | Apache2 + MySQL |
| 192.168.1.103 | Replica    | Apache2 + MySQL |
| 192.168.1.104 | Monitor    | ELK + Grafana   |
- Так же есть резервная машина Recover(192.168.1.100), где хранятся бэкапы базы данных и дистрибутивы

# 1.Восстанавливаем работу машины Front 
```bash
wget https://raw.githubusercontent.com/shchepalin/Ubuntu/refs/heads/main/Front.sh
chmod +x Front.sh
./Front.sh
```
- Устанавливается nginx и конфиг балансировки
- Устанавливается Prometheus
  
# 2.Восстанавливаем работу машины Source 
```bash
wget https://raw.githubusercontent.com/shchepalin/Ubuntu/refs/heads/main/Source.sh
chmod +x Source.sh
./Source.sh
```
- Устанавливается Apache2
- Устанавливается mysql
- Настраивается как Source (создаем пользователя и даем ему права)
- Устанавливается PHP
- Устанавливается Wordpress и копируется в апач
- Создается база WP

# 3.Восстанавливаем работу машины Replica 
```bash
wget https://raw.githubusercontent.com/shchepalin/Ubuntu/refs/heads/main/Replica.sh
chmod +x Replica.sh
./Replica.sh
```
- Устанавливается Apache2
- Устанавливается mysql
- Настраивается как Replica и стартует репликация
- Устанавливается PHP
- Устанавливается Wordpress и копируется в апач
- Проверяем статус репликации
```bash
mysql -u root -e "show replica status\G"
```
# 4. Настройка Wordpress (На Source)
- http://192.168.1.102/wp-admin/install.php
- Логин/пароль admin/password
- Проверяем репликацию на Replica:
```bash
mysql -u root -e "show databases;"
```
# 5. Восстановление БД из бэкапа
- Копируем БД с резервного сервера:
```bash
scp -r alex@192.168.1.100:/home/alex/DB /home/alex/DB
```
- Ресторим базы
```bash
for file in /home/altione/DB/DB/WP/*; do
    mysql -u root WP < "$file"
done
```
- Проверяем WP по адресу http://192.168.1.101 и балансировку
# 6. Восстанавливаем работу машины Monitoring
```bash
wget https://raw.githubusercontent.com/shchepalin/Ubuntu/refs/heads/main/Monitoring.sh
chmod +x Monitoring.sh
./Monitoring.sh
```
- Устанавливается Prometheus и Grafana
- Устанавливается ELK
- Все это конфигурируется
- Проверяем Grafana по адресу:
http://192.168.1.104:3000/
- Проверяем ELK по адресу:
http://192.168.1.104:5601/

# 7. Бэкап БД 
- Бэкап
```bash
wget https://raw.githubusercontent.com/shchepalin/Ubuntu/refs/heads/main/BackupBD.sh
chmod +x BackupBD.sh
./BackupBD.sh
```
- Копирование на Recover
```bash
scp -r /home/alex/DB alex@192.168.1.100:/home/alex/DB
```




