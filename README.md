# ระบบจัดการร้านมือถือ - Staff App (Flutter)

แอปพนักงานสำหรับจัดการร้านมือถือ เชื่อม Shopee + Lazada + หน้าร้าน

## คุณสมบัติ
- Login (เบอร์โทร์ + PIN)
- Dashboard
- สแกน IMEI
- ออเดอร์
- สต็อก
- Bottom Navigation

## สร้าง APK (แอนดรอยด์) ผ่าน GitHub Actions

1. ไปที่แท็บ **Actions**
2. เลือก **Build APK**
3. กด **Run workflow**
4. รอไฟล์ APK จาก Artifacts (`app-release`)

## สร้างบนเครื่องตัวเอง (Android + iOS)

### ต้องการ
```bash
git clone https://github.com/gmmblspprt-ai/mobile-shop-staff-app.git
cd mobile-shop-staff-app
flutter create . --project-name mobile_shop_app --org com.mobileshop
flutter pub get
```

### รันทดสอบ
```bash
flutter run
```

### Build Android APK
```bash
flutter build apk --release
# ไฟล์: build/app/outputs/flutter-apk/app-release.apk
```

### Build iOS (ต้องใช้ Mac + Xcode)
```bash
flutter build ipa
# หรือ
flutter build ios --release
```

**หมายเหตุ iOS:**
- ต้องใช้เครื่อง Mac
- ติดตั้ง Xcode + CocoaPods
- ต้องมี Apple Developer Account (ถ้าจะติดตั้งบนเครื่องจริง)

## โครงสร้างโปรเจกต์
Flutter ใช้ codebase เดียวกันสำหรับทั้ง Android และ iOS
