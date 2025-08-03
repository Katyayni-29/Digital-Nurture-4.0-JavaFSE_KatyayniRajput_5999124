--Schema to be Created

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

--Example Scripts for Sample Data Insertion

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


-- QUESTIONS AND SOLUTIONS

/*

Exercise 1: Control Structures

Scenario 1: The bank wants to apply a discount to loan interest rates for customers above 60 years old.
        ? Question: Write a PL/SQL block that loops through all customers, checks their age, 
           and if they are above 60, apply a 1% discount to their current loan interest rates.
Scenario 2: A customer can be promoted to VIP status based on their balance.
        ? Question: Write a PL/SQL block that iterates through all customers and sets a flag IsVIP to TRUE 
           for those with a balance over $10,000.
Scenario 3: The bank wants to send reminders to customers whose loans are due within the next 30 days.
        ? Question: Write a PL/SQL block that fetches all loans due in the next 30 days and prints a reminder 
            message for each customer.

*/

-- SCENARIO 1

BEGIN
    FOR res IN (
        SELECT c.CustomerID, c.DOB, l.LoanID, l.InterestRate
        FROM Customers c
        JOIN Loans l ON c.CustomerID = l.CustomerID
    )
    LOOP
        IF MONTHS_BETWEEN(SYSDATE, res.DOB) / 12 > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE LoanID = res.LoanID;

            DBMS_OUTPUT.PUT_LINE('1% discount applied to Loan ID ' || res.LoanID || ' for customer with Customer ID ' || res.CustomerID);
        END IF;
    END LOOP;

    COMMIT;
END;
/

--SCENARIO 2

desc Customers;
ALTER TABLE Customers ADD IsVIP VARCHAR2(5); 

BEGIN
    FOR res IN (SELECT CustomerID, Balance FROM Customers) LOOP
        IF res.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID = res.CustomerID;

            DBMS_OUTPUT.PUT_LINE('VIP status updated for customer with customerID' || res.CustomerID || );
        END IF;
    END LOOP;

    COMMIT;
END;
/

--SCENARIO 3

BEGIN
    FOR res IN (
        SELECT l.LoanID, l.CustomerID, l.EndDate, c.Name
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.EndDate <= SYSDATE + 30
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder: Loan ID ' || res.LoanID || ' for customer ' || res.Name || 
                             ' is due on ' || TO_CHAR(res.EndDate, 'DD-Mon-YYYY'));
    END LOOP;
END;
/


/*

Exercise 3: Stored Procedures

Scenario 1: The bank needs to process monthly interest for all savings accounts.
        ? Question: Write a stored procedure ProcessMonthlyInterest that calculates and 
            updates the balance of all savings accounts by applying an interest rate of 1% to the current balance.

Scenario 2: The bank wants to implement a bonus scheme for employees based on their performance.
        ? Question: Write a stored procedure UpdateEmployeeBonus that updates the salary of employees 
            in a given department by adding a bonus percentage passed as a parameter.

Scenario 3: Customers should be able to transfer funds between their accounts.
        ? Question: Write a stored procedure TransferFunds that transfers a specified amount from one account to another, 
            checking that the source account has sufficient balance before making the transfer.

*/

--SCENARIO 1

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest
IS
BEGIN
    UPDATE Accounts
    SET Balance = Balance + (Balance * 0.01),
        LastModified = SYSDATE
    WHERE LOWER(AccountType) = 'savings';

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Monthly interest applied to all savings accounts.');
END;
/

--SCENARIO 2

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_dept IN VARCHAR2,
    p_bonus_percent IN NUMBER
)
IS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * p_bonus_percent / 100)
    WHERE Department = p_dept;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Salary updated by ' || p_bonus_percent || '% in department ' || p_dept);
END;
/

--SCENARIO 3

CREATE OR REPLACE PROCEDURE TransferFunds (
    from_account IN NUMBER,
    to_account IN NUMBER,
    amount IN NUMBER
)
IS
    v_balance NUMBER;
BEGIN
   
    SELECT Balance INTO v_balance
    FROM Accounts
    WHERE AccountID = from_account
    FOR UPDATE;

    IF v_balance < amount THEN
        RAISE_APPLICATION_ERROR(-00001, 'Insufficient balance in source account.');
    END IF;

    UPDATE Accounts
    SET Balance = Balance - amount,
        LastModified = SYSDATE
    WHERE AccountID = from_account;

    UPDATE Accounts
    SET Balance = Balance + amount,
        LastModified = SYSDATE
    WHERE AccountID = to_account;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Rs.' || amount || ' transferred from Account ' || from_account || ' to Account ' || to_account);
END;
/



