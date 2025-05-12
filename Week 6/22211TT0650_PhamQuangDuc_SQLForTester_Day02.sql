-- Q1: Tạo bảng Trainee và thêm dữ liệu mẫu
CREATE TABLE Trainee (
    TraineeID INT IDENTITY(1,1) PRIMARY KEY,
    Full_Name NVARCHAR(100) NOT NULL,
    Birth_Date DATE NOT NULL,
    Gender VARCHAR(10) CHECK (Gender IN ('male', 'female')) NOT NULL,
    ET_IQ INT CHECK (ET_IQ BETWEEN 0 AND 20),
    ET_Gmath INT CHECK (ET_Gmath BETWEEN 0 AND 20),
    ET_English INT CHECK (ET_English BETWEEN 0 AND 50),
    Training_Class NVARCHAR(50) NOT NULL,
    Evaluation_Notes NVARCHAR(MAX)
);




INSERT INTO Trainee (Full_Name, Birth_Date, Gender, ET_IQ, ET_Gmath, ET_English, Training_Class, Evaluation_Notes, Fsoft_Account)
VALUES 
(N'Nguyễn Văn An', '2000-05-15', 'male', 10, 12, 25, 'C01', 'Good', 'an123'),
(N'Trần Thị Bích', '2001-08-20', 'female', 15, 8, 30, 'C02', 'Excellent', 'bich456'),
(N'Lê Văn Cường', '1999-12-10', 'male', 7, 9, 22, 'C01', 'Average', 'cuong789'),
(N'Phạm Hồng Đăng', '2002-07-18', 'female', 12, 10, 28, 'C03', 'Very good', 'dang101'),
(N'Bùi Thành Duy', '2000-01-25', 'male', 9, 11, 20, 'C04', 'Good', 'duy202'),
(N'Nguyễn Thị Hạnh', '1998-11-30', 'female', 14, 10, 35, 'C02', 'Outstanding', 'hanh303'),
(N'Đỗ Văn Hùng', '1997-06-10', 'male', 11, 9, 27, 'C01', 'Above average', 'hung404'),
(N'Hoàng Minh Hải', '2003-04-05', 'male', 13, 11, 29, 'C03', 'Very good', 'hai505'),
(N'Phạm Thanh Lan', '2001-09-14', 'female', 8, 10, 21, 'C04', 'Satisfactory', 'lan606'),
(N'Lê Hoàng Nam', '1999-02-18', 'male', 17, 12, 40, 'C01', 'Excellent', 'nam707'),
(N'Trần Văn Sơn', '2002-03-25', 'male', 10, 10, 26, 'C02', 'Good', 'son808'),
(N'Võ Thị Mỹ', '1996-12-20', 'female', 16, 14, 38, 'C03', 'Exceptional', 'my909'),
(N'Đặng Thành Phong', '2004-07-08', 'male', 9, 8, 19, 'C04', 'Needs improvement', 'phong010'),
(N'Nguyễn Văn Quân', '1995-05-10', 'male', 12, 13, 30, 'C01', 'Very good', 'quan020'),
(N'Bùi Thị Ngọc', '2000-06-22', 'female', 15, 15, 42, 'C02', 'Excellent', 'ngoc030');

-- Q2: Thêm cột Fsoft_Account sau khi tạo bảng
ALTER TABLE Trainee
ADD Fsoft_Account NVARCHAR(50) NOT NULL UNIQUE;

-- Q3: Tạo VIEW danh sách học viên vượt qua bài kiểm tra
CREATE VIEW ET_Passed AS
SELECT * FROM Trainee
WHERE (ET_IQ + ET_Gmath >= 20) AND ET_IQ >= 8 AND ET_Gmath >= 8 AND ET_English >= 18;

SELECT * FROM ET_Passed

-- Q4: Truy vấn học viên vượt qua bài kiểm tra, nhóm theo tháng sinh
SELECT MONTH(Birth_Date) AS Birth_Month, COUNT(*) AS Passed_Count
FROM ET_Passed
GROUP BY MONTH(Birth_Date)
ORDER BY Birth_Month;

-- Q5: Truy vấn học viên có tên dài nhất, hiển thị tuổi và thông tin
SELECT TOP 1 Full_Name, DATEDIFF(YEAR, Birth_Date, GETDATE()) AS Age, Gender, Training_Class
FROM Trainee
ORDER BY LEN(Full_Name) DESC;
