-- DROP TABLE;
DROP TABLE Account;
DROP TABLE Account_Content;
DROP TABLE Director;
DROP TABLE Director_Content;
DROP TABLE Studio;
DROP TABLE Studio_Content;
DROP TABLE Actor;
DROP TABLE Actor_Content;
DROP TABLE Content;
DROP TABLE Movie;
DROP TABLE Show;
DROP TABLE Season;
DROP TABLE Episode;
DROP TABLE Documentary;
DROP TABLE Genre;
DROP TABLE Genre_Content;
DROP TABLE StreamingService;
DROP TABLE StreamingService_Content;
DROP TABLE Subscription;
DROP TABLE Monthly_Subscription;
DROP TABLE Annual_Subscription;

-- DROP SEQUENCE:
DROP SEQUENCE Account_seq;
DROP SEQUENCE Content_seq;
DROP SEQUENCE Director_seq;
DROP SEQUENCE Studio_seq;
DROP SEQUENCE Actor_seq;
DROP SEQUENCE Actor_Content_seq;
DROP SEQUENCE Season_seq;
DROP SEQUENCE Episode_seq;
DROP SEQUENCE Genre_seq;
DROP SEQUENCE StreamingService_seq;
DROP SEQUENCE Subscription_seq;

-- CREATE TABLE;
CREATE TABLE Account(
 	AccountID DECIMAL(12) NOT NULL PRIMARY KEY,
	UserName VARCHAR(64) NOT NULL,
	E_Password VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255) NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	Email VARCHAR(255) NOT NULL, 
	Phone VARCHAR(255) NOT NULL, 
	DOB DATE NOT NULL);
	
CREATE TABLE Content( 
	ContentID DECIMAL(12) NOT NULL PRIMARY KEY,
	Title VARCHAR(255) NOT NULL,
	Released_date DATE NOT NULL,
	Language VARCHAR(50) NOT NULL,
	Avg_Rating_Stars DECIMAL(1));
	
CREATE TABLE Account_Content( 
 	AccountID DECIMAL(12) NOT NULL,
	ContentID DECIMAL(12) NOT NULL,
	FOREIGN KEY (AccountID) REFERENCES Account(AccountID), 
	FOREIGN KEY (ContentID) REFERENCES Content(ContentID));
	
CREATE TABLE Director( 
	DirectorID DECIMAL(12) NOT NULL PRIMARY KEY,
	D_fname VARCHAR(255) NOT NULL,
	D_lname VARCHAR(255) NOT NULL);

CREATE TABLE Director_Content( 
	DirectorID DECIMAL(12) NOT NULL,
	ContentID DECIMAL(12) NOT NULL,
	FOREIGN KEY (DirectorID) REFERENCES Director(DirectorID),
	FOREIGN KEY (ContentID) REFERENCES Content(ContentID));
	
CREATE TABLE Studio( 
	StudioID DECIMAL(12) NOT NULL PRIMARY KEY,
	Studio_Name VARCHAR(255) NOT NULL);
	
CREATE TABLE Studio_Content( 
 	StudioID DECIMAL(12) NOT NULL,
	ContentID DECIMAL(12) NOT NULL,
	FOREIGN KEY (StudioID) REFERENCES Studio(StudioID),
	FOREIGN KEY (ContentID) REFERENCES Content(ContentID));
 
CREATE TABLE Actor( 
	ActorID DECIMAL(12) NOT NULL PRIMARY KEY,
	A_fname VARCHAR(255) NOT NULL,
	A_lname VARCHAR(255) NOT NULL);
	
CREATE TABLE Actor_Content( 
	Actor_ContentID DECIMAL(12) NOT NULL PRIMARY KEY,
	ActorID DECIMAL(12) NOT NULL,
	ContentID DECIMAL(12) NOT NULL,
	Role VARCHAR(150) NOT NULL,
	FOREIGN KEY (ActorID) REFERENCES Actor(ActorID),
	FOREIGN KEY (ContentID) REFERENCES Content(ContentID));
	
CREATE TABLE Movie(
	ContentID DECIMAL(12) NOT NULL PRIMARY KEY,
	FOREIGN KEY (ContentID) REFERENCES Content(ContentID));

CREATE TABLE Show( 
	ContentID DECIMAL(12) NOT NULL PRIMARY KEY,
	FOREIGN KEY (ContentID) REFERENCES Content(ContentID));

CREATE TABLE Season(
	Season_ID DECIMAL(12) NOT NULL PRIMARY KEY,
	ContentID DECIMAL(12) NOT NULL,
	Season_Name VARCHAR(255) NOT NULL,
	Season_Date DATE NOT NULL,
	FOREIGN KEY (ContentID) REFERENCES Content(ContentID));

CREATE TABLE Episode( 
	Episode_ID DECIMAL(12) NOT NULL PRIMARY KEY,
	Season_ID DECIMAL(12) NOT NULL,
	S_Episode DECIMAL(4) NOT NULL,
	S_Episode_Title VARCHAR(255) NOT NULL,
	S_Episode_Date DATE NOT NULL,
	FOREIGN KEY (Season_ID) REFERENCES Season(Season_ID));

CREATE TABLE Documentary (
	ContentID DECIMAL(12) NOT NULL PRIMARY KEY,
	D_Type VARCHAR(255) NOT NULL,
	FOREIGN KEY (ContentID) REFERENCES Content(ContentID));

CREATE TABLE Genre(
	GenreID DECIMAL(12) NOT NULL PRIMARY KEY,
	Gen_Title VARCHAR(150) NOT NULL);
	
CREATE TABLE Genre_Content( 
	GenreID DECIMAL(12) NOT NULL,
	ContentID DECIMAL(12) NOT NULL,
	FOREIGN KEY (GenreID) REFERENCES Genre(GenreID),
	FOREIGN KEY (ContentID) REFERENCES Content(ContentID));

