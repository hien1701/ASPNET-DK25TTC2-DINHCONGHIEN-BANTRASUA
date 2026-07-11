/* ============================================================
   CƠ SỞ DỮ LIỆU: QuanLiTraSua
   Website Bán Trà Sữa (Trà Sữa 3AE) - ASP.NET MVC 5
   Tác giả : Đinh Công Hiến - Lớp DK25TTC2
   ------------------------------------------------------------
   Cách dùng:
     1. Mở SQL Server Management Studio (SSMS)
     2. Mở file này -> Execute (F5) để tạo CSDL + dữ liệu mẫu
     3. Cập nhật chuỗi kết nối "QuanLiTraSuaConnectionString"
        trong src/WebTraSua/Web.config cho khớp Data Source.
   ============================================================ */

IF DB_ID('QuanLiTraSua') IS NOT NULL
BEGIN
    ALTER DATABASE QuanLiTraSua SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE QuanLiTraSua;
END
GO

CREATE DATABASE QuanLiTraSua;
GO
USE QuanLiTraSua;
GO

/* ---------- ASP.NET Identity ---------- */
CREATE TABLE dbo.AspNetRoles (
    Id   NVARCHAR(128) NOT NULL PRIMARY KEY,
    Name NVARCHAR(256) NOT NULL
);
GO
CREATE TABLE dbo.AspNetUsers (
    Id                   NVARCHAR(128) NOT NULL PRIMARY KEY,
    Email                NVARCHAR(256) NULL,
    EmailConfirmed       BIT           NOT NULL DEFAULT 0,
    PasswordHash         NVARCHAR(MAX) NULL,
    SecurityStamp        NVARCHAR(MAX) NULL,
    PhoneNumber          NVARCHAR(MAX) NULL,
    PhoneNumberConfirmed BIT           NOT NULL DEFAULT 0,
    TwoFactorEnabled     BIT           NOT NULL DEFAULT 0,
    LockoutEndDateUtc    DATETIME      NULL,
    LockoutEnabled       BIT           NOT NULL DEFAULT 0,
    AccessFailedCount    INT           NOT NULL DEFAULT 0,
    UserName             NVARCHAR(256) NOT NULL
);
GO
CREATE TABLE dbo.AspNetUserClaims (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    UserId NVARCHAR(128) NOT NULL,
    ClaimType NVARCHAR(MAX) NULL,
    ClaimValue NVARCHAR(MAX) NULL,
    CONSTRAINT FK_AspNetUserClaims_AspNetUsers FOREIGN KEY (UserId)
        REFERENCES dbo.AspNetUsers(Id) ON DELETE CASCADE
);
GO
CREATE TABLE dbo.AspNetUserLogins (
    LoginProvider NVARCHAR(128) NOT NULL,
    ProviderKey NVARCHAR(128) NOT NULL,
    UserId NVARCHAR(128) NOT NULL,
    CONSTRAINT PK_AspNetUserLogins PRIMARY KEY (LoginProvider, ProviderKey, UserId),
    CONSTRAINT FK_AspNetUserLogins_AspNetUsers FOREIGN KEY (UserId)
        REFERENCES dbo.AspNetUsers(Id) ON DELETE CASCADE
);
GO
CREATE TABLE dbo.AspNetUserRoles (
    UserId NVARCHAR(128) NOT NULL,
    RoleId NVARCHAR(128) NOT NULL,
    CONSTRAINT PK_AspNetUserRoles PRIMARY KEY (UserId, RoleId),
    CONSTRAINT FK_AspNetUserRoles_AspNetUsers FOREIGN KEY (UserId)
        REFERENCES dbo.AspNetUsers(Id) ON DELETE CASCADE,
    CONSTRAINT FK_AspNetUserRoles_AspNetRoles FOREIGN KEY (RoleId)
        REFERENCES dbo.AspNetRoles(Id) ON DELETE CASCADE
);
GO
CREATE TABLE dbo.[__MigrationHistory] (
    MigrationId NVARCHAR(150) NOT NULL,
    ContextKey NVARCHAR(300) NOT NULL,
    Model VARBINARY(MAX) NOT NULL,
    ProductVersion NVARCHAR(32) NOT NULL,
    CONSTRAINT PK___MigrationHistory PRIMARY KEY (MigrationId, ContextKey)
);
GO

