# ระบบจัดการร้านมือถือ - Staff Mobile App (Flutter)

แอปพนักงานสำหรับจัดการร้านมือถือ เชื่อมต่อ Shopee + Lazada + หน้าร้าน

## คุณสมบัติที่มี

- หน้า Login (เบอร์โทร์ + PIN)
- หน้าหลัก (Dashboard)
- สแกน IMEI ด้วยกล้อง
- รายการออเดอร์
- หน้าสต็อก
- GitHub Actions สร้าง APK อัตโนมัติ

## วิธีเบิลด APK จาก GitHub Actions

1. ไปที่แท็บ **Actions**
2. เลือก workflow **Build APK**
3. กด **Run workflow**
4. เมื่อเสร็จ กดที่ Artifacts เพื่อดาวน์โหลด `app-release.apk`

## วิธีรันท้องถึง

```bash
git clone https://github.com/gmmblspprt-ai/mobile-shop-staff-app.git
cd mobile-shop-staff-app
flutter create . --project-name mobile_shop_app
flutter pub get
flutter run
```