CREATE TABLE StreamingService( 
	StreamingID DECIMAL(12) NOT NULL PRIMARY KEY,
	S_Name VARCHAR(150) NOT NULL,
	URL VARCHAR(1024) NOT NULL);
	
CREATE TABLE StreamingService_Content( 
	StreamingID DECIMAL(12) NOT NULL,
	ContentID DECIMAL(12) NOT NULL, 
	FOREIGN KEY (StreamingID) REFERENCES StreamingService(StreamingID),
	FOREIGN KEY (ContentID) REFERENCES Content(ContentID));	
	
CREATE TABLE Subscription(
	SubscriptionID DECIMAL(12) NOT NULL PRIMARY KEY,
	AccountID DECIMAL(12) NOT NULL,
	StreamingID DECIMAL(12) NOT NULL,
	S_Account VARCHAR(150) NOT NULL,
	PaymentDate DATE NOT NULL,
	Amount DECIMAL(7,2) NOT NULL,
	Next_Payment_Date DATE NOT NULL,
	FOREIGN KEY (StreamingID) REFERENCES StreamingService(StreamingID),
	FOREIGN KEY (AccountID) REFERENCES Account(AccountID));
	
CREATE TABLE Monthly_Subscription( 
	SubscriptionID DECIMAL(12) NOT NULL PRIMARY KEY,
	FOREIGN KEY (SubscriptionID) REFERENCES Subscription(SubscriptionID));
	
CREATE TABLE Annual_Subscription( 
	SubscriptionID DECIMAL(12) NOT NULL PRIMARY KEY,
	Discount_Fee DECIMAL(4) NOT NULL,
	FOREIGN KEY (SubscriptionID) REFERENCES Subscription(SubscriptionID));

CREATE TABLE Avg_Rating_Stars_Change(
	Stars_ChangeID DECIMAL(12) NOT NULL PRIMARY KEY,
	Old_Stars DECIMAL(1) NOT NULL,
	New_Stars DECIMAL(1) NOT NULL,
	ContentID DECIMAL(12) NOT NULL,
	ChangeDate DATE,
	FOREIGN KEY (ContentID) REFERENCES Content(ContentID));
	
	
ALTER TABLE Content
ADD is_movie BOOLEAN NOT NULL,
ADD is_show BOOLEAN NOT NULL,
ADD is_documentary BOOLEAN NOT NULL;

ALTER TABLE Subscription
ADD subscr_type	VARCHAR(1) NOT NULL;

-- CREATE SQUENCE;
CREATE SEQUENCE Account_seq START WITH 1;
CREATE SEQUENCE Content_seq START WITH 1;
CREATE SEQUENCE Director_seq START WITH 1;
CREATE SEQUENCE Studio_seq START WITH 1;
CREATE SEQUENCE Actor_seq START WITH 1;
CREATE SEQUENCE Actor_Content_seq START WITH 1;
CREATE SEQUENCE Season_seq START WITH 1;
CREATE SEQUENCE Episode_seq START WITH 1;
CREATE SEQUENCE Genre_seq START WITH 1;
CREATE SEQUENCE StreamingService_seq START WITH 1;
CREATE SEQUENCE Subscription_seq START WITH 1;
CREATE SEQUENCE Avg_Rating_Stars_Change_seq START WITH 1;

--INDEXES
--Unique Index Creations.
CREATE UNIQUE INDEX AccountIdx
ON Account(AccountID);

CREATE UNIQUE INDEX ContentIdx
ON CONTENT(ContentID);

CREATE UNIQUE INDEX DirectorIdx
ON Director(DirectorID);

CREATE UNIQUE INDEX StudioIdx
ON Studio(StudioID);

CREATE UNIQUE INDEX ActorIdx
ON Actor(ActorID);

CREATE UNIQUE INDEX Actor_ContentIdx
ON Actor_Content(Actor_ContentID);

CREATE UNIQUE INDEX MovieIdx
ON Movie(ContentID);

CREATE UNIQUE INDEX ShowIdx
ON Show(ContentID);

CREATE UNIQUE INDEX SeasonIdx
ON Season(Season_ID);

CREATE UNIQUE INDEX EpisodeIdx
ON Episode(Episode_ID);

CREATE UNIQUE INDEX DocumentaryIdx
ON Documentary(ContentID);

CREATE UNIQUE INDEX GenreIdx
ON Genre(GenreID);

CREATE UNIQUE INDEX StreamingServiceIdx
ON StreamingService(StreamingID);

CREATE UNIQUE INDEX SubscriptionIdx
ON Subscription(SubscriptionID);

CREATE UNIQUE INDEX MonthlySubIdx
ON Monthly_Subscription(SubscriptionID);

CREATE UNIQUE INDEX AnnualSubIdx
ON Annual_Subscription(SubscriptionID);

-- CREATE Non-Unique Index-

CREATE INDEX Account_ContentIdx
ON Account_Content(AccountID);

CREATE INDEX Account_Content_ContentIdx
ON Account_Content(ContentID);

CREATE INDEX Director_Content_DirectorIdx
ON Director_Content(DirectorID);

CREATE INDEX Director_Content_ContentIdx
ON Director_Content(ContentID);

CREATE INDEX Studio_Content_StudioIdx
ON Studio_Content(StudioID);

CREATE INDEX Studio_Content_ContentIdx
ON Studio_Content(ContentID);

CREATE INDEX Actor_Content_ActorIdx
ON Actor_Content(ActorID);

CREATE INDEX Actor_Content_ContentIdx
ON Actor_Content(ContentID);

CREATE INDEX SeasonContentIdx
ON Season(ContentID);

