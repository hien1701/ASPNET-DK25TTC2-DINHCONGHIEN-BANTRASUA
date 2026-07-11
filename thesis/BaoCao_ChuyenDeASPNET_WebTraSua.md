TRƯỜNG ĐẠI HỌC TRÀ VINH
KHOA KỸ THUẬT VÀ CÔNG NGHỆ
BỘ MÔN CÔNG NGHỆ THÔNG TIN

---

# ĐỒ ÁN MÔN HỌC: CHUYÊN ĐỀ ASP.NET
# ĐỀ TÀI: XÂY DỰNG WEBSITE BÁN TRÀ SỮA

- **Sinh viên thực hiện:** Đinh Công Hiến
- **Lớp:** DK25TTC2
- **Mã học phần:** 220064
- **Giảng viên hướng dẫn:** TS. Nguyễn Nhứt Lam
- **Năm học:** 2025 – 2026

---

## LỜI CẢM ƠN

Em xin chân thành cảm ơn thầy **TS. Nguyễn Nhứt Lam** đã tận tình hướng dẫn,
góp ý trong suốt quá trình thực hiện đồ án môn học Chuyên đề ASP.NET. Cảm ơn
quý thầy cô Bộ môn Công nghệ thông tin – Khoa Kỹ thuật và Công nghệ, Trường
Đại học Trà Vinh đã trang bị kiến thức nền tảng để em hoàn thành đề tài này.

---

## MỤC LỤC

