
/*** SQL SERVER - DYNAMIC DATA MASKING ***/


--STEP 1: CREATE A 'CustomerTest' TABLE WITH DEFINED DINAMIC DATA MASKING (DDM)
CREATE TABLE CustomerTest (
CustomerID   INT IDENTITY PRIMARY KEY,
FirstName    VARCHAR(250),
LastName     VARCHAR(250) MASKED WITH (FUNCTION = 'default()') NULL,
PhoneNumber  VARCHAR(12)  MASKED WITH (FUNCTION = 'partial(1,"XXXXXXXXX",0)') NULL,
Email        VARCHAR(100) MASKED WITH (FUNCTION = 'email()') NULL,
CreditCardNo VARCHAR(16)  MASKED WITH (FUNCTION = 'partial(4,"XXXXXXXXXX",2)') NULL,
);



--STEP 2: INSERT TEST DATA IN THE 'CustomerTest' TABLE
INSERT INTO CustomerTest (FirstName, LastName, PhoneNumber, Email, CreditCardNo)
VALUES
('John', 'Smith', '4442889882', 'john@gmail.com', '4563234576547834'),
('Orlando', 'Gee', '9812446452', 'orlando@gmail.com', '1243096778653487'),
('Donna',   'Carreras',  '6745239856', 'dona@gmail.com', '8756341209876735'),
('David',  'Lawrence',  '9867452387', 'david@gmail.com', '2938713685372618');



--STEP 3: CHECK THE DATA FROM THE 'CustomerTest' TABLE
SELECT * FROM CustomerTest;
GO



--STEP 4: CREATE A NEW 'AnyUser' USER TO WHICH WE ASSIGN A SELECT PERMISSION ON THE 'CustomerTest' TABLE
CREATE USER AnyUser WITHOUT LOGIN;
GRANT SELECT ON CustomerTest TO AnyUser;
GO



--STEP 5: LET'S CHECK THE DATA ON THE 'CustomerTest' TABLE AS 'AnyUser'
EXECUTE AS USER = 'AnyUser';
SELECT * FROM CustomerTest;
REVERT;
GO



--STEP 6: WE DO DROP MASKING ON THE 'LastName' COLUMN
ALTER TABLE CustomerTest 
ALTER COLUMN LastName DROP MASKED;
GO



--STEP 7: LET'S CHECK THE DATA ON THE 'CustomerTest' TABLE AS 'AnyUser'
EXECUTE AS USER = 'AnyUser';
SELECT * FROM CustomerTest;
REVERT;
GO



--KORAK 8: UNMASK PERMISSION FOR 'AnyUser'
GRANT UNMASK TO AnyUser;
GO



--STEP 9: LET'S CHECK THE DATA ON THE 'CustomerTest' TABLE AS 'AnyUser'
EXECUTE AS USER = 'AnyUser';
SELECT * FROM dbo.CustomerTest;
REVERT; 
GO



--STEP 10: REVOKE UNMASK FOR 'AnyUser'
REVOKE UNMASK TO AnyUser;
GO



--STEP 11: LET'S CHECK THE DATA ON THE 'CustomerTest' TABLE AS 'AnyUser'
EXECUTE AS USER = 'AnyUser';
SELECT * FROM dbo.CustomerTest;
REVERT; 
GO



--STEP 12: DROP TEST TABLE AND USER
DROP TABLE CustomerTest;
GO
DROP USER AnyUser
GO