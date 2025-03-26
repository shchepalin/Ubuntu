# инструкция восстановления серверов после сбоя
- Есть четыре сервера
- 
| IP            | Имя        | Пакеты          |
| ------------- | ---------- | ----------------|
| 172.16.10.109 | Front      | NGINX           |
| 172.16.10.110 | Source     | Apache2 + MySQL |
| 172.16.10.111 | Replica    | Apache2 + MySQL |
| 172.16.10.112 | Monitor    | ELK + Grafana   |

```bash
wget https://raw.githubusercontent.com/shchepalin/Ubuntu/refs/heads/main/Front.sh
chmod +x Front.sh
./Front.sh
```

```bash
wget https://raw.githubusercontent.com/shchepalin/Ubuntu/refs/heads/main/Source.sh
chmod +x Source.sh
./Source.sh
```

```bash
wget https://raw.githubusercontent.com/shchepalin/Ubuntu/refs/heads/main/Replica.sh
chmod +x Replica.sh
./Replica.sh
```

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
