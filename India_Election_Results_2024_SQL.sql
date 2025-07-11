create database India_election_results;
use India_election_results;
SHOW VARIABLES LIKE 'secure_file_priv';
CREATE TABLE statewise_results(
constituency VARCHAR(100),
  const_no INT,
  Parliament_Constituency VARCHAR(50),
  leading_candidate VARCHAR(100),
  trailing_candidate VARCHAR(100),
  margin VARCHAR(50),
  status VARCHAR(50),
  state_id VARCHAR(50),
  Country Varchar(50)
  );
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/statewise_results.csv'
INTO TABLE statewise_results
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Total Seats
select * from constituencywise_results;

SELECT 
	COUNT(DISTINCT `Parliament Constituency`) AS Total_Seats
FROM 
	constituencywise_results;
    
-- What is the total number of seats available for elections in each state
SELECT 
    s.State AS State_Name,
    COUNT(DISTINCT cr.`Constituency ID`) AS Total_Seats_Available
FROM 
    constituencywise_results cr
JOIN 
    statewise_results sr ON cr.`Parliament Constituency` = sr.Parliament_Constituency
JOIN 
    states s ON sr.state_id = s.`State ID`
GROUP BY 
    s.State
ORDER BY 
    s.State;

-- Total Seats Won by NDA Alliance
SELECT 
    SUM(CASE 
            WHEN Party IN (
                'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
                'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
                'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
            ) THEN `Won`
            ELSE 0 
        END) AS TotalSeats_WonBY_NDA
FROM 
    partywise_results;

-- Seats Won by NDA Alliance Parties
SELECT 
    party as Party_Name,
    won as Seats_Won
FROM 
    partywise_results
WHERE 
    party IN (
        'Bharatiya Janata Party - BJP', 
        'Telugu Desam - TDP', 
		'Janata Dal  (United) - JD(U)',
        'Shiv Sena - SHS', 
        'AJSU Party - AJSUP', 
        'Apna Dal (Soneylal) - ADAL', 
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS', 
        'Janasena Party - JnP', 
		'Janata Dal  (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV', 
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD', 
        'Sikkim Krantikari Morcha - SKM'
    )
ORDER BY Seats_Won DESC;

-- Total Seats Won by I.N.D.I.A. Alliance
 SELECT 
    SUM(CASE 
            WHEN party IN (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
            ) THEN `Won`
            ELSE 0 
        END) AS INDIA_Total_Seats_Won
FROM 
    partywise_results;

-- Seats Won by I.N.D.I.A. Allianz Parties

SELECT 
    party as Party_Name,
    won as Seats_Won
FROM 
    partywise_results
WHERE 
    party IN (
       'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
    )
ORDER BY Seats_Won DESC;

-- Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER

-- Step 1: Add a new column for party alliance

ALTER TABLE partywise_results
ADD COLUMN party_alliance VARCHAR(50);
SET SQL_SAFE_UPDATES = 0;
-- Step 2: Assign I.N.D.I.A. alliance parties
UPDATE partywise_results
SET party_alliance = 'I.N.D.I.A'
WHERE party IN (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
);

-- Step 3: Assign NDA alliance parties
UPDATE partywise_results
SET party_alliance = 'NDA'
WHERE party IN (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
);

-- Step 4: Mark remaining (null) parties as OTHER
UPDATE partywise_results
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL;

-- Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?
SELECT 
    p.party_alliance,
    COUNT(cr.`Constituency ID`) AS Seats_Won
FROM 
    constituencywise_results cr
JOIN 
    partywise_results p ON cr.`Party ID` = p.`Party ID`
WHERE 
    p.party_alliance IN ('NDA', 'I.N.D.I.A', 'OTHER')
GROUP BY 
    p.party_alliance
ORDER BY 
    Seats_Won DESC;

-- Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?

SELECT cr.`Winning Candidate`, p.Party, p.party_alliance, cr.`Total Votes`, cr.Margin, cr.`Constituency Name`, s.State
FROM constituencywise_results cr
JOIN partywise_results p ON cr.`Party ID` = p.`Party ID`
JOIN statewise_results sr ON cr.`Parliament Constituency` = sr.Parliament_Constituency
JOIN states s ON sr.State_ID = s.`State ID`
WHERE s.State = 'Uttar Pradesh' AND cr.`Constituency Name` = 'AMETHI';


-- Which parties won the most seats in s State, and how many seats did each party win?
    SELECT 
    p.`Party` AS Party_Name,
    COUNT(cr.`Constituency ID`) AS Seats_Won
FROM 
    `constituencywise_results` cr
JOIN 
    `partywise_results` p ON cr.`Party ID` = p.`Party ID`
JOIN 
    `statewise_results` sr ON cr.`Parliament Constituency` = sr.`Parliament_Constituency`
JOIN 
    `states` s ON sr.`State_ID` = s.`State ID`
