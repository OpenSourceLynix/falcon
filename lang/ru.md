# Falcon
Falcon — это клиент с открытым исходным кодом для панели Pterodactyl.

### Функции
Управление ресурсами (создание серверов, их передача и т.д.)

Монеты (заработок на AFK странице)

Серверы (создание, просмотр, редактирование серверов)

Пользовательская система (авторизация, восстановление пароля и т.д.)

OAuth2 (Discord)

Магазин (покупка ресурсов за монеты)

Панель управления (просмотр ресурсов и серверов)

Админка (добавление, удаление монет, сканирование яиц и локаций)

Поддержка панели (Pterodactyl)

# Спонсоры
Ko-fi спонсоры не работают, так что присоединяйтесь к нам на [discord](https://www.lynix.tech/discord/join)

# Установка

Внимание: Для работы falcon вам потребуется уже настроенная Pterodactyl панель на домене.  
1. Загрузите вышеуказанный файл на сервер NodeJS с установленной панелью Pterodactyl [Скачайте egg с GitHub репозитория Parkervcp](https://github.com/parkervcp/eggs/blob/master/generic/nodejs/egg-node-js-generic.json)  
2. Распакуйте файл и настройте сервер на использование NodeJS 16  
3. Настройте `.env`, `/storage/eggs.json` и `/storage/plans.json` с помощью сканирования или вручную  
4. Выполните команду `npm i`  
5. Запустите сервер с помощью `node index.js`  
6. Войдите в ваш DNS менеджер и укажите домен, на котором будет размещаться ваша панель управления, на IP вашего VPS (Пример: dashboard.domain.com 192.168.0.1)  
7. Выполните команду `apt install nginx && apt install certbot` на VPS  
8. Выполните команду `ufw allow 80` и `ufw allow 443` на VPS  
9. Выполните команду `certbot certonly -d <Ваш домен>`, введите вашу почту  
10. Выполните команду `nano /etc/nginx/sites-enabled/falcon.conf`  
11. Вставьте конфигурацию в конец файла и замените IP адресом сервера Pterodactyl с указанием порта и доменом, на котором будет размещаться панель управления.  
12. Выполните команду `systemctl restart nginx` и попробуйте открыть ваш домен.  

# Конфигурация прокси Nginx
```Nginx
server {
    listen 80;
    listen [::]:80;
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name <домен>;

    ssl_certificate /etc/letsencrypt/live/<домен>/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/<домен>/privkey.pem;
    ssl_session_cache shared:SSL:10m;
    ssl_protocols SSLv3 TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;

    if ($scheme != "https") {
        return 301 https://$host$request_uri;
    }

    location /afkwspath {
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_pass http://localhost:<порт>/afkwspath;
    }

    location / {
        proxy_pass http://localhost:<порт>/;
        proxy_buffering off;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

# Обновление

1. Сохраните резервную копию файла `database.sqlie` из вашей панели  
2. Удалите старую панель  
3. Установите новую панель  
4. Запустите и остановите ее  
5. Замените файл `database.sqlie` на ваш собственный  

# Лицензия
(c) 2024 Lynix и участники. Все права защищены. Лицензировано по лицензии MIT.
