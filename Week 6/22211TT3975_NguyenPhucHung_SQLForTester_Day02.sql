
-- Tạo cơ sở dữ liệu nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'BTSQL')
BEGIN
    CREATE DATABASE BTSQL;
END;
GO

-- Chuyển sang sử dụng database BTSQL
USE BTSQL;
GO

-- Q1: Tạo bảng TRAINEE với các cột phù hợp
CREATE TABLE TRAINEE (
    TraineeID INT IDENTITY(1,1) PRIMARY KEY, -- Tự động tăng
    Full_Name NVARCHAR(255) NOT NULL, -- Họ và tên
    Birth_Date DATE NOT NULL, -- Ngày sinh
    Gender NVARCHAR(10) NOT NULL CHECK (Gender IN ('male', 'female')), -- Chỉ nhận 'male' hoặc 'female'
    ET_IQ INT NOT NULL CHECK (ET_IQ BETWEEN 0 AND 20), -- Điểm IQ đầu vào
    ET_Gmath INT NOT NULL CHECK (ET_Gmath BETWEEN 0 AND 20), -- Điểm GMath đầu vào
    ET_English INT NOT NULL CHECK (ET_English BETWEEN 0 AND 50), -- Điểm English đầu vào
    Training_Class NVARCHAR(50) NOT NULL, -- Lớp đào tạo
    Evaluation_Notes NVARCHAR(MAX) NULL -- Ghi chú đánh giá
);
GO

-- Thêm 10 bản ghi mẫu
INSERT INTO TRAINEE (Full_Name, Birth_Date, Gender, ET_IQ, ET_Gmath, ET_English, Training_Class, Evaluation_Notes)
VALUES
(N'Nguyen Van A', '2000-05-15', 'male', 10, 9, 30, N'Class A', N'Good progress'),
(N'Tran Thi B', '2001-06-20', 'female', 8, 7, 25, N'Class B', N'Needs improvement'),
(N'Le Van C', '2002-07-10', 'male', 12, 10, 35, N'Class A', N'Excellent performance'),
(N'Pham Thi D', '2000-08-30', 'female', 9, 8, 28, N'Class C', N'Satisfactory'),
(N'Hoang Van E', '2001-09-25', 'male', 11, 10, 40, N'Class B', N'Outstanding'),
(N'Bui Thi F', '2003-10-05', 'female', 7, 6, 20, N'Class C', N'Average'),
(N'Dang Van G', '2000-11-15', 'male', 13, 9, 38, N'Class A', N'Very good'),
(N'Ngo Thi H', '2002-12-01', 'female', 14, 11, 42, N'Class B', N'Excellent'),
(N'Dinh Van I', '2003-01-19', 'male', 15, 12, 45, N'Class C', N'Exceptional'),
(N'Vu Thi J', '2002-02-28', 'female', 16, 13, 48, N'Class A', N'Top performer');
GO

-- Q2: Thêm cột Fsoft_Account, đảm bảo giá trị là duy nhất và không null
ALTER TABLE TRAINEE ADD Fsoft_Account NVARCHAR(100) NOT NULL DEFAULT '' UNIQUE;
GO

-- Q3: Tạo VIEW chứa danh sách các học viên đậu kỳ thi đầu vào (ET-passed)
CREATE VIEW Passed_Trainees AS
SELECT * FROM TRAINEE
WHERE (ET_IQ + ET_Gmath) >= 20
AND ET_IQ >= 8
AND ET_Gmath >= 8
AND ET_English >= 18;
GO
  SELECT * FROM Passed_Trainees;
GO

-- Q4: Truy vấn danh sách học viên đã qua kỳ thi và nhóm theo tháng sinh
SELECT 
    MONTH(Birth_Date) AS Birth_Month, 
    COUNT(*) AS Trainee_Count 
FROM Passed_Trainees
GROUP BY MONTH(Birth_Date)
ORDER BY Birth_Month;
GO

-- Q5: Truy vấn học viên có tên dài nhất và hiển thị tuổi cùng thông tin cơ bản
SELECT TOP 1 
    Full_Name, 
    DATEDIFF(YEAR, Birth_Date, GETDATE()) AS Age, -- SQL Server dùng GETDATE() thay vì CURDATE()
    Gender, 
    Training_Class, 
    Evaluation_Notes
FROM TRAINEE
ORDER BY LEN(Full_Name) DESC;
GO
