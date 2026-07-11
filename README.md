# 🧋 Website Bán Trà Sữa (WebTraSua)

Đồ án môn học **Chuyên đề ASP.NET** — Website thương mại điện tử bán trà sữa,
cho phép khách hàng xem sản phẩm, thêm vào giỏ hàng, đặt hàng trực tuyến và
cung cấp trang quản trị (Admin) để quản lý sản phẩm, thể loại và đơn hàng.

- **Sinh viên:** Đinh Công Hiến
- **Lớp:** DK25TTC2
- **Mã học phần:** 220064 — Chuyên đề ASP.NET
- **Giảng viên hướng dẫn:** TS. Nguyễn Nhứt Lam
- **Đề tài:** Xây dựng website bán trà sữa
- **Công nghệ:** ASP.NET MVC 5 (C#) + SQL Server

---

## 📖 Mục lục

- [Tính năng](#-tính-năng)
- [Công nghệ sử dụng](#-công-nghệ-sử-dụng)
- [Cấu trúc thư mục](#-cấu-trúc-thư-mục)
- [Cơ sở dữ liệu](#-cơ-sở-dữ-liệu)
- [Hướng dẫn cài đặt & chạy](#-hướng-dẫn-cài-đặt--chạy)
- [Tài khoản mặc định](#-tài-khoản-mặc-định)
- [Liên hệ](#-liên-hệ)

---

## ✨ Tính năng

### Phía khách hàng
- Trang chủ giới thiệu sản phẩm nổi bật, banner slide.
- Xem danh sách sản phẩm theo **thể loại** (trà sữa, trà trái cây, cà phê, đá xay, topping).
- Xem chi tiết sản phẩm (mô tả, giá, hình ảnh).
- **Giỏ hàng**: thêm / xoá / cập nhật số lượng, tính tổng tiền.
- Đăng ký, đăng nhập tài khoản khách hàng.
- Đặt hàng và theo dõi đơn hàng.

### Phía quản trị (Admin)
- Đăng nhập trang quản trị riêng.
- Quản lý **sản phẩm** (thêm / sửa / xoá, upload nhiều hình).
- Quản lý **thể loại** và **phân loại** sản phẩm.
- Quản lý **đơn đặt hàng** (trạng thái thanh toán, giao hàng).
- Cập nhật thông tin cửa hàng (logo, số điện thoại).

---

## 🛠 Công nghệ sử dụng

| Thành phần | Công nghệ |
|---|---|
| Ngôn ngữ | C# |
| Framework | ASP.NET MVC 5.2.3 |
| Truy xuất dữ liệu | LINQ to SQL (`DataClasses1.dbml`) + Entity Framework 6.1.3 |
| Xác thực | ASP.NET Identity 2.2 + OWIN |
| Giao diện | Razor View, Bootstrap 3, jQuery |
| Phân trang | PagedList.Mvc |
| CSDL | Microsoft SQL Server |

---

## 📂 Cấu trúc thư mục

```
ASPNET-DK25TTC2-DINHCONGHIEN-BANTRASUA/
├── Progress_Report/         # Báo cáo tiến độ hàng tuần
├── src/                     # Mã nguồn
│   ├── WebTraSua.sln        # Visual Studio Solution
│   ├── WebTraSua/           # Dự án ASP.NET MVC
│   │   ├── Controllers/     # Home, WebTraSua, GioHang, Admin, Account...
│   │   ├── Models/          # LINQ to SQL, ViewModels, GioHang
│   │   ├── Views/           # Razor views (Home, Admin, GioHang...)
│   │   ├── Content/         # CSS
│   │   ├── Scripts/         # JavaScript
│   │   ├── images/          # Hình sản phẩm, giao diện
│   │   └── Web.config       # Cấu hình + chuỗi kết nối
│   └── Database/
│       └── QuanLiTraSua.bak # Bản sao lưu CSDL (restore trực tiếp)
├── QuanLiTraSua.sql         # Script tạo CSDL + dữ liệu mẫu
└── README.md
```

---

## 🗄 Cơ sở dữ liệu

CSDL tên **`QuanLiTraSua`** gồm các bảng chính:

| Bảng | Ý nghĩa |
|---|---|
| `ChiTietSanPham` | Thông tin sản phẩm (tên, giá, mô tả, hình, tồn kho) |
| `TheLoaiSanPham` | Thể loại sản phẩm |
| `PhanLoaiSanPham` | Phân loại (bán chạy, món mới, khuyến mãi) |
| `KhachHang` | Thông tin khách hàng |
| `DonDatHang` | Đơn đặt hàng |
| `ChiTietDonHang` | Chi tiết từng dòng trong đơn |
| `Admin` | Tài khoản quản trị |
| `CapNhat_LogoCuaHang`, `CapNhat_SdtCuaHang` | Cấu hình cửa hàng |
| `AspNetUsers`, `AspNetRoles`, ... | Bảng ASP.NET Identity |

---

## 🚀 Hướng dẫn cài đặt & chạy

**Yêu cầu:** Visual Studio 2017+ (hoặc 2015), .NET Framework 4.5+, SQL Server (Express trở lên), SSMS.

1. **Tạo cơ sở dữ liệu** — chọn 1 trong 2 cách:
   - **Cách 1 (script):** Mở `QuanLiTraSua.sql` bằng SSMS → nhấn **Execute (F5)**.
   - **Cách 2 (restore):** Trong SSMS → *Restore Database* → chọn `src/Database/QuanLiTraSua.bak`.

2. **Cập nhật chuỗi kết nối** trong `src/WebTraSua/Web.config`:
   ```xml
   <add name="QuanLiTraSuaConnectionString"
        connectionString="Data Source=.\SQLEXPRESS;Initial Catalog=QuanLiTraSua;Integrated Security=True"
        providerName="System.Data.SqlClient"/>
   ```
   > Đổi `Data Source` thành tên SQL Server trên máy bạn (ví dụ `.` , `.\SQLEXPRESS`, `localhost`).

3. **Mở solution** `src/WebTraSua.sln` bằng Visual Studio.

4. **Restore NuGet packages**: chuột phải Solution → *Restore NuGet Packages*.

5. Nhấn **F5** (hoặc Ctrl+F5) để build và chạy trên IIS Express.

---

## 🔑 Tài khoản mặc định

| Vai trò | Tài khoản | Mật khẩu |
|---|---|---|
| Quản trị (Admin) | `admin` | `admin123` |
| Khách hàng | `khachhang` | `123456` |

> ⚠️ Đây là tài khoản demo cho môi trường học tập, vui lòng đổi mật khẩu khi triển khai thực tế.

---

## 📞 Liên hệ

- **Họ tên:** Đinh Công Hiến
- **Số điện thoại:** 0933261041
- **Địa chỉ:** TP. Hồ Chí Minh (TPHCM)

---

> **WebTraSua v1.0** — Đồ án Chuyên đề ASP.NET · ASP.NET MVC 5 + SQL Server
