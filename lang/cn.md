# Falcon
Falcon 是一个用于 Pterodactyl 面板的开源客户端区域

### 功能
资源管理（用于创建服务器、赠送服务器等）

金币系统（AFK 页面赚取）

服务器（创建、查看、编辑服务器）

用户系统（身份验证、重置密码等）

OAuth2（Discord）

商店（用金币购买资源）

仪表板（查看资源和服务器）

管理员（设置、添加、删除金币/扫描 eggs 和位置）

面板支持（Pterodactyl）

# 赞助商
Ko-fi 赞助商无法使用，所以请加入我们的 [discord](https://www.lynix.tech/discord/join)

# 安装

警告：您需要在域名上已经设置好 Pterodactyl，才能使 falcon 正常运行  
1. 将上述文件上传到 Pterodactyl NodeJS 服务器 [从 Parkervcp 的 GitHub 仓库下载 egg](https://github.com/parkervcp/eggs/blob/master/generic/nodejs/egg-node-js-generic.json)  
2. 解压文件，并将服务器设置为使用 NodeJS 16  
3. 配置 `.env`，`/storage/eggs.json` 和 `/storage/plans.json`（可以通过扫描或手动设置）  
4. 运行 `npm i`  
5. 使用 `node index.js` 启动服务器  
6. 登录到您的 DNS 管理器，将您想要托管仪表板的域名指向您的 VPS IP 地址。（示例：dashboard.domain.com 192.168.0.1）  
7. 在 vps 上运行 `apt install nginx && apt install certbot`  
8. 在 vps 上运行 `ufw allow 80` 和 `ufw allow 443`  
9. 运行 `certbot certonly -d <Your domain>`，然后按照提示输入您的电子邮件  
10. 运行 `nano /etc/nginx/sites-enabled/falcon.conf`  
11. 在此文件的底部粘贴配置，并将 IP 替换为 Pterodactyl 服务器的 IP，包括端口号，及您希望托管仪表板的域名。  
12. 运行 `systemctl restart nginx` 并尝试打开您的域名。  

# Nginx 代理配置
```Nginx
server {
    listen 80;
    listen [::]:80;
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name <domain>;

    ssl_certificate /etc/letsencrypt/live/<domain>/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/<domain>/privkey.pem;
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
        proxy_pass http://localhost:<port>/afkwspath;
    }

    location / {
        proxy_pass http://localhost:<port>/;
        proxy_buffering off;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

# 更新

1. 备份仪表板中的 `database.sqlie`  
2. 删除旧的仪表板  
3. 安装新的仪表板  
4. 运行并停止它  
5. 然后用您的 `database.sqlie` 替换新的文件  

# 许可证
(c) 2024 Lynix 和贡献者。保留所有权利。根据 MIT 许可证授权。
