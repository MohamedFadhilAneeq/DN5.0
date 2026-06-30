CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance NUMBER,
    LastModified DATE
);

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(20),
    Balance NUMBER,
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Transactions (
    TransactionID NUMBER PRIMARY KEY,
    AccountID NUMBER,
    TransactionDate DATE,
    Amount NUMBER,
    TransactionType VARCHAR2(10),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER,
    InterestRate NUMBER,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary NUMBER,
    Department VARCHAR2(50),
    HireDate DATE
);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (1, 'John Doe', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 1000, SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (2, 'Jane Smith', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 1500, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (1, 1, 'Savings', 1000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (2, 2, 'Checking', 1500, SYSDATE);

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (1, 1, SYSDATE, 200, 'Deposit');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (2, 2, SYSDATE, 300, 'Withdrawal');

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (1, 1, 5000, 5, SYSDATE, ADD_MONTHS(SYSDATE, 60));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', TO_DATE('2015-06-15', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', TO_DATE('2017-03-20', 'YYYY-MM-DD'));

--EXERCISE 1
--SCENARIO 1

DECLARE
    CURSOR c_seniors IS 
        SELECT CustomerID 
        FROM Customers 
        WHERE (MONTHS_BETWEEN(SYSDATE, DOB) / 12) > 60;
BEGIN
    FOR senior_rec IN c_seniors LOOP
        UPDATE Loans
        SET InterestRate = InterestRate - 1
        WHERE CustomerID = senior_rec.CustomerID;
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Senior citizen discounts applied successfully.');
END;
/

SELECT CustomerID, InterestRate FROM Loans;

--SCENARIO 2


ALTER TABLE Customers ADD IsVIP VARCHAR2(5) DEFAULT 'FALSE';

DECLARE
    CURSOR c_customers IS 
        SELECT CustomerID, Balance 
        FROM Customers;
BEGIN
    FOR cust_rec IN c_customers LOOP
        IF cust_rec.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID = cust_rec.CustomerID;
        END IF;
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('VIP statuses updated based on balances.');
END;
/

SELECT Name, Balance, IsVIP FROM Customers;

--SCEANRIO 3

DECLARE
    CURSOR c_due_loans IS
        SELECT c.Name, l.LoanID, l.EndDate
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND (SYSDATE + 30);
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- UPCOMING LOAN DUE DATES ---');
    FOR loan_rec IN c_due_loans LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder: Customer ' || loan_rec.Name || 
                             ' - Loan ID ' || loan_rec.LoanID || 
                             ' is due on ' || TO_CHAR(loan_rec.EndDate, 'YYYY-MM-DD'));
    END LOOP;
END;
/

--EXERCISE 2
--SCENARIO 2

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
BEGIN
    UPDATE Accounts
    SET Balance = Balance + (Balance * 0.01)
    WHERE AccountType = 'Savings';
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('1% Monthly interest processed for all Savings accounts.');
END;
/

--SCENARIO 2

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_department IN VARCHAR2,
    p_bonus_percent IN NUMBER
) IS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * (p_bonus_percent / 100))
    WHERE Department = p_department;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Bonus applied to all employees in department: ' || p_department);
END;
/

--SCENARIO 3

CREATE OR REPLACE PROCEDURE TransferFunds (
    p_from_account IN NUMBER,
    p_to_account IN NUMBER,
    p_amount IN NUMBER
) IS
    v_current_balance NUMBER;
BEGIN
    SELECT Balance INTO v_current_balance
    FROM Accounts
    WHERE AccountID = p_from_account;

    IF v_current_balance >= p_amount THEN
        UPDATE Accounts 
        SET Balance = Balance - p_amount 
        WHERE AccountID = p_from_account;
        
        UPDATE Accounts 
        SET Balance = Balance + p_amount 
        WHERE AccountID = p_to_account;
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Transfer of $' || p_amount || ' successful.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('ERROR: Insufficient funds for transfer.');
    END IF;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: One or both Account IDs do not exist.');
END;
/

-- Turn on console output so we can see your DBMS_OUTPUT messages
SET SERVEROUTPUT ON;

-- ==========================================
-- TESTING EXERCISE 3: STORED PROCEDURES
-- ==========================================

-- 1. Test Monthly Interest (Savings accounts should increase by 1%)
EXEC ProcessMonthlyInterest;
SELECT AccountID, AccountType, Balance AS "New Balance" FROM Accounts;

-- 2. Test Employee Bonus (HR department gets a 10% bonus)
EXEC UpdateEmployeeBonus('HR', 10);
SELECT Name, Department, Salary AS "New Salary" FROM Employees;

-- 3. Test Transfer Funds (Move $200 from Account 2 to Account 1)
EXEC TransferFunds(2, 1, 200);
SELECT AccountID, Balance AS "Balance After Transfer" FROM Accounts;

-- 4. Test Transfer Funds Failure (Try to move $10,000 from Account 1 - should fail)
EXEC TransferFunds(1, 2, 10000);