/* ---------- Quản trị & cấu hình cửa hàng ---------- */
CREATE TABLE dbo.Admin (
    User_Admin  VARCHAR(30) NOT NULL PRIMARY KEY,
    Pass_Admin  VARCHAR(30) NOT NULL,
    HoTen_Admin NVARCHAR(50) NULL
);
GO
CREATE TABLE dbo.CapNhat_LogoCuaHang ( LogoCuaHang VARCHAR(50) NULL );
GO
CREATE TABLE dbo.CapNhat_SdtCuaHang ( SdtCuaHang VARCHAR(50) NULL );
GO

/* ---------- Danh mục sản phẩm ---------- */
CREATE TABLE dbo.TheLoaiSanPham (
    MaTheLoai  INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TenTheLoai NVARCHAR(30) NULL,
    Logo       VARCHAR(50)  NULL
);
GO
CREATE TABLE dbo.PhanLoaiSanPham (
    MaLoai INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Loai   NVARCHAR(30) NULL
);
GO
CREATE TABLE dbo.ChiTietSanPham (
    MaSP        INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    NgayCapNhat DATETIME      NULL,
    TenSP       NVARCHAR(50)  NOT NULL,
    NguyenLieu  NVARCHAR(30)  NULL,
    GiaBan      DECIMAL(18,3) NULL,
    MoTa        NTEXT         NULL,
    AnhBia      VARCHAR(40)   NULL,
    SlTon       INT           NULL,
    MaTheLoai   INT           NULL,
    MaLoai      INT           NULL,
    Anh_1       VARCHAR(50)   NULL,
    Anh_2       VARCHAR(50)   NULL,
    Anh_3       VARCHAR(50)   NULL,
    CONSTRAINT FK_ChiTietSanPham_TheLoaiSanPham FOREIGN KEY (MaTheLoai)
        REFERENCES dbo.TheLoaiSanPham(MaTheLoai),
    CONSTRAINT FK_ChiTietSanPham_PhanLoaiSanPham FOREIGN KEY (MaLoai)
        REFERENCES dbo.PhanLoaiSanPham(MaLoai)
);
GO

/* ---------- Khách hàng & đơn hàng ---------- */
CREATE TABLE dbo.KhachHang (
    MaKH INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    HoTen NVARCHAR(50) NULL,
    TaiKhoan VARCHAR(50) NULL,
    MatKhau VARCHAR(50) NULL,
    Email VARCHAR(50) NULL,
    DiaChi_KH NVARCHAR(70) NULL,
    DienThoai_KH VARCHAR(13) NULL
);
GO
CREATE TABLE dbo.DonDatHang (
    MaDonHang INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    DaThanhToan BIT NULL,
    TinhTrangGiaoHang BIT NULL,
    NgayDat DATETIME NULL,
    NgayGiao DATETIME NULL,
    MaKH INT NULL,
    CONSTRAINT FK_DonDatHang_KhachHang FOREIGN KEY (MaKH) REFERENCES dbo.KhachHang(MaKH)
);
GO
CREATE TABLE dbo.ChiTietDonHang (
    MaDonHang INT NOT NULL,
    MaSP INT NOT NULL,
    SlMua INT NULL,
    DonGia DECIMAL(18,3) NULL,
    CONSTRAINT PK_ChiTietDonHang PRIMARY KEY (MaDonHang, MaSP),
    CONSTRAINT FK_ChiTietDonHang_DonDatHang FOREIGN KEY (MaDonHang) REFERENCES dbo.DonDatHang(MaDonHang),
    CONSTRAINT FK_ChiTietDonHang_ChiTietSanPham FOREIGN KEY (MaSP) REFERENCES dbo.ChiTietSanPham(MaSP)
);
GO

/* ============================================================
   DỮ LIỆU MẪU (thông tin của cửa hàng Trà Sữa 3AE / Đinh Công Hiến)
   ============================================================ */

-- Tài khoản quản trị (đăng nhập trang Admin)
INSERT INTO dbo.Admin (User_Admin, Pass_Admin, HoTen_Admin)
VALUES ('admin', 'admin123', N'Đinh Công Hiến');
GO

-- Cấu hình cửa hàng
INSERT INTO dbo.CapNhat_SdtCuaHang (SdtCuaHang) VALUES ('0933261041');
INSERT INTO dbo.CapNhat_LogoCuaHang (LogoCuaHang) VALUES ('Logo_Webtrasua.PNG');
GO

