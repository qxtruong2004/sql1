USE master
GO
--Tạo cơ sở dữ liệu QuanLyBanHang
CREATE DATABASE QuanLyBanHang
-- kết nối với CSDL QuanLyBanHang
GO
USE QuanLyBanHang
GO
-- Tạo bảng NHACC
CREATE TABLE NHACC
(
	MANCC char(4) CONSTRAINT pk_NHACC PRIMARY KEY
	CONSTRAINT chk_MANCC CHECK(MANCC LIKE 'S[0-9][0-9][0-9]'),
	TenNCC nvarchar(50) CONSTRAINT unqTenNCC UNIQUE,
	DiaChi nvarchar(100),
	DienThoai varchar(12)
)
GO
INSERT INTO NhaCC(MaNCC, TenNCC, DiaChi, DienThoai)
VALUES ('S001','Samsung',N'Hà nội','123456'),
('S002','LG',N'Huế','234567'),
('S003','Sharp',N'Đà nẵng','345678'),
('S004','Sony',N'HCM',null)
GO
SELECT * FROM NHACC
-- Tạo bảng HANG
CREATE TABLE HANG
(
	MaHang char(4) PRIMARY KEY,
	TenHang nvarchar(50) NOT NULL,
	DonGia int,
	SoLuongCo int,
	MaNCC char(4),
	CONSTRAINT fkMaCC_NHACC FOREIGN KEY (MaNCC) REFERENCES NHACC(MaNCC) ON UPDATE CASCADE ON DELETE CASCADE
)
GO
INSERT INTO HANG(MaHang,TenHang,DonGia,SoLuongCo,MaNCC)
 VALUES('P001',N'Tivi LG 49UH600T',10,100,'S002'),
 ('P002',N'Tivi Sony 49X7000D',20,200,'S004'),
 ('P003',N'DVD Samsung DVD-E360/XV',30,300,'S001'),
 ('P004',N'DVD Sony Midi 888HD',40,400,'S004'),
 ('P005',N'Dàn âm thanh LG ARX5500',50,500,'S002'),
 ('P006',N'Đầu thu kỹ thuật số T202-HD',60,600,'S002')

GO
-- tạo bảng PHIEU_XUAT
CREATE TABLE PHIEU_XUAT
(
	SoPhieu int IDENTITY(1,1),
	NgayXuat date CONSTRAINT defNgayXuat DEFAULT getdate(),
	MaCuaHang char(4) NOT NULL,
	CONSTRAINT pk_PHIEU_XUAT PRIMARY KEY (SoPhieu)
)
GO
INSERT INTO PHIEU_XUAT(MaCuaHang)
VALUES('A001'),('A002'),('A003'),('A004')
GO
INSERT INTO PHIEU_XUAT(MaCuaHang) VALUES ('A001'),('A002')
-- tạo bảng DONG_PHIEU_XUAT
CREATE TABLE DONG_PHIEU_XUAT
(
	SoPhieu int,
	MaHang char(4),
	SoLuongXuat int NOT NULL,
	CONSTRAINT pk_DONG_PHIEU_XUAT PRIMARY KEY (SoPhieu,MaHang),
	CONSTRAINT fkMaHang_Hang FOREIGN KEY (MaHang) REFERENCES HANG(MaHang) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fkSoPhieu_PHIEU_XUAT FOREIGN KEY (SoPhieu) REFERENCES PHIEU_XUAT(SoPhieu)ON UPDATE CASCADE ON DELETE CASCADE
)
GO
--
INSERT INTO DONG_PHIEU_XUAT(SoPhieu,MaHang,SoLuongXuat)
VALUES(1,'P001',3),(1,'P002',2),(2,'P004',3),(2,'P001',1),
(3,'P002',2),(4,'P005',3),(5,'P001',8), 
(6,'P003',4),(6,'P004',5),(6,'P005',6)

select * from NHACC
select * from PHIEU_XUAT
select * from DONG_PHIEU_XUAT

drop database QuanLyBanHang1
USE master