CREATE INDEX EpisodeSeasonIdx
ON Episode(Season_ID);

CREATE INDEX Genre_Content_GenreIdx
ON Genre_Content(GenreID);

CREATE INDEX Genre_Content_ContentIdx
ON Genre_Content(ContentID);

CREATE INDEX StreamingService_Content_StreamIdx
ON StreamingService_Content(StreamingID);

CREATE INDEX StreamingService_Content_ContentIdx
ON StreamingService_Content(ContentID);

CREATE INDEX SubscriptionAccountIdx
ON SUBSCRIPTION(AccountID);

CREATE INDEX SubscriptionStreamingIdx
ON SUBSCRIPTION(StreamingID);

--- Create Driven Index

CREATE INDEX StreamingServiceNameIdx
ON StreamingService(S_Name);

CREATE INDEX ContentAvg_Rating_StarsIdx
ON CONTENT(Avg_Rating_Stars);

CREATE INDEX ContentReleasedDateIdx
ON CONTENT(Released_date);



--STORED PROCEDURES
-- 1. Store procedure for adding account informations into MYWATCHLIST

CREATE OR REPLACE PROCEDURE ADD_ACCOUNT (UserName_arg IN VARCHAR, E_Password_arg IN VARCHAR,
										FirstName_arg IN VARCHAR, LastName_arg IN VARCHAR, 
										Email_arg IN VARCHAR, Phone_arg IN DECIMAL, DOB_arg IN DATE)
AS 
$proc$
BEGIN
	INSERT INTO Account(accountid, username, e_password, firstname, lastname, email, phone, dob)
	VALUES (nextval('account_seq'), UserName_arg, E_Password_arg, FirstName_arg, LastName_arg,
		   Email_arg, Phone_arg, DOB_arg);
END;
$proc$ LANGUAGE plpgsql

START TRANSACTION;
DO 
 $$BEGIN
	CALL add_account('nvui', '123a', 'Vincent', 'Nguyen', 'nv@gmail.com', 7659126, CAST('1-DEC-1989' AS DATE));
 END$$;
COMMIT TRANSACTION;


-- 2. Store procedure for adding movie content.

CREATE OR REPLACE PROCEDURE ADD_MOVIE_CONTENT (Title_arg IN VARCHAR, Released_date_arg IN DATE, Language_arg IN VARCHAR,
											   Avg_Rating_Stars_arg IN DECIMAL, is_movie_arg IN BOOLEAN, is_show_arg IN BOOLEAN,
										       is_documentary_arg IN BOOLEAN)
										 
AS
$proc$
BEGIN
	INSERT INTO Content (contentid, title, released_date, language, avg_rating_stars,
						is_movie, is_show, is_documentary)
	VALUES (nextval('content_seq'), Title_arg, Released_date_arg, Language_arg, Avg_Rating_Stars_arg, 
		   is_movie_arg, is_show_arg, is_documentary_arg);
		   
	INSERT INTO Movie(contentid)
	VALUES (currval('content_seq'));
	
END;
$proc$ LANGUAGE plpgsql

START TRANSACTION;
DO 
 $$BEGIN
	CALL ADD_MOVIE_CONTENT('If Beale Street Could Talk', CAST('25-Dec-2018' AS DATE), 'ENGLISH', 4, TRUE, FALSE, FALSE);
 END$$;
COMMIT TRANSACTION;

-- 3. Create Stored procedure to add Show Content

CREATE OR REPLACE PROCEDURE ADD_SHOW_CONTENT (Title_arg IN VARCHAR, Released_date_arg IN DATE, Language_arg IN VARCHAR,
										Avg_Rating_Stars_arg IN DECIMAL, is_movie_arg IN BOOLEAN, is_show_arg IN BOOLEAN,
										 is_documentary_arg IN BOOLEAN)										 
AS
$proc$
BEGIN
	INSERT INTO Content (contentid, title, released_date, language, avg_rating_stars,
						is_movie, is_show, is_documentary)
	VALUES (nextval('content_seq'), Title_arg, Released_date_arg, Language_arg, Avg_Rating_Stars_arg, 
		   is_movie_arg, is_show_arg, is_documentary_arg);
		   	
	INSERT INTO Show (contentid)
	VALUES (currval('content_seq'));
END;
$proc$ LANGUAGE plpgsql

-- 4. Create Stored Procedure to add Documentary.
CREATE OR REPLACE PROCEDURE ADD_DOCU_CONTENT (Title_arg IN VARCHAR, Released_date_arg IN DATE, Language_arg IN VARCHAR,
										Avg_Rating_Stars_arg IN DECIMAL, is_movie_arg IN BOOLEAN, is_show_arg IN BOOLEAN,
										 is_documentary_arg IN BOOLEAN, D_type_arg IN VARCHAR)
										 
AS
$proc$
BEGIN
	INSERT INTO Content (contentid, title, released_date, language, avg_rating_stars,
						is_movie, is_show, is_documentary)
	VALUES (nextval('content_seq'), Title_arg, Released_date_arg, Language_arg, Avg_Rating_Stars_arg, 
		   is_movie_arg, is_show_arg, is_documentary_arg);
		   
	INSERT INTO Documentary(contentid, D_type)
	VALUES (currval('content_seq'), D_type_arg);
	
END;
$proc$ LANGUAGE plpgsql

-- 5. create store procedure to add Streaming Service

CREATE OR REPLACE PROCEDURE Add_StreamingService (s_name_arg IN VARCHAR, URL_arg IN VARCHAR)
AS
$proc$
BEGIN
	INSERT INTO streamingservice(streamingid, s_name, url)
	VALUES (nextval('streamingservice_seq'), s_name_arg, URL_arg);
