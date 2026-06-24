/* ============================================================
   CƠ SỞ DỮ LIỆU: QuanLiTraSua
   Website Bán Trà Sữa - ASP.NET MVC 5
   Tác giả : Đinh Công Hiến
   Lớp     : DK25TTC2
   ------------------------------------------------------------
   Cách dùng:
     1. Mở SQL Server Management Studio (SSMS)
     2. Mở file này -> Execute (F5) để tạo CSDL + dữ liệu mẫu
     3. Cập nhật chuỗi kết nối "QuanLiTraSuaConnectionString"
        trong src/WebTraSua/Web.config cho khớp Data Source.
   (Hoặc restore trực tiếp từ src/Database/QuanLiTraSua.bak)
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
    Id         INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    UserId     NVARCHAR(128) NOT NULL,
    ClaimType  NVARCHAR(MAX) NULL,
    ClaimValue NVARCHAR(MAX) NULL,
    CONSTRAINT FK_AspNetUserClaims_AspNetUsers FOREIGN KEY (UserId)
        REFERENCES dbo.AspNetUsers(Id) ON DELETE CASCADE
);
GO

CREATE TABLE dbo.AspNetUserLogins (
    LoginProvider NVARCHAR(128) NOT NULL,
    ProviderKey   NVARCHAR(128) NOT NULL,
    UserId        NVARCHAR(128) NOT NULL,
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
    MigrationId    NVARCHAR(150) NOT NULL,
    ContextKey     NVARCHAR(300) NOT NULL,
    Model          VARBINARY(MAX) NOT NULL,
    ProductVersion NVARCHAR(32)  NOT NULL,
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

CREATE TABLE dbo.CapNhat_LogoCuaHang (
    LogoCuaHang VARCHAR(50) NULL
);
GO

CREATE TABLE dbo.CapNhat_SdtCuaHang (
    SdtCuaHang VARCHAR(50) NULL
);
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
    MaKH        INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    HoTen       NVARCHAR(50) NULL,
    TaiKhoan    VARCHAR(50)  NULL,
    MatKhau     VARCHAR(50)  NULL,
    Email       VARCHAR(50)  NULL,
    DiaChi_KH   NVARCHAR(70) NULL,
    DienThoai_KH VARCHAR(13) NULL
);
GO

CREATE TABLE dbo.DonDatHang (
    MaDonHang         INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    DaThanhToan       BIT      NULL,
    TinhTrangGiaoHang BIT      NULL,
    NgayDat           DATETIME NULL,
    NgayGiao          DATETIME NULL,
    MaKH              INT      NULL,
    CONSTRAINT FK_DonDatHang_KhachHang FOREIGN KEY (MaKH)
        REFERENCES dbo.KhachHang(MaKH)
);
GO

CREATE TABLE dbo.ChiTietDonHang (
    MaDonHang INT NOT NULL,
    MaSP      INT NOT NULL,
    SlMua     INT NULL,
    DonGia    DECIMAL(18,3) NULL,
    CONSTRAINT PK_ChiTietDonHang PRIMARY KEY (MaDonHang, MaSP),
    CONSTRAINT FK_ChiTietDonHang_DonDatHang FOREIGN KEY (MaDonHang)
        REFERENCES dbo.DonDatHang(MaDonHang),
    CONSTRAINT FK_ChiTietDonHang_ChiTietSanPham FOREIGN KEY (MaSP)
        REFERENCES dbo.ChiTietSanPham(MaSP)
);
GO

/* ============================================================
   DỮ LIỆU MẪU
   ============================================================ */

-- Tài khoản quản trị (đăng nhập trang Admin)
INSERT INTO dbo.Admin (User_Admin, Pass_Admin, HoTen_Admin)
VALUES ('admin', 'admin123', N'Đinh Công Hiến');
GO

-- Cấu hình cửa hàng
INSERT INTO dbo.CapNhat_SdtCuaHang (SdtCuaHang) VALUES ('0933261041');
INSERT INTO dbo.CapNhat_LogoCuaHang (LogoCuaHang) VALUES ('logo.png');
GO

-- Thể loại sản phẩm (MaTheLoai 1..5)
INSERT INTO dbo.TheLoaiSanPham (TenTheLoai, Logo) VALUES
    (N'Trà sữa',        'tl_trasua.png'),
    (N'Trà trái cây',   'tl_trahoaqua.png'),
    (N'Cà phê',         'tl_caphe.png'),
    (N'Đá xay',         'tl_daxay.png'),
    (N'Topping',        'tl_topping.png');
GO

-- Phân loại (MaLoai 1..3)
INSERT INTO dbo.PhanLoaiSanPham (Loai) VALUES
    (N'Bán chạy'),
    (N'Món mới'),
    (N'Khuyến mãi');
GO

-- Sản phẩm mẫu
INSERT INTO dbo.ChiTietSanPham
    (NgayCapNhat, TenSP, NguyenLieu, GiaBan, MoTa, AnhBia, SlTon, MaTheLoai, MaLoai)
VALUES
    (GETDATE(), N'Trà sữa trân châu đường đen', N'Trà, sữa, trân châu', 35000,
        N'Trà sữa béo ngậy kết hợp trân châu đường đen dẻo thơm.', 'sp1.jpg', 100, 1, 1),
    (GETDATE(), N'Trà sữa Oolong nướng',        N'Trà Oolong, sữa',    32000,
        N'Hương Oolong nướng đậm vị, hậu ngọt thanh.',              'sp2.jpg', 100, 1, 1),
    (GETDATE(), N'Trà đào cam sả',              N'Trà, đào, cam, sả',  40000,
        N'Trà trái cây giải nhiệt với đào miếng và cam tươi.',      'sp3.jpg', 80,  2, 2),
    (GETDATE(), N'Trà vải hồng',                N'Trà, vải',           38000,
        N'Vị vải ngọt dịu, thơm mát, phù hợp mùa hè.',              'sp4.jpg', 80,  2, 1),
    (GETDATE(), N'Cà phê muối kem',             N'Cà phê, kem, muối',  30000,
        N'Cà phê phin truyền thống phủ lớp kem muối béo mặn.',      'sp5.jpg', 60,  3, 2),
    (GETDATE(), N'Bạc xỉu đá xay',              N'Cà phê, sữa, đá',    35000,
        N'Bạc xỉu xay mịn mát lạnh, ngọt vừa.',                     'sp6.jpg', 60,  4, 3);
GO

-- Khách hàng mẫu
INSERT INTO dbo.KhachHang (HoTen, TaiKhoan, MatKhau, Email, DiaChi_KH, DienThoai_KH)
VALUES (N'Nguyễn Văn A', 'khachhang', '123456', 'khacha@gmail.com',
        N'123 Nguyễn Trãi, Q.1, TP.HCM', '0909123456');
GO

PRINT N'>>> Da tao xong CSDL QuanLiTraSua va du lieu mau.';
GO
