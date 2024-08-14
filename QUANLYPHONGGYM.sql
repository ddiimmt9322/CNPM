--use master 
--DROP DATABASE QUANLYPHONGGYM
CREATE DATABASE QUANLYPHONGGYM
go
USE QUANLYPHONGGYM
-------------
CREATE TABLE TAIKHOAN
(
Sdt varchar(20) PRIMARY KEY,
Password varchar(20),
)
------------
CREATE TABLE NHANVIEN
(
	MaNV varchar(20) primary key,
	TenNV nvarchar(50),
	Email varchar(50),
	DiaChi nvarchar(50),
	NgaySinh date,
	GioiTinh nvarchar(10),
	Luong int,
	Sdt varchar(20) references TAIKHOAN(Sdt),
	ChucVu nvarchar(50),
	AnhNV image
)
------------
CREATE TABLE KHACHHANG
(
	MaKH varchar(20) primary key,
	TenKH nvarchar(50),
	Email varchar(50),
	GioiTinh nvarchar(50),
	NgaySinh date,
	DiaChi nvarchar(50),
	Sdt varchar(20) references TAIKHOAN(Sdt),
	AnhKH image
)
-----------
CREATE TABLE DICHVU
(
MaDV varchar(20) PRIMARY KEY,
TenDV nvarchar(50),
Gia int,
Phong nvarchar(100),
Ngay date, 
LichTap nvarchar(100),
AnhDV image
)
----------
-----------
CREATE TABLE HOADON
(
MaHD varchar(20) PRIMARY KEY,
MaKH varchar(20)FOREIGN KEY REFERENCES KHACHHANG(MAKH),
MaNV varchar(20)FOREIGN KEY REFERENCES NHANVIEN(MaNV),
Phong nvarchar(100),
MaDV varchar(20)FOREIGN KEY REFERENCES DICHVU(MADV),
TongTien int,
Ngay date,
SoLuong int
)
------------
-----------
CREATE TABLE THIETBI
(
MaTB varchar(20) PRIMARY KEY,
TenTB nvarchar(50),
SoLuong int,
TinhTrang nvarchar(50),
NgayNhap date,
AnhTB image
)

------------

CREATE TABLE THONGKE

(
MaTK varchar(20) PRIMARY KEY,
NgayLap date,
MaHD varchar(20) FOREIGN KEY REFERENCES HOADON(MaHD),
MaDV varchar(20),
TenDV nvarchar(50),
SoLuongDat int
)
UPDATE NHANVIEN set TenNV = 'Quynh',Email = 'Quynh', DiaChi = 'Quynh', NgaySinh = '02-21-2012 6:10:00 PM', GioiTinh = 'nam' where MaNV ='NV001'

-----STORE PROCEDURE
---drop procedure InsertNHANVIEN
go
create procedure InsertNHANVIEN(
	@TenNV nvarchar(50),
	@Email varchar(50),
	@DiaChi nvarchar(50),
	@NgaySinh date,
	@GioiTinh nvarchar(10),
	@Luong int,
	@Sdt varchar(20),
	@ChucVu nvarchar(50),
	@AnhNV image
	)
	As
	if not exists (select MaNV from NHANVIEN)
		Begin 
			declare @MaNV varchar(20);
			set @MaNV = 'NV001'
			if not exists (select Sdt from TAIKHOAN where Sdt=@Sdt)
				begin
					Insert into TAIKHOAN values(@Sdt,'NV123@@')
					Insert into NHANVIEN values(@MaNV,@TenNV,@Email,@DiaChi,@NgaySinh,@GioiTinh,@Luong,@Sdt,@ChucVu,@AnhNV)
				end
		End
	else
		begin	
			declare @lastMaNV varchar(20);
			set @lastMaNV = (select top 1 MaNV as tmp from NHANVIEN order by MaNV desc);
			declare @newMaNV varchar(20)
			declare @numMaNV int
			set @numMaNV = CAST(RIGHT(@lastMaNV, LEN(@lastMaNV)-2) AS INT)
			if (@numMaNV<999) and (@numMaNV>=99)
				set @newMaNV = 'NV' + CAST(@numMaNV + 1 as varchar)	
			if (@numMaNV<99) and (@numMaNV>=9)
				set @newMaNV = 'NV0' + CAST(@numMaNV + 1 as varchar)	
			if (@numMaNV<9)
				set @newMaNV = 'NV00' + CAST(@numMaNV + 1 as varchar)
			if not exists (select TAIKHOAN.Sdt from NHANVIEN, TAIKHOAN where TAIKHOAN.Sdt=@Sdt)
				begin
					Insert into TAIKHOAN values(@Sdt,'NV123@@')
					Insert into NHANVIEN values(@newMaNV,@TenNV,@Email,@DiaChi,@NgaySinh,@GioiTinh,@Luong,@Sdt,@ChucVu,@AnhNV)
				end
		end