END;
$proc$ LANGUAGE plpgsql

-- 6. create store procedure to add Director

CREATE OR REPLACE PROCEDURE Add_Director (D_fname_arg IN VARCHAR, D_lname_arg IN VARCHAR)
AS
$proc$
BEGIN
	INSERT INTO director(directorid,d_fname,d_lname) 
	VALUES (nextval('director_seq'), D_fname_arg, D_lname_arg);
END;
$proc$ LANGUAGE plpgsql

START TRANSACTION;
DO 
 $$BEGIN
	CALL Add_Director('Barry', 'Jenkins');
 END$$;
COMMIT TRANSACTION;

-- 7. Create Store procedure to add Monthly Subscription,
CREATE OR REPLACE PROCEDURE Add_Monthly_Sub (AccountID_arg IN DECIMAL, StreamingID_arg IN DECIMAL, 
											S_Account_arg IN VARCHAR, PaymentDate_arg IN DATE, Amount_arg IN DECIMAL,
											Next_Payment_Date_arg IN DATE, subscr_type_arg IN VARCHAR)
AS
$proc$
BEGIN
	INSERT INTO Subscripstion(SubscriptionID, AccountID, StreamingID, S_Account,
							 PaymentDate, Amount, Next_Payment_Date, subscr_type)
	VALUES (nextval('subscription_seq'), AccountID_arg, StreamingID_arg, S_Account_arg,
		   PaymentDate_arg, Amount_arg, Next_Payment_Date_arg, subscr_type_arg );
		   
	INSERT INTO monthly_subscription (SubscriptionID)
	VALUES (currval('subscription_seq'));
END;
$proc$ LANGUAGE plpgsql

--8. Create Store procedure to add Annual Subscription.
CREATE OR REPLACE PROCEDURE Add_Annual_Sub (AccountID_arg IN DECIMAL, StreamingID_arg IN DECIMAL, 
											S_Account_arg IN VARCHAR, PaymentDate_arg IN DATE, Amount_arg IN DECIMAL,
											Next_Payment_Date_arg IN DATE, subscr_type_arg IN VARCHAR, Discount_Fee_arg IN DECIMAL)
AS
$proc$
BEGIN
	INSERT INTO Subscripstion(SubscriptionID, AccountID, StreamingID, S_Account,
							 PaymentDate, Amount, Next_Payment_Date, subscr_type)
	VALUES (nextval('subscription_seq'), AccountID_arg, StreamingID_arg, S_Account_arg,
		   PaymentDate_arg, Amount_arg, Next_Payment_Date_arg, subscr_type_arg);
		   
	INSERT INTO annual_subscription (SubscriptionID, Discount_Fee)
	VALUES (currval('subscription_seq'), Discount_Fee_arg);
END;
$proc$ LANGUAGE plpgsql

--TRIGGERS
--Replace this with your history table trigger.

CREATE OR REPLACE FUNCTION StarsChangeFunction()
RETURNS TRIGGER LANGUAGE plpgsql
AS $trigfunc$
	BEGIN
		INSERT INTO avg_rating_stars_change(stars_changeid, old_stars, new_stars, contentid, changedate)
		VALUES (nextval('Avg_Rating_Stars_Change_seq'), OLD.Avg_Rating_Stars,
			   NEW.Avg_Rating_Stars, NEW.ContentID, CURRENT_DATE);
	RETURN NEW;
	END;
$trigfunc$;

CREATE TRIGGER StarsChangeTrigger
BEFORE UPDATE OF Avg_Rating_Stars ON Content
FOR EACH ROW
EXECUTE PROCEDURE StarsChangeFunction();

-- Update to change the Content Table.

UPDATE Content
SET avg_rating_stars = 2
WHERE contentid = 1;

UPDATE Content
SET avg_rating_stars = 4
WHERE contentid = 2;

UPDATE Content
SET avg_rating_stars = 3
WHERE contentid = 10;

UPDATE Content
SET avg_rating_stars = 3
WHERE contentid = 11;

UPDATE Content
SET avg_rating_stars = 4
WHERE contentid = 11;

UPDATE Content
SET avg_rating_stars = 3
WHERE contentid = 7;
---
UPDATE Content
SET avg_rating_stars = 2
WHERE contentid = 9;

UPDATE Content
SET avg_rating_stars = 3
WHERE contentid = 2;

UPDATE Content
SET avg_rating_stars = 4
WHERE contentid = 4;

UPDATE Content
SET avg_rating_stars = 3
WHERE contentid = 3;

UPDATE Content
SET avg_rating_stars = 2
WHERE contentid = 6;

UPDATE Content
SET avg_rating_stars = 1
WHERE contentid = 3;

UPDATE Content
SET avg_rating_stars = 3
WHERE contentid = 11;

UPDATE Content
SET avg_rating_stars = 4
WHERE contentid = 11;
---- Update to change the DATE for Avg_Rating_Stars_Change table for Visulization purpose.

UPDATE avg_rating_stars_change
SET changedate = CAST('2022-09-01' AS DATE)
WHERE Stars_ChangeID = 4;

UPDATE avg_rating_stars_change
SET changedate = CAST('2022-09-01' AS DATE)
WHERE Stars_ChangeID = 6;

UPDATE avg_rating_stars_change
SET changedate = CAST('2022-09-01' AS DATE)
WHERE Stars_ChangeID = 8;

UPDATE avg_rating_stars_change
SET changedate = CAST('2022-09-01' AS DATE)
WHERE Stars_ChangeID = 8;

UPDATE avg_rating_stars_change
SET changedate = CAST('2022-08-01' AS DATE)
WHERE Stars_ChangeID = 10;

UPDATE avg_rating_stars_change
SET changedate = CAST('2022-08-01' AS DATE)
WHERE Stars_ChangeID = 7;