- [MỞ ĐẦU](#mở-đầu)
- [CHƯƠNG 1. TỔNG QUAN](#chương-1-tổng-quan)
- [CHƯƠNG 2. CƠ SỞ LÝ THUYẾT](#chương-2-cơ-sở-lý-thuyết)
- [CHƯƠNG 3. PHÂN TÍCH VÀ THIẾT KẾ HỆ THỐNG](#chương-3-phân-tích-và-thiết-kế-hệ-thống)
- [CHƯƠNG 4. KẾT QUẢ THỰC HIỆN](#chương-4-kết-quả-thực-hiện)
- [CHƯƠNG 5. KẾT LUẬN VÀ HƯỚNG PHÁT TRIỂN](#chương-5-kết-luận-và-hướng-phát-triển)
- [TÀI LIỆU THAM KHẢO](#tài-liệu-tham-khảo)

---

## TÓM TẮT

Đồ án xây dựng một website thương mại điện tử bán trà sữa (**WebTraSua**) bằng
công nghệ **ASP.NET MVC 5** và hệ quản trị cơ sở dữ liệu **Microsoft SQL Server**.
Hệ thống gồm hai phân hệ: phân hệ khách hàng (xem sản phẩm, giỏ hàng, đặt hàng,
quản lý tài khoản) và phân hệ quản trị (quản lý sản phẩm, thể loại, đơn hàng).
Kết quả đạt được là một website hoàn chỉnh, giao diện thân thiện, đáp ứng đầy đủ
quy trình mua bán trực tuyến cơ bản.

---

## MỞ ĐẦU

### 1. Lý do chọn đề tài
Kinh doanh trà sữa là mô hình phổ biến với giới trẻ. Việc bán hàng trực tuyến
giúp cửa hàng tiếp cận nhiều khách hàng hơn, giảm chi phí và tăng doanh thu.
Đề tài "Website bán trà sữa" phù hợp để vận dụng kiến thức môn Chuyên đề ASP.NET
vào một bài toán thực tế, đầy đủ các thành phần của một ứng dụng web thương mại.

### 2. Mục đích nghiên cứu
- Vận dụng mô hình MVC và các kỹ thuật của ASP.NET để xây dựng ứng dụng web.
- Thiết kế cơ sở dữ liệu quan hệ cho bài toán quản lý bán hàng.
- Xây dựng website hoàn chỉnh gồm phần khách hàng và phần quản trị.

### 3. Đối tượng và phạm vi nghiên cứu
- **Đối tượng:** quy trình bán trà sữa trực tuyến (sản phẩm, giỏ hàng, đơn hàng, người dùng).
- **Phạm vi:** website chạy trên nền ASP.NET MVC 5, CSDL SQL Server; tập trung
  các chức năng cốt lõi: hiển thị sản phẩm, giỏ hàng, đặt hàng, quản trị sản phẩm và đơn hàng.

---

## CHƯƠNG 1. TỔNG QUAN

### 1.1. Đặt vấn đề
Cửa hàng trà sữa truyền thống chỉ bán tại chỗ, khó quản lý sản phẩm và đơn hàng
khi số lượng tăng. Cần một hệ thống website cho phép khách hàng đặt hàng online
và giúp chủ cửa hàng quản lý tập trung.

### 1.2. Giải pháp đề xuất
Xây dựng website WebTraSua theo kiến trúc **MVC (Model – View – Controller)**:
- **Khách hàng:** duyệt sản phẩm theo thể loại, xem chi tiết, thêm vào giỏ hàng,
  đăng ký/đăng nhập, đặt hàng.
- **Quản trị viên:** đăng nhập trang admin, quản lý sản phẩm (thêm/sửa/xoá),
  quản lý thể loại – phân loại, xử lý đơn đặt hàng, cập nhật thông tin cửa hàng.

### 1.3. Công cụ và môi trường
- Visual Studio (C#), ASP.NET MVC 5.
- SQL Server + SQL Server Management Studio.
- Bootstrap, jQuery cho giao diện.

---

## CHƯƠNG 2. CƠ SỞ LÝ THUYẾT

### 2.1. Mô hình MVC trong ASP.NET
MVC tách ứng dụng thành 3 thành phần:
- **Model:** biểu diễn dữ liệu và nghiệp vụ (ở đây dùng LINQ to SQL `DataClasses1.dbml`).
- **View:** giao diện hiển thị (Razor `.cshtml`).
- **Controller:** tiếp nhận yêu cầu, xử lý và trả về View.

### 2.2. Truy xuất dữ liệu: LINQ to SQL & Entity Framework
Dự án dùng **LINQ to SQL** ánh xạ các bảng SQL Server thành lớp C#, kết hợp
**Entity Framework 6** cho tầng ASP.NET Identity. Truy vấn dữ liệu bằng LINQ
giúp mã nguồn ngắn gọn, an toàn kiểu.

### 2.3. ASP.NET Identity & OWIN
Quản lý đăng ký, đăng nhập, mã hoá mật khẩu khách hàng thông qua các bảng
`AspNetUsers`, `AspNetRoles`… trên nền OWIN.

### 2.4. Bootstrap và jQuery
Bootstrap 3 dựng giao diện responsive; jQuery và PagedList hỗ trợ tương tác và
phân trang danh sách sản phẩm.

---

## CHƯƠNG 3. PHÂN TÍCH VÀ THIẾT KẾ HỆ THỐNG

### 3.1. Yêu cầu chức năng
**Phía khách hàng:**
- Xem trang chủ, sản phẩm nổi bật.
- Xem sản phẩm theo thể loại, xem chi tiết.
- Thêm/sửa/xoá sản phẩm trong giỏ hàng.
- Đăng ký, đăng nhập, đặt hàng.

**Phía quản trị:**
- Đăng nhập quản trị.
- Quản lý sản phẩm, thể loại, phân loại.
- Quản lý đơn đặt hàng (thanh toán, giao hàng).
- Cập nhật logo, số điện thoại cửa hàng.

### 3.2. Thiết kế cơ sở dữ liệu
Cơ sở dữ liệu **`QuanLiTraSua`** gồm các bảng chính:

| Bảng | Ý nghĩa | Khoá chính |
|---|---|---|
| `ChiTietSanPham` | Sản phẩm (tên, giá, mô tả, hình, tồn kho) | MaSP |
| `TheLoaiSanPham` | Thể loại sản phẩm | MaTheLoai |
| `PhanLoaiSanPham` | Phân loại (bán chạy, món mới, khuyến mãi) | MaLoai |
| `KhachHang` | Khách hàng | MaKH |
| `DonDatHang` | Đơn đặt hàng | MaDonHang |
| `ChiTietDonHang` | Chi tiết đơn hàng | (MaDonHang, MaSP) |
| `Admin` | Tài khoản quản trị | User_Admin |
| `CapNhat_LogoCuaHang`, `CapNhat_SdtCuaHang` | Cấu hình cửa hàng | – |

**Quan hệ chính:**
- `TheLoaiSanPham` 1 – n `ChiTietSanPham`
- `PhanLoaiSanPham` 1 – n `ChiTietSanPham`
- `KhachHang` 1 – n `DonDatHang`
- `DonDatHang` 1 – n `ChiTietDonHang` n – 1 `ChiTietSanPham`

*(Script tạo CSDL đầy đủ: xem `QuanLiTraSua.sql` ở thư mục gốc.)*

### 3.3. Thiết kế chức năng (Controllers)
| Controller | Chức năng |
|---|---|
| `HomeController` | Trang chủ, sản phẩm nổi bật |
| `WebTraSuaController` | Danh sách/chi tiết sản phẩm theo thể loại |
| `GioHangController` | Giỏ hàng, đặt hàng |
| `AccountController`, `ManageController`, `NguoiDungController` | Tài khoản khách hàng |
| `AdminController` | Quản trị sản phẩm, thể loại, đơn hàng |

---

## CHƯƠNG 4. KẾT QUẢ THỰC HIỆN

Website đã hoàn thành các chức năng:

1. **Trang chủ:** hiển thị banner slide và sản phẩm nổi bật.
2. **Danh sách sản phẩm:** lọc theo thể loại (trà sữa, trà trái cây, cà phê, đá xay, topping), có phân trang.
3. **Chi tiết sản phẩm:** hình ảnh, mô tả, giá bán.
4. **Giỏ hàng:** thêm/xoá/cập nhật số lượng, tính tổng tiền.
5. **Tài khoản:** đăng ký, đăng nhập, đổi mật khẩu.
6. **Đặt hàng:** tạo đơn hàng và chi tiết đơn từ giỏ hàng.
7. **Trang quản trị:** đăng nhập admin, CRUD sản phẩm (upload nhiều hình),
   quản lý thể loại/phân loại, quản lý đơn đặt hàng, cập nhật thông tin cửa hàng.

**Tài khoản demo:** admin/admin123 (quản trị), khachhang/123456 (khách hàng).

*(Ảnh chụp màn hình các giao diện được chèn tại đây khi xuất bản báo cáo Word/PDF.)*

---

## CHƯƠNG 5. KẾT LUẬN VÀ HƯỚNG PHÁT TRIỂN

### 5.1. Kết luận
Đồ án đã xây dựng thành công website bán trà sữa với đầy đủ quy trình mua bán
trực tuyến cơ bản và trang quản trị. Qua đó vận dụng được kiến thức ASP.NET MVC,
LINQ to SQL, SQL Server và thiết kế giao diện web.

### 5.2. Hạn chế
- Chưa tích hợp cổng thanh toán trực tuyến thực tế.
- Chức năng thống kê – báo cáo doanh thu còn đơn giản.

### 5.3. Hướng phát triển
- Tích hợp thanh toán (VNPay, Momo).
- Thêm đánh giá sản phẩm, mã giảm giá.
- Xây dựng bảng điều khiển thống kê doanh thu cho quản trị.
- Phát triển phiên bản responsive/mobile tối ưu hơn.

---

## TÀI LIỆU THAM KHẢO

[1] Bộ môn Công nghệ thông tin, *Tài liệu giảng dạy môn Chuyên đề ASP.NET*, Trường Đại học Trà Vinh.

[2] Matthew MacDonald, Mario Szpuszta, *Pro ASP.NET 3.5 in C# 2008*, Apress, 2008.

[3] Microsoft, *ASP.NET MVC Documentation*, https://learn.microsoft.com/aspnet/mvc

[4] Microsoft, *LINQ to SQL / Entity Framework Documentation*, https://learn.microsoft.com/ef

---

## LIÊN HỆ

- **Họ tên:** Đinh Công Hiến
- **Số điện thoại:** 0933261041
- **Địa chỉ:** TP. Hồ Chí Minh (TPHCM)

---

> *Ghi chú: File báo cáo này viết bằng Markdown để tiện chỉnh sửa và xem trên GitHub.
> Khi nộp, có thể mở bằng Word (Copy nội dung) hoặc xuất PDF, chèn thêm ảnh chụp
> màn hình các chức năng để hoàn thiện theo mẫu trình bày của môn học.*