go
delete from NHANVIEN
exec InsertNHANVIEN @TenNV=N'Nhật Quỳnh',@Email='phamnhatquynh1207@gmail.com',@DiaChi=N'Quảng Nam',@NgaySinh='12/7/2003',@GioiTinh=N'Nữ',@LUONG=100000000,@Sdt='0354434737',@ChucVu=N'Phó giám đốc', @AnhNV=''
exec InsertNHANVIEN @TenNV=N'Nhật Quỳnh',@Email='phamnhatquynh1207@gmail.com',@DiaChi=N'Quảng Nam',@NgaySinh='12/7/2003',@GioiTinh=N'Nữ',@LUONG=100000000,@Sdt='088888889',@ChucVu=N'Phó giám đốc', @AnhNV=''
exec InsertNHANVIEN @TenNV=N'Nhật Quỳnh',@Email='phamnhatquynh1207@gmail.com',@DiaChi=N'Quảng Nam',@NgaySinh='12/7/2003',@GioiTinh=N'Nữ',@LUONG=100000000,@Sdt='088888888',@ChucVu=N'Phó giám đốc', @AnhNV=''
exec InsertNHANVIEN @TenNV=N'Nhật Quỳnh',@Email='phamnhatquynh1207@gmail.com',@DiaChi=N'Quảng Nam',@NgaySinh='12/7/2003',@GioiTinh=N'Nữ',@LUONG=100000000,@Sdt='088888887',@ChucVu=N'Phó giám đốc', @AnhNV=''
exec InsertNHANVIEN @TenNV=N'Nhật Quỳnh',@Email='phamnhatquynh1207@gmail.com',@DiaChi=N'Quảng Nam',@NgaySinh='12/7/2003',@GioiTinh=N'Nữ',@LUONG=100000000,@Sdt='088888886',@ChucVu=N'Phó giám đốc', @AnhNV=''
exec InsertNHANVIEN @TenNV=N'Nhật Quỳnh',@Email='phamnhatquynh1207@gmail.com',@DiaChi=N'Quảng Nam',@NgaySinh='12/7/2003',@GioiTinh=N'Nữ',@LUONG=100000000,@Sdt='088888885',@ChucVu=N'Phó giám đốc', @AnhNV=''
exec InsertNHANVIEN @TenNV=N'Nhật Quỳnh',@Email='phamnhatquynh1207@gmail.com',@DiaChi=N'Quảng Nam',@NgaySinh='12/7/2003',@GioiTinh=N'Nữ',@LUONG=100000000,@Sdt='088888884',@ChucVu=N'Phó giám đốc', @AnhNV=''
exec InsertNHANVIEN @TenNV=N'Nhật Quỳnh',@Email='phamnhatquynh1207@gmail.com',@DiaChi=N'Quảng Nam',@NgaySinh='12/7/2003',@GioiTinh=N'Nữ',@LUONG=100000000,@Sdt='088888883',@ChucVu=N'Phó giám đốc', @AnhNV=''
exec InsertNHANVIEN @TenNV=N'Nhật Quỳnh',@Email='phamnhatquynh1207@gmail.com',@DiaChi=N'Quảng Nam',@NgaySinh='12/7/2003',@GioiTinh=N'Nữ',@LUONG=100000000,@Sdt='088888882',@ChucVu=N'Phó giám đốc', @AnhNV=''
exec InsertNHANVIEN @TenNV=N'Nhật Quỳnh',@Email='phamnhatquynh1207@gmail.com',@DiaChi=N'Quảng Nam',@NgaySinh='12/7/2003',@GioiTinh=N'Nữ',@LUONG=100000000,@Sdt='088888881',@ChucVu=N'Phó giám đốc', @AnhNV=''
exec InsertNHANVIEN @TenNV=N'Nhật Quỳnh',@Email='phamnhatquynh1207@gmail.com',@DiaChi=N'Quảng Nam',@NgaySinh='12/7/2003',@GioiTinh=N'Nữ',@LUONG=100000000,@Sdt='088888880',@ChucVu=N'Phó giám đốc', @AnhNV=''
exec InsertNHANVIEN @TenNV=N'Nhật Quỳnh',@Email='phamnhatquynh1207@gmail.com',@DiaChi=N'Quảng Nam',@NgaySinh='12/7/2003',@GioiTinh=N'Nữ',@LUONG=100000000,@Sdt='088888889',@ChucVu=N'Phó giám đốc', @AnhNV=''
select * from NHANVIEN
select * from TAIKHOAN

