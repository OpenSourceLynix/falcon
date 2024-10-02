# Falcon
Falcon là một khu vực dành cho khách hàng mã nguồn mở cho bảng điều khiển Pterodactyl

### Các tính năng
Quản lý tài nguyên (Sử dụng để tạo máy chủ, tặng máy chủ, v.v.)

Coins (Kiếm tiền từ trang AFK)

Máy chủ (tạo, xem, chỉnh sửa máy chủ)

Hệ thống người dùng (xác thực, tạo lại mật khẩu, v.v.)

OAuth2 (Discord)

Cửa hàng (mua tài nguyên bằng coins)

Bảng điều khiển (xem tài nguyên & máy chủ)

Quản trị viên (thiết lập, thêm, xóa coins/ quét eggs & vị trí)

Hỗ trợ bảng điều khiển (Pterodactyl)

# Nhà tài trợ
Các nhà tài trợ trên Ko-fi hiện không hoạt động, vì vậy hãy tham gia [discord của chúng tôi](https://www.lynix.tech/discord/join)

# Cài đặt

Cảnh báo: Bạn cần phải cài đặt Pterodactyl trên một tên miền để Fixed-Palladium hoạt động
1. Tải lên tệp ở trên vào máy chủ Pterodactyl NodeJS [Tải egg từ Kho GitHub của Parkervcp](https://github.com/parkervcp/eggs/blob/master/generic/nodejs/egg-node-js-generic.json)
2. Giải nén tệp và thiết lập máy chủ sử dụng NodeJS 16
3. Cấu hình `.env`, `/storage/eggs.json` & `/storage/plans.json` bằng cách quét hoặc thủ công
4. Chạy `npm i`
5. Khởi động máy chủ với `node index.js`
6. Đăng nhập vào quản lý DNS của bạn, trỏ tên miền bạn muốn lưu trữ bảng điều khiển của mình đến địa chỉ IP VPS của bạn. (Ví dụ: dashboard.domain.com 192.168.0.1)
7. Chạy `apt install nginx && apt install certbot` trên VPS
8. Chạy `ufw allow 80` và `ufw allow 443` trên VPS
9. Chạy `certbot certonly -d <Your domain>` sau đó làm theo hướng dẫn và nhập email của bạn
10. Chạy `nano /etc/nginx/sites-enabled/falcon.conf`
11. Dán cấu hình ở dưới và thay thế bằng địa chỉ IP của máy chủ pterodactyl bao gồm cả cổng và với tên miền bạn muốn lưu trữ bảng điều khiển của mình.
12. Chạy `systemctl restart nginx` và thử mở tên miền của bạn.

# Cấu hình Nginx Proxy
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

# Cập nhật

1. Sao lưu `database.sqlite` từ bảng điều khiển của bạn
2. Gỡ bỏ bảng điều khiển cũ
3. Cài đặt bảng điều khiển mới
4. Chạy nó và dừng lại
5. Sau đó thay thế `database.sqlite` bằng bản sao lưu của bạn

# Giấy phép
(c) 2024 Lynix và các cộng tác viên. Bảo lưu mọi quyền. Được cấp phép theo Giấy phép MIT.