WHERE 
    s.`State` = 'Andhra Pradesh'
GROUP BY 
    p.`Party`
ORDER BY 
    Seats_Won DESC;
    
-- What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024

SELECT 
    s.`State` AS State_Name,

    -- NDA Seats
    SUM(CASE 
            WHEN p.`Party` IN (
                'Bharatiya Janata Party - BJP',
                'Janata Dal  (United) - JD(U)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV',
                'Shiv Sena - SHS'
            ) THEN 1
            ELSE 0
        END) AS NDA_Seats_Won,

    -- I.N.D.I.A. Seats
    SUM(CASE 
            WHEN p.`Party` IN (
                'Indian National Congress - INC',
                'Samajwadi Party - SP',
                'All India Trinamool Congress - AITC',
                'Dravida Munnetra Kazhagam - DMK',
                'Aam Aadmi Party - AAAP'
            ) THEN 1
            ELSE 0
        END) AS INDIA_Seats_Won,

    -- Other Seats
    SUM(CASE 
            WHEN p.`Party` NOT IN (
                'Bharatiya Janata Party - BJP',
                'Janata Dal  (United) - JD(U)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV',
                'Shiv Sena - SHS',
                'Indian National Congress - INC',
                'Samajwadi Party - SP',
                'All India Trinamool Congress - AITC',
                'Dravida Munnetra Kazhagam - DMK',
                'Aam Aadmi Party - AAAP'
            ) THEN 1
            ELSE 0
        END) AS OTHER_Seats_Won

FROM 
    `constituencywise_results` cr
JOIN 
    `partywise_results` p ON cr.`Party ID` = p.`Party ID`
JOIN 
    `statewise_results` sr ON cr.`Parliament Constituency` = sr.`Parliament_Constituency`
JOIN 
    `states` s ON sr.`State_ID` = s.`State ID`
GROUP BY 
    s.`State`
ORDER BY 
    s.`State`;


    -- Which candidate received the highest number of EVM votes in each constituency (Top 10)?

SELECT 
    cr.`Constituency Name`,
    cd.`Constituency ID`,
    cd.`Candidate`,
    cd.`EVM Votes`
FROM 
    `constituencywise_details` cd
JOIN 
    `constituencywise_results` cr ON cd.`Constituency ID` = cr.`Constituency ID`
WHERE 
    cd.`EVM Votes` = (
        SELECT MAX(cd1.`EVM Votes`)
        FROM `constituencywise_details` cd1
        WHERE cd1.`Constituency ID` = cd.`Constituency ID`
    )
ORDER BY 
    cd.`EVM Votes` DESC
LIMIT 10;

  
  -- Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?
WITH RankedCandidates AS (
    SELECT 
        cd.`Constituency ID`,
        cd.`Candidate`,
        cd.`Party`,
        cd.`EVM Votes`,
        cd.`Postal Votes`,
        cd.`EVM Votes` + cd.`Postal Votes` AS Total_Votes,
        ROW_NUMBER() OVER (
            PARTITION BY cd.`Constituency ID`
            ORDER BY cd.`EVM Votes` + cd.`Postal Votes` DESC
        ) AS VoteRank
    FROM 
        `constituencywise_details` cd
    JOIN 
        `constituencywise_results` cr ON cd.`Constituency ID` = cr.`Constituency ID`
    JOIN 
        `statewise_results` sr ON cr.`Constituency Name` = sr.`Constituency`
    JOIN 
        `states` s ON sr.`State_ID` = s.`State ID`
    WHERE 
        s.`State` = 'Maharashtra'
)

SELECT 
    cr.`Constituency Name`,
    MAX(CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END) AS Winning_Candidate,
    MAX(CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
FROM 
    RankedCandidates rc
JOIN 
    `constituencywise_results` cr ON rc.`Constituency ID` = cr.`Constituency ID`
GROUP BY 
    cr.`Constituency Name`
ORDER BY 
    cr.`Constituency Name`;

 
-- For the state of Maharashtra, what are the total number of seats, total votes (including EVM and postal), and the breakdown of EVM and postal votes?

SELECT 
    'Maharashtra' AS State,
    COUNT(DISTINCT cr.`Constituency ID`) AS Total_Seats,
    
    -- Subquery for total votes
    (SELECT SUM(`EVM Votes` + `Postal Votes`)
     FROM `constituencywise_details`) AS Total_Votes,
    
    (SELECT SUM(`EVM Votes`)
     FROM `constituencywise_details`) AS Total_EVM_Votes,
    
    (SELECT SUM(`Postal Votes`)
     FROM `constituencywise_details`) AS Total_Postal_Votes
FROM 
    `constituencywise_results` cr
JOIN 
    `statewise_results` sr ON cr.`Parliament Constituency` = sr.`Parliament_Constituency`
JOIN 
    `states` s ON sr.`State_ID` = s.`State ID`
WHERE 
    s.`State` = 'Maharashtra';