-- Insert HoaDon
CREATE PROCEDURE InsertHoaDon
    @MaKH varchar(20),
    @MaNV varchar(20),
    @Phong varchar(100),
    @MaDV varchar(20),
    @TongTien int,
    @Ngay date,
    @SoLuong int
AS
BEGIN
    DECLARE @MaHD varchar(20)
    DECLARE @NextNumber int

    -- Tìm số HD cuối cùng trong CSDL
    SELECT TOP 1 @MaHD = MaHD
    FROM HOADON
    ORDER BY MaHD DESC

    -- Lấy phần số của mã HD cuối cùng
    SET @NextNumber = CONVERT(INT,RIGHT(@MaHD,3)) + 1

    -- Định dạng lại số và ghép với prefix 'HD'
    SET @MaHD = 'HD' + RIGHT('000' + CONVERT(VARCHAR(3), @NextNumber), 3)

    -- Insert dữ liệu mới vào bảng HoaDon
    INSERT INTO HOADON (MaHD, MaKH, MaNV, Phong, MaDV, TongTien, Ngay, SoLuong)
    VALUES (@MaHD, @MaKH, @MaNV, @Phong, @MaDV, @TongTien, @Ngay, @SoLuong)
END

drop procedure InsertHoaDon

EXEC InsertHoaDon 'MaKH001', 'MaNV001', 'Cong Hoa', 'MaDV001', 1000000, '2023-05-19', 1

--drop procedure InsertKHACHHANG
go
create procedure InsertKHACHHANG(
	@TenKH nvarchar(50),
	@Email varchar(50),
	@GioiTinh nvarchar(50),
	@NgaySinh date,
	@DiaChi nvarchar(50),
	@Sdt varchar(20),
	@Password varchar(20),
	@AnhKH image
    )
	As
	if not exists (select MaKH from KHACHHANG)
		Begin 
			declare @MaKH varchar(20);
		
			set @MaKH = 'KH001'
			if not exists (select Sdt from TAIKHOAN where Sdt=@Sdt)
				begin
					Insert into TAIKHOAN values(@Sdt,@Password)
					Insert into KHACHHANG values(@MaKH,@TenKH,@Email,@GioiTinh,@NgaySinh,@DiaChi,@Sdt,@AnhKH)
				end
		End
	else
		begin	
			declare @lastMaKH varchar(20);
			set @lastMaKH = (select top 1 MaKH as tmp from KHACHHANG order by MaKH desc);
			declare @newMaKH varchar(20)
			declare @numMaKH int
			set @numMaKH = CAST(RIGHT(@lastMaKH, LEN(@lastMaKH)-2) AS INT)
			if (@numMaKH<999) and (@numMaKH>=99)
				set @newMaKH = 'KH' + CAST(@numMaKH + 1 as varchar)	
			if (@numMaKH<99) and (@numMaKH>=9)
				set @newMaKH = 'KH0' + CAST(@numMaKH + 1 as varchar)	
			if (@numMaKH<9)
				set @newMaKH = 'KH00' + CAST(@numMaKH + 1 as varchar)
			if not exists (select TAIKHOAN.Sdt from KHACHHANG, TAIKHOAN where TAIKHOAN.Sdt=@Sdt)
				begin
					Insert into TAIKHOAN values(@Sdt,@Password)
					Insert into KHACHHANG values(@newMaKH,@TenKH,@Email,@GioiTinh,@NgaySinh,@DiaChi,@Sdt,@AnhKH)
				end
		end

