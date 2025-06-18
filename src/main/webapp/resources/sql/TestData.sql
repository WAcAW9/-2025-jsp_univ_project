-- 1. User
INSERT INTO User (UserID, UserPW, UserName, UserAge, UserAddress)
VALUES
('user1', 'password123', '홍길동', 25, '서울시 강남구'),
('user2', 'password123', '홍길순', 30, '부산시 해운대구'),
('miduser1', 'password123', '철수', 28, '서울시 성북구'),
('miduser2', 'password123', '영희', 33, '인천시 송도'),
('admin', 'password123', '오징어', 40, '서울시 강남구');

-- 2. UserInfo

INSERT INTO UserInfo (UserCode, Level)
VALUES
(1, 'nomal'),
(2, 'nomal'),
(3, 'mid'),
(4, 'mid'),
(5, 'admin');

-- 3. UserTaste
INSERT INTO UserTaste (UserCode, UserSpicy, UserSweet, UserSalty, UserSavory, UserUmami)
VALUES
(1, 3, 5, 2, 4, 1),
(2, 2, 4, 3, 3, 2),
(3, 4, 2, 5, 1, 3),
(4, 1, 3, 4, 2, 5),
(5, 5, 5, 5, 5, 5);

-- 4. UserPointCount
INSERT INTO UserPointCount (UserCode, Point)
VALUES
(1, 100),
(2, 150),
(3, 300),
(4, 250),
(5, 1000);
