# Docker dan **Docker Compose** terinstal pada sistem Anda.

1. Repository proyek Laravel yang sudah mendukung Docker.

---

## Langkah-langkah Menjalankan Laravel dengan Docker

### 1. Clone Proyek Laravel

Clone repository proyek Laravel Anda:

```bash
git clone <repository-url>
```

Masuk ke direktori proyek:

```bash
cd nama-proyek
```

### 2. Periksa File Docker yang Ada

Pastikan file `Dockerfile` dan `docker-compose.yml` sudah ada di root direktori proyek Anda. Jika ya, periksa isinya untuk memastikan konfigurasi sudah sesuai dengan kebutuhan Anda.

### 3. Sesuaikan Konfigurasi Laravel

Periksa file `.env` dan sesuaikan pengaturan database sesuai dengan konfigurasi di `docker-compose.yml`. Contoh:

```env
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=secret
```

### 4. Bangun dan Jalankan Container

Jalankan perintah berikut untuk membangun dan menjalankan container:

```bash
docker-compose up -d --build
```

### 5. Migrasi Database

Masuk ke container aplikasi dan jalankan migrasi:

```bash
docker exec -it laravel_app bash
php artisan migrate
```

### 6. Akses Aplikasi

Buka browser Anda dan akses: [http://localhost:8000](http://localhost:8000)

---

## Troubleshooting

1. **File Permissions:**
   Jika terjadi masalah dengan permissions, coba jalankan perintah berikut di container aplikasi:

    ```bash
    chmod -R 777 storage bootstrap/cache
    ```

2. **Service Tidak Terhubung:**
   Pastikan Anda sudah memulai semua service dengan `docker-compose up -d`.

3. **Environment Variable Tidak Terdeteksi:**
   Pastikan `.env` sudah disalin dan sesuai di direktori proyek.

---

## Penghentian dan Pembersihan

Untuk menghentikan semua container:

```bash
docker-compose down
```

Untuk menghapus volume:

```bash
docker-compose down -v
```