go
delete from KHACHHANG
delete from TAIKHOAN
exec InsertKHACHHANG @TenKH = 'Pham Nhat Quynh', @Email = 'phamnhatquynh1207@gmail.com', @GioiTinh ='Nu',@NgaySinh='12/7/2003',@DiaChi=N'HCM',@Sdt='088888888',@Password='Pnq123', @AnhKH=''
exec InsertKHACHHANG @TenKH = 'Pham Nhat Quynh', @Email = 'phamnhatquynh1207@gmail.com', @GioiTinh ='Nu',@NgaySinh='12/7/2003',@DiaChi=N'HCM',@Sdt='088888877',@Password='Pnq123', @AnhKH=''
exec InsertKHACHHANG @TenKH = 'Pham Nhat Quynh', @Email = 'phamnhatquynh1207@gmail.com', @GioiTinh ='Nu',@NgaySinh='12/7/2003',@DiaChi=N'HCM',@Sdt='088888879',@Password='Pnq123', @AnhKH=''
exec InsertKHACHHANG @TenKH = 'Pham Nhat Quynh', @Email = 'phamnhatquynh1207@gmail.com', @GioiTinh ='Nu',@NgaySinh='12/7/2003',@DiaChi=N'HCM',@Sdt='088888870',@Password='Pnq123', @AnhKH=''
exec InsertKHACHHANG @TenKH = 'Pham Nhat Quynh', @Email = 'phamnhatquynh1207@gmail.com', @GioiTinh ='Nu',@NgaySinh='12/7/2003',@DiaChi=N'HCM',@Sdt='088888870',@Password='Pnq123', @AnhKH=''
select * from KHACHHANG
select * from TAIKHOAN


--INSERT DICHVU
insert into DICHVU values ('DV001',N'GYM CƠ BẢN',300000, N'Cộng Hòa', '2/2/2022',N'2 - 4 - 6','')
insert into DICHVU values ('DV002',N'GYM NÂNG CAO',400000, N'Phan Xích Long', '2/3/2022',N'2 - 4 - 6','')
insert into DICHVU values ('DV003',N'AEROBIC TỔNG HỢP',250000, N'Cộng Hòa', '10/10/2022',N'3 - 5 - 7','')
insert into DICHVU values ('DV004',N'FITNESS FOR ALL',350000, N'Cộng Hòa', '6/4/2022',N'3 - 5 - 7','')
insert into DICHVU values ('DV005',N'GIẢM CÂN CẤP TỐC',1000000, N'Phan Xích Long','7/7/2022',N'3 - 5 - 7','')
select * from DICHVU

--INSERT HOADON
insert into HOADON values ('HD001','KH002','NV001','Cong Hoa','DV001',100000,'12/12/2022',2)
insert into HOADON values ('HD002','KH003','NV010','Cong Hoa','DV002',200000,'12/12/2022',2)
insert into HOADON values ('HD003','KH003','NV003','Phan Xich Long','DV003',300000,'3/3/2022',2)
insert into HOADON values ('HD004','KH003','NV005','Phan Xich Long','DV005',400000,'4/4/2022',2)
select * from HOADON