UPDATE avg_rating_stars_change
SET changedate = CAST('2022-08-01' AS DATE)
WHERE Stars_ChangeID = 9;

UPDATE avg_rating_stars_change
SET changedate = CAST('2022-08-01' AS DATE)
WHERE Stars_ChangeID =11;

--- 

--INSERTS
--Replace this with the inserts necessary to populate your tables.
--Some of these inserts will come from executing the stored procedures.

-- INSERT INTO CONTENT
-- MOVIE
CALL add_movie_content ('The Irishman', CAST('03-Mar-19' AS DATE), 'English', 5, TRUE, FALSE, FALSE);

INSERT INTO Account_content
VALUES ((SELECT accountid from Account WHERE username = 'nvui'),(SELECT contentid from Content WHERE title = 'The Irishman'));
INSERT INTO Account_content
VALUES ((SELECT accountid from Account WHERE username = 'MC123'),(SELECT contentid from Content WHERE title = 'The Irishman'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Netflix'), (SELECT contentid from Content WHERE title = 'The Irishman'));
------
CALL add_movie_content ('She’s Gotta Have It', CAST('02-Apr-86' AS DATE), 'English', 4, TRUE, FALSE, FALSE);

INSERT INTO Account_content
VALUES ((SELECT accountid from Account WHERE username = 'TTHU'),(SELECT contentid from Content WHERE title = 'She’s Gotta Have It'));
INSERT INTO Account_content
VALUES ((SELECT accountid from Account WHERE username = 'GLindsay'),(SELECT contentid from Content WHERE title = 'She’s Gotta Have It'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Amazon Prime'), (SELECT contentid from Content WHERE title = 'She’s Gotta Have It'));
INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Netflix'), (SELECT contentid from Content WHERE title = 'She’s Gotta Have It'));
----
CALL add_movie_content ('Apocalypse Now Redux', CAST('01-Feb-79' AS DATE), 'English', 5, TRUE, FALSE, FALSE);

INSERT INTO Account_content
VALUES ((SELECT accountid from Account WHERE username = 'TTHU'),(SELECT contentid from Content WHERE title = 'Apocalypse Now Redux'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Apple TV+'), (SELECT contentid from Content WHERE title = 'Apocalypse Now Redux'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Netflix'), (SELECT contentid from Content WHERE title = 'Apocalypse Now Redux'));
----
CALL add_movie_content ('It Follows', CAST('08-Oct-15' AS DATE), 'English', 5, TRUE, FALSE, FALSE);

INSERT INTO Account_content
VALUES ((SELECT accountid from Account WHERE username = 'Mint'),(SELECT contentid from Content WHERE title = 'It Follows'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Hulu'), (SELECT contentid from Content WHERE title = 'It Follows'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Netflix'), (SELECT contentid from Content WHERE title = 'It Follows'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Disney Plus'), (SELECT contentid from Content WHERE title = 'It Follows'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Amazon Prime'), (SELECT contentid from Content WHERE title = 'It Follows'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Apple TV+'), (SELECT contentid from Content WHERE title = 'It Follows'));

----
----
-- INSERT SHOW INTO CONTENT TABLE
CALL add_show_content('The Inbetweeners',CAST('01-May-2008' AS DATE), 'English', 5, FALSE, TRUE, FALSE);
CALL add_show_content('The Friends',CAST('22-Sep-1994' AS DATE), 'English', 5, FALSE, TRUE, FALSE);
CALL add_show_content('The Witcher',CAST('20-Dec-2019' AS DATE), 'English', 5, FALSE, TRUE, FALSE);
CALL add_show_content('Loki',CAST('09-Jun-2021' AS DATE), 'English', 4, FALSE, TRUE, FALSE);
CALL add_show_content('Homeland',CAST('02-Oct-2011' AS DATE), 'English', 2, FALSE, TRUE, FALSE);

-- INSERT INTO Account_Content
INSERT INTO Account_content
VALUES ((SELECT accountid from Account WHERE username = 'nvui'),(SELECT contentid from Content WHERE title = 'The Inbetweeners'));

INSERT INTO Account_content
VALUES ((SELECT accountid from Account WHERE username = 'TTHU'),(SELECT contentid from Content WHERE title = 'The Inbetweeners'));

INSERT INTO Account_content
VALUES ((SELECT accountid from Account WHERE username = 'GLindsay'),(SELECT contentid from Content WHERE title = 'The Inbetweeners'));
--
INSERT INTO Account_content
VALUES ((SELECT accountid from Account WHERE username = 'nvui'),(SELECT contentid from Content WHERE title = 'The Friends'));

INSERT INTO Account_content
VALUES ((SELECT accountid from Account WHERE username = 'TTHU'),(SELECT contentid from Content WHERE title = 'The Friends'));

INSERT INTO Account_content
VALUES ((SELECT accountid from Account WHERE username = 'GLindsay'),(SELECT contentid from Content WHERE title = 'The Friends'));

INSERT INTO Account_content
VALUES ((SELECT accountid from Account WHERE username = 'Mint'),(SELECT contentid from Content WHERE title = 'The Friends'));

INSERT INTO Account_content
VALUES ((SELECT accountid from Account WHERE username = 'MC123'),(SELECT contentid from Content WHERE title = 'The Friends'));
--
INSERT INTO Account_content
VALUES ((SELECT accountid from Account WHERE username = 'Mint'),(SELECT contentid from Content WHERE title = 'The Witcher'));

INSERT INTO Account_content
VALUES ((SELECT accountid from Account WHERE username = 'MC123'),(SELECT contentid from Content WHERE title = 'The Witcher'));
---
INSERT INTO Account_content
VALUES ((SELECT accountid from Account WHERE username = 'MC123'),(SELECT contentid from Content WHERE title = 'Loki'));

INSERT INTO Account_content
VALUES ((SELECT accountid from Account WHERE username = 'TTHU'),(SELECT contentid from Content WHERE title = 'Loki'));

INSERT INTO Account_content
VALUES ((SELECT accountid from Account WHERE username = 'GLindsay'),(SELECT contentid from Content WHERE title = 'Homeland'));
---
-- INSERT INTO StreamingService_Content Table
INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Netflix'), (SELECT contentid from Content WHERE title = 'The Inbetweeners'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Netflix'), (SELECT contentid from Content WHERE title = 'The Friends'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Netflix'), (SELECT contentid from Content WHERE title = 'The Witcher'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Netflix'), (SELECT contentid from Content WHERE title = 'Loki'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Netflix'), (SELECT contentid from Content WHERE title = 'Homeland'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Disney Plus'), (SELECT contentid from Content WHERE title = 'The Friends'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Disney Plus'), (SELECT contentid from Content WHERE title = 'The Witcher'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Amazon Prime'), (SELECT contentid from Content WHERE title = 'The Inbetweeners'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Amazon Prime'), (SELECT contentid from Content WHERE title = 'The Friends'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Hulu'), (SELECT contentid from Content WHERE title = 'The Friends'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Apple TV+'), (SELECT contentid from Content WHERE title = 'The Friends'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES ((SELECT streamingid from StreamingService Where S_name = 'Apple TV+'), (SELECT contentid from Content WHERE title = 'Loki'));
---
-- INSERT INTO SEASON TABLE

INSERT INTO season(season_id,contentid,season_name,season_date)
VALUES (nextval('season_seq'), (SELECT contentid FROM Content WHERE Title = 'The Inbetweeners'), 'Season 1', CAST('1-MAY-2008' AS DATE));

INSERT INTO episode(episode_id, season_id, s_episode, s_episode_title, s_episode_date)
VALUES (nextval('episode_seq'), currval('season_seq'), 1, 'Fist Day',CAST('1-MAY-2008' AS DATE)),
	   (nextval('episode_seq'), currval('season_seq'), 2, 'Bunk Off',CAST('1-JUN-2008' AS DATE));
--
INSERT INTO season(season_id,contentid,season_name,season_date)
VALUES (nextval('season_seq'), (SELECT contentid FROM Content WHERE Title = 'The Friends'), 'Season 1', CAST('22-SEP-1994' AS DATE));

INSERT INTO episode(episode_id, season_id, s_episode, s_episode_title, s_episode_date)
VALUES (nextval('episode_seq'), currval('season_seq'), 1, 'Pilot',CAST('22-SEP-1994' AS DATE)),
	   (nextval('episode_seq'), currval('season_seq'), 2, 'The one with the Sonogram at the End',CAST('29-SEP-1994' AS DATE));
-----
INSERT INTO season(season_id,contentid,season_name,season_date)
VALUES (nextval('season_seq'), (SELECT contentid FROM Content WHERE Title = 'The Witcher'), 'Season 1', CAST('20-DEC-2019' AS DATE));

INSERT INTO episode(episode_id, season_id, s_episode, s_episode_title, s_episode_date)
VALUES (nextval('episode_seq'), currval('season_seq'), 1, 'The End Begining',CAST('20-DEC-2019' AS DATE));
---
INSERT INTO season(season_id,contentid,season_name,season_date)
VALUES (nextval('season_seq'), (SELECT contentid FROM Content WHERE Title = 'Loki'), 'Season 1', CAST('09-Jun-2021' AS DATE));

INSERT INTO episode(episode_id, season_id, s_episode, s_episode_title, s_episode_date)
VALUES (nextval('episode_seq'), currval('season_seq'), 1, 'Glorious Purpose',CAST('09-Jun-2021' AS DATE)),
	   (nextval('episode_seq'), currval('season_seq'), 2, 'The variant',CAST('16-Jun-2021' AS DATE));
-----
INSERT INTO season(season_id,contentid,season_name,season_date)
VALUES (nextval('season_seq'), (SELECT contentid FROM Content WHERE Title = 'Homeland'), 'Season 1', CAST('02-Oct-2011' AS DATE));

INSERT INTO episode(episode_id, season_id, s_episode, s_episode_title, s_episode_date)
VALUES (nextval('episode_seq'), currval('season_seq'), 1, 'Pilot-Homeland',CAST('02-Oct-2011' AS DATE));

----

INSERT INTO Account_content
VALUES ((SELECT accountid from Account WHERE username = 'nvui'),(SELECT contentid from Content WHERE title = 'If Beale Street Could Talk'));

INSERT INTO streamingservice_content(streamingid,contentid) 
VALUES (currval('streamingservice_seq'), (SELECT contentid from Content WHERE title = 'If Beale Street Could Talk'));

-- Insert into StreamingService Table
CALL add_streamingservice('Netflix', 'netflix.com');
CALL add_streamingservice('Disney Plus', 'disneyplus.com');
CALL add_streamingservice('Amazon Prime', 'primevideo.com');
CALL add_streamingservice('Hulu', 'hulu.com');
CALL add_streamingservice('Apple TV+', 'tv.apple.com');

-- Insert into Account table
CALL add_account('Mint', 'good', 'Sophia', 'Ng', 'sophia@gmail.com', 7950346, CAST('27-MAR-1990' AS DATE));
CALL add_account('TTHU', '546b', 'Tina', 'Vo', 'tthu@gmail.com', 7680356, CAST('15-OCT-1989' AS DATE));
CALL add_account('GLindsay', '89cc', 'Lindsay', 'Gambin', 'LGambin@gmail.com', 7569215, CAST('23-MAR-1990' AS DATE));
CALL add_account('MC123', '3535', 'Mike', 'Dance', 'Mdance@gmail.com', 7980546, CAST('27-FEB-1992' AS DATE));

-- Insert Into Subscription
INSERT INTO Subscription(subscriptionid,accountid,streamingid,s_account,paymentdate,amount,next_payment_date,subscr_type)
VALUES (nextval('subscription_seq'), (SELECT AccountID FROM Account Where username = 'nvui'), (Select StreamingID From StreamingService Where s_name = 'Disney Plus'),
		'nvui2', CAST('01-May-20' AS DATE), 200, CAST('01-May-21' AS DATE), 'A');
		
INSERT INTO annual_subscription(subscriptionid, Discount_Fee)
VALUES (currval('subscription_seq'),20);

INSERT INTO Subscription(subscriptionid,accountid,streamingid,s_account,paymentdate,amount,next_payment_date,subscr_type)
VALUES (nextval('subscription_seq'), (SELECT AccountID FROM Account Where username = 'Mint'), (Select StreamingID From StreamingService Where s_name = 'Netflix'),
		'Mint1', CAST('10-Jul-20' AS DATE), 20, CAST('10-Aug-21' AS DATE), 'M');

INSERT INTO monthly_subscription (subscriptionid)
VALUES (currval('subscription_seq'));

INSERT INTO Subscription(subscriptionid,accountid,streamingid,s_account,paymentdate,amount,next_payment_date,subscr_type)
VALUES (nextval('subscription_seq'), (SELECT AccountID FROM Account Where username = 'Mint'), (Select StreamingID From StreamingService Where s_name = 'Disney Plus'),
		'Mint2', CAST('12-Jun-20' AS DATE), 15, CAST('12-Jul-20' AS DATE), 'M');

INSERT INTO monthly_subscription (subscriptionid)
VALUES (currval('subscription_seq'));

INSERT INTO Subscription(subscriptionid,accountid,streamingid,s_account,paymentdate,amount,next_payment_date,subscr_type)
VALUES (nextval('subscription_seq'), (SELECT AccountID FROM Account Where username = 'Mint'), (Select StreamingID From StreamingService Where s_name = 'Hulu'),
		'Mint3', CAST('20-Jun-20' AS DATE), 180, CAST('20-Jun-21' AS DATE), 'A');
		
INSERT INTO annual_subscription(subscriptionid, Discount_Fee)
VALUES (currval('subscription_seq'),10);

INSERT INTO Subscription(subscriptionid,accountid,streamingid,s_account,paymentdate,amount,next_payment_date,subscr_type)
VALUES (nextval('subscription_seq'), (SELECT AccountID FROM Account Where username = 'TTHU'), (Select StreamingID From StreamingService Where s_name = 'Apple TV+'),
		'Tina1', CAST('03-Aug-20' AS DATE), 150, CAST('03-Aug-21' AS DATE), 'A');
		
INSERT INTO annual_subscription(subscriptionid, Discount_Fee)
VALUES (currval('subscription_seq'),30);

INSERT INTO Subscription(subscriptionid,accountid,streamingid,s_account,paymentdate,amount,next_payment_date,subscr_type)
VALUES (nextval('subscription_seq'), (SELECT AccountID FROM Account Where username = 'TTHU'), (Select StreamingID From StreamingService Where s_name = 'Amazon Prime'),
		'Tina2', CAST('05-Aug-20' AS DATE), 12, CAST('05-Sep-20' AS DATE), 'M');

INSERT INTO monthly_subscription (subscriptionid)
VALUES (currval('subscription_seq'));

INSERT INTO Subscription(subscriptionid,accountid,streamingid,s_account,paymentdate,amount,next_payment_date,subscr_type)
VALUES (nextval('subscription_seq'), (SELECT AccountID FROM Account Where username = 'TTHU'), (Select StreamingID From StreamingService Where s_name = 'Netflix'),
		'Tina3', CAST('10-Aug-20' AS DATE), 155, CAST('10-Aug-21' AS DATE), 'A');
		
INSERT INTO annual_subscription(subscriptionid, Discount_Fee)
VALUES (currval('subscription_seq'),15);

INSERT INTO Subscription(subscriptionid,accountid,streamingid,s_account,paymentdate,amount,next_payment_date,subscr_type)
VALUES (nextval('subscription_seq'), (SELECT AccountID FROM Account Where username = 'GLindsay'), (Select StreamingID From StreamingService Where s_name = 'Netflix'),
		'Lindsay1', CAST('01-Sep-20' AS DATE), 20, CAST('02-Oct-20' AS DATE), 'M');

INSERT INTO monthly_subscription (subscriptionid)
VALUES (currval('subscription_seq'));

INSERT INTO Subscription(subscriptionid,accountid,streamingid,s_account,paymentdate,amount,next_payment_date,subscr_type)
VALUES (nextval('subscription_seq'), (SELECT AccountID FROM Account Where username = 'GLindsay'), (Select StreamingID From StreamingService Where s_name = 'Disney Plus'),
		'Lindsay2', CAST('05-Sep-20' AS DATE), 200, CAST('05-Sep-21' AS DATE), 'A');
		
INSERT INTO annual_subscription(subscriptionid, Discount_Fee)
VALUES (currval('subscription_seq'),20);

INSERT INTO Subscription(subscriptionid,accountid,streamingid,s_account,paymentdate,amount,next_payment_date,subscr_type)
VALUES (nextval('subscription_seq'), (SELECT AccountID FROM Account Where username = 'MC123'), (Select StreamingID From StreamingService Where s_name = 'Netflix'),
		'Mike', CAST('03-Oct-20' AS DATE), 20, CAST('02-Nov-20' AS DATE), 'M');

INSERT INTO monthly_subscription (subscriptionid)
VALUES (currval('subscription_seq'));

INSERT INTO Subscription(subscriptionid,accountid,streamingid,s_account,paymentdate,amount,next_payment_date,subscr_type)
VALUES (nextval('subscription_seq'), (SELECT AccountID FROM Account Where username = 'nvui'), (Select StreamingID From StreamingService Where s_name = 'Netflix'),
		'nvui12', CAST('11-Jul-20' AS DATE), 20, CAST('11-Aug-21' AS DATE), 'M');

INSERT INTO monthly_subscription (subscriptionid)
VALUES (currval('subscription_seq'))

-- Insert into Director and Director_Content Tables
INSERT INTO director_content(directorid,contentid)
VALUES (currval('director_seq'), (SELECT contentid from Content WHERE title = 'If Beale Street Could Talk'));

CALL add_director('Martin', 'Scorsese');

INSERT INTO director_content(directorid,contentid)
VALUES (currval('director_seq'), (SELECT contentid from Content WHERE title = 'The Irishman'));

CALL add_director('Spike', 'Lee');

INSERT INTO director_content(directorid,contentid)
VALUES (currval('director_seq'), (SELECT contentid from Content WHERE title = 'She’s Gotta Have It'));

CALL add_director('Francis', 'Ford');

INSERT INTO director_content(directorid,contentid)
VALUES (currval('director_seq'), (SELECT contentid from Content WHERE title = 'Apocalypse Now Redux'));

CALL add_director('David', 'Robert');

INSERT INTO director_content(directorid,contentid)
VALUES (currval('director_seq'), (SELECT contentid from Content WHERE title = 'It Follows'));

CALL add_director('Damon', 'Deesley');

INSERT INTO director_content(directorid,contentid)
VALUES (currval('director_seq'), (SELECT contentid from Content WHERE title = 'The Inbetweeners'));

CALL add_director('David', 'Crane');

INSERT INTO director_content(directorid,contentid)
VALUES (currval('director_seq'), (SELECT contentid from Content WHERE title = 'The Friends'));


CALL add_director('Mike', 'Ostrowski');

INSERT INTO director_content(directorid,contentid)
VALUES (currval('director_seq'), (SELECT contentid from Content WHERE title = 'The Witcher'));


CALL add_director('Michael', 'Waldron');

INSERT INTO director_content(directorid,contentid)
VALUES (currval('director_seq'), (SELECT contentid from Content WHERE title = 'Loki'));

CALL add_director('Howard', 'Gordon');

INSERT INTO director_content(directorid,contentid)
VALUES (currval('director_seq'), (SELECT contentid from Content WHERE title = 'Homeland'));


--QUERIES
--Replace this with your queries.
-- FRIST Query

SELECT Title, D_fname ||' ' || D_lname AS Director_Name, Count(*) AS Number_Of_User_Watch
FROM Account
JOIN Account_Content ON Account.AccountID = Account_Content.AccountID 
JOIN Content ON Content.contentid = Account_Content.contentid
JOIN Director_content ON director_content.contentid = Content.contentid
JOIN Director ON Director.directorid = director_content.directorid
GROUP BY Content.contentid, Title, Director_Name
ORDER BY Number_Of_User_Watch DESC;

-- Second Query
SELECT Account.AccountID, UserName, S_Account AS Subscription_UserName, S_Name AS Streaming_Service, to_char(Amount, '$999.99') AS Subscription_Fee,
	   Subscr_type AS Subscription_Type, to_char(Discount_Fee, '$99.00') AS Discount_Subscription_Fee_USD
FROM ACCOUNT
JOIN Subscription ON Account.AccountID = Subscription.AccountID
LEFT JOIN Annual_Subscription ON Annual_Subscription.SubscriptionID = Subscription.SubscriptionID
JOIN StreamingService ON Streamingservice.streamingid = Subscription.streamingid
ORDER BY Account.AccountID, Subscription.s_account;

-- Third Query
-- CREATE A VIEW
CREATE OR REPLACE VIEW Number_Content_In_StreamingSerive AS
SELECT  StreamingService.StreamingID, S_name AS Streaming_Name, Count(streamingservice.streamingid) AS Number_Of_Content
FROM Content
JOIN streamingservice_content ON streamingservice_content.contentid = Content.contentid
JOIN streamingservice ON streamingservice.streamingid = streamingservice_content.streamingid
GROUP BY streamingservice.streamingid, S_name
ORDER BY Number_Of_Content DESC;

---Query for Question 3.
SELECT Number_Content_In_StreamingSerive.StreamingID, Streaming_name, 
	   Number_of_Content, Count(*) AS Number_Account_Subscribe
FROM Number_Content_In_StreamingSerive
JOIN Subscription ON Subscription.StreamingID = Number_Content_In_StreamingSerive.StreamingID
GROUP BY Number_Content_In_StreamingSerive.StreamingID, Streaming_name, Number_of_Content
ORDER BY Number_Account_Subscribe DESC;

--- Get number of content which had average rating stars change and Visualization 2.
SELECT EXTRACT(MONTH FROM changedate) AS Month, 
	   COUNT(Distinct(contentid)) AS Number_Of_Content
FROM Avg_Rating_Stars_Change
GROUP BY EXTRACT(MONTH FROM changedate);

--- Query for visulization number 1.

SELECT S_Name AS Streaming_Name, COUNT(*) AS Number_Contents
FROM streamingservice
JOIN streamingservice_content ON streamingservice_content.streamingid = streamingservice.streamingid
JOIN content ON content.contentid = streamingservice_content.contentid
GROUP BY S_Name
ORDER BY Number_Contents DESC;