-- Thể loại (MaTheLoai 1..5)
INSERT INTO dbo.TheLoaiSanPham (TenTheLoai, Logo) VALUES
    (N'Trà sữa',      'logo_MilkTea.png'),
    (N'Trà trái cây', 'logo_Tea.png'),
    (N'Cà phê',       'logo_Special.png'),
    (N'Đá xay',       'logo_Blended.png'),
    (N'Topping',      'logo_Nuocdongchai.png');
GO

-- Phân loại (MaLoai 1..3)
INSERT INTO dbo.PhanLoaiSanPham (Loai) VALUES (N'Bán chạy'), (N'Món mới'), (N'Khuyến mãi');
GO

-- Sản phẩm (AnhBia trỏ tới hình có sẵn trong src/WebTraSua/images)
INSERT INTO dbo.ChiTietSanPham (NgayCapNhat, TenSP, NguyenLieu, GiaBan, MoTa, AnhBia, SlTon, MaTheLoai, MaLoai) VALUES
(GETDATE(), N'Trà sữa trân châu đường đen', N'Trà, sữa, trân châu', 35000, N'Trà sữa béo ngậy cùng trân châu đường đen dẻo thơm.', '3b.png', 100, 1, 1),
(GETDATE(), N'Matcha latte trân châu',      N'Matcha, sữa, trân châu', 38000, N'Matcha thanh mát kết hợp lớp sữa béo nhẹ.', '3d.png', 90, 1, 2),
(GETDATE(), N'Cà phê sữa đá',               N'Cà phê, sữa',         30000, N'Cà phê phin truyền thống đậm đà, thêm sữa đặc.', '3a.png', 80, 3, 1),
(GETDATE(), N'Cà phê đen đá',               N'Cà phê',              28000, N'Cà phê nguyên chất, đắng nhẹ, hậu ngọt.', '3c.png', 80, 3, 3),
(GETDATE(), N'Chocolate đá xay',            N'Chocolate, sữa, đá',  40000, N'Vị ngọt đắng béo của chocolate hòa quyện đá xay mát lạnh.', '1a.png', 70, 4, 2),
(GETDATE(), N'Matcha đá xay',               N'Matcha, sữa, đá',     40000, N'Matcha xay mịn, mát lạnh, thơm trà xanh.', '1b.png', 70, 4, 1),
(GETDATE(), N'Trà đào đá xay',              N'Trà, đào, đá',        42000, N'Trà đào xay đá sảng khoái, chua ngọt hài hòa.', '1c.png', 70, 4, 1),
(GETDATE(), N'Chanh dây đá xay',            N'Chanh dây, đá',       40000, N'Chanh dây tươi xay đá, vị chua thanh mát.', '1d.png', 70, 4, 3),
(GETDATE(), N'Trà đào cam sả',              N'Trà, đào, cam, sả',   40000, N'Trà trái cây giải nhiệt với đào miếng, cam và sả.', '1e.png', 85, 2, 1),
(GETDATE(), N'Trà vải',                     N'Trà, vải',            38000, N'Vị vải ngọt dịu, thơm mát.', '2a.png', 85, 2, 2),
(GETDATE(), N'Trà ổi hồng',                 N'Trà, ổi hồng',        38000, N'Trà ổi hồng thơm nhẹ, màu sắc bắt mắt.', '2b.png', 85, 2, 1),
(GETDATE(), N'Trà dâu',                     N'Trà, dâu',            38000, N'Trà dâu chua ngọt, hương thơm quyến rũ.', '2c.png', 85, 2, 3),
(GETDATE(), N'Trà cam',                     N'Trà, cam',            38000, N'Trà cam tươi mát, bổ sung vitamin C.', '2d.png', 85, 2, 2),
(GETDATE(), N'Trà chanh mật ong',           N'Trà, chanh, mật ong', 35000, N'Trà chanh mật ong thanh mát, dễ uống.', '2e.png', 90, 2, 1),
(GETDATE(), N'Hồng trà đác',                N'Hồng trà, hạt đác',   36000, N'Hồng trà thanh mát cùng hạt đác giòn ngọt.', '2f.png', 90, 2, 3);
GO

-- Khách hàng mẫu (thông tin ẩn danh, không phải dữ liệu cá nhân thật)
INSERT INTO dbo.KhachHang (HoTen, TaiKhoan, MatKhau, Email, DiaChi_KH, DienThoai_KH)
VALUES (N'Nguyễn Văn An', 'khachhang', '123456', 'khachhang@example.com',
        N'TP. Hồ Chí Minh', '0900000000');
GO

PRINT N'>>> Da tao xong CSDL QuanLiTraSua va du lieu mau (Tra Sua 3AE).';
GO