select * from KHACHHANG
ALTER TABLE KHACHHANG ADD ChieuCao varchar(20)
ALTER TABLE KHACHHANG ADD CanNang varchar(20)
CREATE PROCEDURE UpdateKHACHHANG (
    @MaKH varchar(20),
	@ChieuCao nvarchar(20),
	@CanNang varchar(20)
)
AS
BEGIN
    UPDATE KHACHHANG
    SET
		ChieuCao = @ChieuCao,
		CanNang = @CanNang
    WHERE MaKH = @MaKH
END



exec UpdateKHACHHANG @MaKH='KH001',@ChieuCao='1m74',@CanNang='60kg'
exec UpdateKHACHHANG @MaKH='KH002',@ChieuCao='1m74',@CanNang='60kg'

select * from KHACHHANG

--
---
--- Create procedure to update NHANVIEN
CREATE PROCEDURE UpdateNHANVIEN (
    @MaNV varchar(20),
    @TenNV nvarchar(50),
    @Email varchar(50),
    @DiaChi nvarchar(50),
    @NgaySinh date,
    @GioiTinh nvarchar(10),
    @Luong int,
    @Sdt varchar(20),
    @ChucVu nvarchar(50)
)
AS
BEGIN
    UPDATE NHANVIEN
    SET
        TenNV = @TenNV,
        Email = @Email,
        DiaChi = @DiaChi,
        NgaySinh = @NgaySinh,
        GioiTinh = @GioiTinh,
        Luong = @Luong,
        Sdt = @Sdt,
        ChucVu = @ChucVu
    WHERE MaNV = @MaNV
END

select * from  NHANVIEN

exec UpdateNHANVIEN @MaNV='NV001', @TenNV=N'Nhật Quỳnh001',@Email='phamnhatquynh1207@gmail.com',@DiaChi=N'Quảng Nam',@NgaySinh='12/7/2003',@GioiTinh=N'Nữ',@LUONG=100000000,@Sdt='0354434737',@ChucVu=N'Phó giám đốc'
exec UpdateNHANVIEN @MaNV='NV002', @TenNV=N'Nhật Quỳnh002',@Email='phamnhatquynh1207@gmail.com',@DiaChi=N'Quảng Nam',@NgaySinh='12/7/2003',@GioiTinh=N'Nữ',@LUONG=100000000,@Sdt='088888889',@ChucVu=N'Phó giám đốc'
exec UpdateNHANVIEN @MaNV='NV003', @TenNV=N'Nhật Quỳnh003',@Email='phamnhatquynh1207@gmail.com',@DiaChi=N'Quảng Nam',@NgaySinh='12/7/2003',@GioiTinh=N'Nữ',@LUONG=100000000,@Sdt='088888888',@ChucVu=N'Phó giám đốc'
exec UpdateNHANVIEN @MaNV='NV004', @TenNV=N'Nhật Quỳnh004',@Email='phamnhatquynh1207@gmail.com',@DiaChi=N'Quảng Nam',@NgaySinh='12/7/2003',@GioiTinh=N'Nữ',@LUONG=100000000,@Sdt='088888887',@ChucVu=N'Phó giám đốc'

select * from  NHANVIEN

CREATE PROCEDURE sp_UpdateDICHVU (
	@MaDV varchar(20),
    @TenDV nvarchar(50),
    @Gia int,
    @Ngay date
)
AS
BEGIN
    UPDATE DICHVU
    SET
        TenDV = @TenDV,
        Gia = @Gia,
        Ngay = @Ngay
    WHERE MaDV = @MaDV
END

select * from DICHVU
EXEC sp_UpdateDICHVU @MaDV='DV001', @TenDV = N'Gói tập Gym20',@Gia = 1000000,@Ngay = '2023-05-05'
EXEC sp_UpdateDICHVU @MaDV='DV002', @TenDV = N'Gói tập Gym1000',@Gia = 1000000,@Ngay = '2023-05-05'

select * from DICHVU
Delete from DICHVU where MaDV='DV009'

--
---
--- Create procedure to update KHACHHANG
CREATE PROCEDURE UpdateKHACHHANG (
    @MaKH varchar(20),
	@ChieuCao nvarchar(20),
	@CanNang varchar(20)

)
AS
BEGIN
    UPDATE KHACHHANG
    SET
		ChieuCao = @ChieuCao,
		CanNang = @CanNang
    WHERE MaKH = @MaKH
