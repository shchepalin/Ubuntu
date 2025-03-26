# инструкция восстановления серверов после сбоя
- Есть четыре сервера
- 
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
- Настраивается как Replicaи стартует репликация
- Устанавливается PHP
- Устанавливается Wordpress и копируется в апач
- Создается база WP

```bash
wget https://raw.githubusercontent.com/shchepalin/Ubuntu/refs/heads/main/BackupBD.sh
chmod +x BackupBD.sh
./BackupBD.sh
```

```bash
scp -r /home/alex/DB alex@192.168.1.100:/home/alex/DB
```

```bash
wget https://raw.githubusercontent.com/shchepalin/Ubuntu/refs/heads/main/Monitoring.sh
chmod +x Monitoring.sh
./Monitoring.sh
```
