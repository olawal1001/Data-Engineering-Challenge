CREATE DATABASE Marketing_Campaign_DB;
USE Marketing_Campaign_DB;
-- Create Client table
CREATE TABLE Client (
    id INT PRIMARY KEY,
    age INT,
    job VARCHAR(255),
    marital VARCHAR(255),
    education VARCHAR(255),
    credit_default VARCHAR(10),
    housing VARCHAR(10),
    loan VARCHAR(10)
);

-- Create Campaign table
CREATE TABLE Campaign (
    campaign_id INT PRIMARY KEY,
    client_id INT,
    duration INT,
    contact VARCHAR(50),
    pdays INT,
    previous INT,
    poutcome VARCHAR(50),
    y VARCHAR(10),
    date DATE,
    FOREIGN KEY (client_id) REFERENCES Client(id)
);

-- Create Economics table
CREATE TABLE Economics (
    client_id INT,
    emp_var_rate DECIMAL(10,2),
    cons_price_idx DECIMAL(10,2),
    euribor3m DECIMAL(10,2),
    number_employed DECIMAL(10,2),
    FOREIGN KEY (client_id) REFERENCES Client(id)
);

-- Insert data into Client table
BULK INSERT Client
FROM 'C:\Users\DELL\Desktop\Data Nexus Hub\Assignments\DE_DA_DS_Challenge\client_data.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',    
    FIRSTROW = 2           
);

-- Insert data into Campaign table 
BULK INSERT Campaign 
FROM 'C:\Users\DELL\Desktop\Data Nexus Hub\Assignments\DE_DA_DS_Challenge\campaign_data.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',    
    FIRSTROW = 2           
);

-- Insert data into Economics table
BULK INSERT Economics
FROM 'C:\Users\DELL\Desktop\Data Nexus Hub\Assignments\DE_DA_DS_Challenge\economics_data.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',    
    FIRSTROW = 2           
);

SELECT * FROM Client;
SELECT * FROM Campaign;
SELECT * FROM Economics;

-- Rename duration column in the Campaign table
EXEC sp_rename 'Campaign.duration', 'contact_duration', 'COLUMN';

-- Rename contact column in the Campaign table
EXEC sp_rename 'Campaign.contact', 'number_contacts', 'COLUMN';

-- Rename previous column in the Campaign table
EXEC sp_rename 'Campaign.previous', 'previous_campaign_contacts', 'COLUMN';

-- Rename poutcome column in the Campaign table
EXEC sp_rename 'Campaign.poutcome', 'previous_outcome', 'COLUMN';

-- Rename y column in the Campaign table
EXEC sp_rename 'Campaign.y', 'campaign_outcome', 'COLUMN';

-- Rename date column in the Campaign table
EXEC sp_rename 'Campaign.date', 'last_contact_date', 'COLUMN';


-- Rename euribor3m column in the Economics table
EXEC sp_rename 'Economics.euribor3m', 'euribor_three_months', 'COLUMN';