END

select * from KHACHHANG

--
---
--- Create procedure to update NHANVIEN
CREATE PROCEDURE UpdateNHANVIEN (
    @MaNV varchar(20),
    @TenNV nvarchar(50),
    @Email varchar(50),
    @DiaChi nvarchar(50),
    @NgaySinh date,
    @GioiTinh nvarchar(10),
    @Luong int,
    @Sdt varchar(20),
    @ChucVu nvarchar(50)
)
AS
BEGIN
    UPDATE NHANVIEN
    SET
        TenNV = @TenNV,
        Email = @Email,
        DiaChi = @DiaChi,
        NgaySinh = @NgaySinh,
        GioiTinh = @GioiTinh,
        Luong = @Luong,
        Sdt = @Sdt,
        ChucVu = @ChucVu
    WHERE MaNV = @MaNV
END

exec UpdateNHANVIEN @MaNV='KT001', @TenNV=N'Nhật Quỳnh001',@Email='phamnhatquynh1207@gmail.com',@DiaChi=N'Quảng Nam',@NgaySinh='12/7/2003',@GioiTinh=N'Nữ',@LUONG=100000000,@Sdt='0354434737',@ChucVu=N'Phó giám đốc'
exec UpdateNHANVIEN @MaNV='KT002', @TenNV=N'Nhật Quỳnh002',@Email='phamnhatquynh1207@gmail.com',@DiaChi=N'Quảng Nam',@NgaySinh='12/7/2003',@GioiTinh=N'Nữ',@LUONG=100000000,@Sdt='088888889',@ChucVu=N'Phó giám đốc'
exec UpdateNHANVIEN @MaNV='KT003', @TenNV=N'Nhật Quỳnh003',@Email='phamnhatquynh1207@gmail.com',@DiaChi=N'Quảng Nam',@NgaySinh='12/7/2003',@GioiTinh=N'Nữ',@LUONG=100000000,@Sdt='088888888',@ChucVu=N'Phó giám đốc'
exec UpdateNHANVIEN @MaNV='KT004', @TenNV=N'Nhật Quỳnh004',@Email='phamnhatquynh1207@gmail.com',@DiaChi=N'Quảng Nam',@NgaySinh='12/7/2003',@GioiTinh=N'Nữ',@LUONG=100000000,@Sdt='088888887',@ChucVu=N'Phó giám đốc'

select * from NHANVIEN
select * from TAIKHOAN
select * from HOADON

--
---
--- Create procedure to insert DICHVU
CREATE PROCEDURE sp_InsertDichVu
    @TenDV nvarchar(50),
    @Gia int,
    @Ngay date,
    @LichTap nvarchar(100),
    @AnhDV image
AS
BEGIN
    DECLARE @MaDV varchar(20)

    -- Lấy mã dịch vụ mới bằng cách tìm mã lớn nhất hiện có và tăng lên 1
    SELECT TOP 1 @MaDV = 'DV' + RIGHT('000' + CAST(RIGHT(MaDV, 3) + 1 AS varchar(3)), 3)
    FROM DICHVU
    ORDER BY MaDV DESC

    -- Nếu không tìm thấy bản ghi nào, bắt đầu với DV001
    IF @MaDV IS NULL
        SET @MaDV = 'DV001'

    -- Thêm dữ liệu mới vào bảng
    INSERT INTO DICHVU (MaDV, TenDV, Gia, Ngay, LichTap, AnhDV)
    VALUES (@MaDV, @TenDV, @Gia, @Ngay, @LichTap, @AnhDV)
END

EXEC sp_InsertDichVu @TenDV = N'Gói tập Gym1',@Gia = 1000000,@Ngay = '2023-05-05',@LichTap = N'T2-T5',@AnhDV=''
EXEC sp_InsertDichVu @TenDV = N'Gói tập Gym2',@Gia = 1000000,@Ngay = '2023-05-05',@LichTap = N'T2-T5',@AnhDV=''
EXEC sp_InsertDichVu @TenDV = N'Gói tập Gym3',@Gia = 1000000,@Ngay = '2023-05-05',@LichTap = N'T2-T5',@AnhDV=''

