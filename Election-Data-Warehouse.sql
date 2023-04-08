
-- Creating tables for dimensions

CREATE TABLE VoterTurnout (
    LocationKey INT,
    TimeKey INT,
    PoliticalPartyKey INT,
    RegisteredVoters INT,
    TotalVotes INT,
    FOREIGN KEY (LocationKey) REFERENCES Location(LocationKey),
    FOREIGN KEY (TimeKey) REFERENCES Time(TimeKey),
    FOREIGN KEY (PoliticalPartyKey) REFERENCES PoliticalParty(PoliticalPartyKey)
);

CREATE TABLE ElectionResults (
    LocationKey INT,
    TimeKey INT,
    PoliticalPartyKey INT,
    CandidateKey INT,
    TotalVotes INT,
    FOREIGN KEY (LocationKey) REFERENCES Location(LocationKey),
    FOREIGN KEY (TimeKey) REFERENCES Time(TimeKey),
    FOREIGN KEY (PoliticalPartyKey) REFERENCES PoliticalParty(PoliticalPartyKey),
    FOREIGN KEY (CandidateKey) REFERENCES Candidate(CandidateKey)
);

CREATE TABLE Location (
    LocationKey INT PRIMARY KEY,
    State VARCHAR(255),
    County VARCHAR(255),
    Precinct VARCHAR(255)
);

CREATE TABLE PoliticalParty (
    PoliticalPartyKey INT PRIMARY KEY,
    PartyName VARCHAR(255)
);

CREATE TABLE Candidate (
    CandidateKey INT PRIMARY KEY,
    CandidateName VARCHAR(255),
    PoliticalPartyKey INT,
    FOREIGN KEY (PoliticalPartyKey) REFERENCES PoliticalParty(PoliticalPartyKey)
);

CREATE TABLE Time (
    TimeKey INT PRIMARY KEY,
    Year INT,
    Month INT,
    Day INT
);


-- Create tables for Fact tables

CREATE TABLE VoterTurnout (
    LocationKey INT,
    TimeKey INT,
    PoliticalPartyKey INT,
    RegisteredVoters INT,
    TotalVotes INT,
    FOREIGN KEY (LocationKey) REFERENCES Location(LocationKey),
    FOREIGN KEY (TimeKey) REFERENCES Time(TimeKey),
    FOREIGN KEY (PoliticalPartyKey) REFERENCES PoliticalParty(PoliticalPartyKey)
);

CREATE TABLE ElectionResults (
    LocationKey INT,
    TimeKey INT,
    PoliticalPartyKey INT,
    CandidateKey INT,
    TotalVotes INT,
    FOREIGN KEY (LocationKey) REFERENCES Location(LocationKey),
    FOREIGN KEY (TimeKey) REFERENCES Time(TimeKey),
    FOREIGN KEY (PoliticalPartyKey) REFERENCES PoliticalParty(PoliticalPartyKey),
    FOREIGN KEY (CandidateKey) REFERENCES Candidate(CandidateKey)
);

-- By Farzam Salimi
-- Loading the data into the Fact tables

INSERT INTO Location (LocationKey, State, County, Precinct)
SELECT LocationKey, State, County, Precinct
FROM sourcetable;

INSERT INTO PoliticalParty (PoliticalPartyKey, PartyName)
SELECT PoliticalPartyKey, PartyName
FROM sourcetable;

INSERT INTO Candidate (CandidateKey, CandidateName, PoliticalPartyKey)
SELECT CandidateKey, CandidateName, PoliticalPartyKey
FROM sourcetable;

INSERT INTO Time (TimeKey, Year, Month, Day)
SELECT TimeKey, Year, Month, Day
FROM sourcetable;


INSERT INTO VoterTurnout (LocationKey, TimeKey, PoliticalPartyKey, RegisteredVoters, TotalVotes)
SELECT L.LocationKey, T.TimeKey, P.PoliticalPartyKey,
    COUNT(DISTINCT V.VoterID) AS RegisteredVoters,
    COUNT(DISTINCT B.BallotID) AS TotalVotes
FROM Location L
JOIN Time T
JOIN PoliticalParty P
LEFT JOIN VoterRegistration V
    ON L.LocationKey = V.LocationKey
    AND T.TimeKey = V.TimeKey
    AND P.PoliticalPartyKey = V.PoliticalPartyKey
LEFT JOIN Ballot B
    ON L.LocationKey = B.LocationKey
    AND T.TimeKey = B.TimeKey
    AND P.PoliticalPartyKey = B.PoliticalPartyKey
GROUP BY L.LocationKey, T.TimeKey, P.PoliticalPartyKey;




INSERT INTO ElectionResults (LocationKey, TimeKey, PoliticalPartyKey, CandidateKey, TotalVotes)
SELECT L.LocationKey, T.TimeKey, P.PoliticalPartyKey, C.CandidateKey,
    COUNT(DISTINCT B.BallotID) AS TotalVotes
FROM Location L
JOIN Time T
JOIN PoliticalParty P
JOIN Candidate C ON P.PoliticalPartyKey = C.PoliticalPartyKey
LEFT JOIN Ballot B
    ON L.LocationKey = B.LocationKey
    AND T.TimeKey = B.TimeKey
    AND C.CandidateKey = B.CandidateKey
GROUP BY L.LocationKey, T.TimeKey, P.PoliticalPartyKey, C.CandidateKey;