CREATE PROCEDURE sp_UpdateDICHVU (
	@MaDV varchar(20),
    @TenDV nvarchar(50),
    @Gia int,
    @Ngay date
)
AS
BEGIN
    UPDATE DICHVU
    SET
        TenDV = @TenDV,
        Gia = @Gia,
        Ngay = @Ngay
    WHERE MaDV = @MaDV
END

EXEC sp_UpdateDICHVU @MaDV='DV001', @TenDV = N'Gói tập Gym20',@Gia = 1000000,@Ngay = '2023-05-05'
EXEC sp_UpdateDICHVU @MaDV='DV002', @TenDV = N'Gói tập Gym30',@Gia = 1000000,@Ngay = '2023-05-05'


-- Procedure thêm thiết bị
CREATE PROCEDURE InsertThietBi
    @TenTB nvarchar(50),
    @SoLuong int,
    @TinhTrang nvarchar(50),
    @NgayNhap date,
    @AnhTB image
AS
BEGIN
    DECLARE @MaTB varchar(20)
	SELECT @MaTB = 'TB' + RIGHT('000' + CAST((COALESCE(MAX(RIGHT(MaTB, 3)), 0) + 1) AS varchar(3)), 3)
	FROM THIETBI


	INSERT INTO THIETBI (MaTB, TenTB, SoLuong, TinhTrang, NgayNhap, AnhTB)
	VALUES (@MaTB, @TenTB, @SoLuong, @TinhTrang, @NgayNhap, @AnhTB)
END
EXEC InsertThietBi 'May Chay Bo', 5, 'New', '2023-05-17', ''
EXEC InsertThietBi 'May Day Nguc', 3, 'New', '2023-05-17', ''
EXEC InsertThietBi 'May Ep Nguc', 1, 'Old', '2023-05-17', ''

select * from THIETBI

-- Procedure chỉnh sửa thiết bị
CREATE PROCEDURE UpdateThietBi
    @MaTB varchar(20),
    @TenTB nvarchar(50),
    @SoLuong int,
    @TinhTrang nvarchar(50),
    @NgayNhap date,
    @AnhTB image
AS
BEGIN
    UPDATE THIETBI
    SET TenTB = @TenTB, SoLuong = @SoLuong, TinhTrang = @TinhTrang, NgayNhap = @NgayNhap, AnhTB = @AnhTB
    WHERE MaTB = @MaTB
END
EXEC UpdateThietBi 'TB001', 'May tap chan', 5, 'Tình trạng mới', '2022-05-18', NULL

SELECT * FROM THIETBI where MaTB = 'TB012'


// Thêm vào HoaDon
CREATE PROCEDURE InsertHoaDon
    @MaKH varchar(20),
    @MaNV varchar(20),
    @Phong nvarchar(100),
    @MaDV varchar(20),
    @TongTien int,
    @Ngay date,
    @SoLuong int
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MaxMaHD varchar(20), @NextMaHD varchar(20)
    SELECT @MaxMaHD = MAX(MaHD) FROM HOADON

    IF @MaxMaHD IS NOT NULL
        SET @NextMaHD = 'HD' + RIGHT('0000' + CAST(RIGHT(@MaxMaHD, 3) + 1 AS varchar(4)), 3)
    ELSE
        SET @NextMaHD = 'HD001'

    INSERT INTO HOADON (MaHD, MaKH, MaNV, Phong, MaDV, TongTien, Ngay, SoLuong)
    VALUES (@NextMaHD, @MaKH, @MaNV, 'N'+@Phong, @MaDV, @TongTien, @Ngay, @SoLuong);
END;

EXEC InsertHoaDon 'KH003', 'NV003', 'Cong Hoa', 'DV001', 500000, '2023-05-19', 2;
select * from HoaDon

