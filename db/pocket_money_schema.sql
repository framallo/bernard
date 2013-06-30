PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE preferences
	(
	'databaseVersion'		INTEGER,
	'databaseID'			INTEGER,
	'multipleCurrencies'		BOOLEAN,
	'nextServerID'			INTEGER									-- db version 20
	);
INSERT INTO "preferences" VALUES(33,-5938091267844711379,NULL,NULL);
CREATE TABLE accounts 
	(
	'deleted'			BOOLEAN DEFAULT 0,
	'timestamp'			INTEGER,
	'accountID'			INTEGER PRIMARY KEY AUTOINCREMENT,
	'displayOrder'			INTEGER,
	'account' 			TEXT,
	'balanceOverall' 		REAL,									-- not used
	'balanceCleared' 		REAL,									-- not used
	'type' 				INTEGER,
	'accountNumber' 		TEXT,
	'institution' 			TEXT,
	'phone' 			TEXT,
	'expirationDate' 		TEXT,
	'checkNumber' 			TEXT,
	'notes' 			TEXT,
	'iconFileName' 			TEXT,
	'url' 				TEXT,
	'ofxid'				TEXT,
	'ofxurl'			TEXT,
	'password'			TEXT,
	'fee' 				REAL,
	'fixedPercent' 			INTEGER,
	'limitAmount' 			REAL,
	'noLimit' 			BOOLEAN DEFAULT 1,
	'totalWorth' 			BOOLEAN DEFAULT 1,
	'exchangeRate' 			REAL,
	'currencyCode'			TEXT,
	'lastSyncTime'			INTEGER DEFAULT 0,
	'routingNumber'			TEXT,									-- db version 14
	'overdraftAccountID'		INTEGER,								-- db version 17
	'keepTheChangeAccountID'	INTEGER,								-- db version 22
	'keepChangeRoundTo'		REAL,									-- db version 26
	'serverID'			TEXT									-- db version 20
	
	);
CREATE TABLE transactions
	(
	'transactionID'			INTEGER PRIMARY KEY AUTOINCREMENT,
	'deleted'			BOOLEAN DEFAULT 0,
	'timestamp'			INTEGER,
	'type'				INTEGER,
	'date'				INTEGER,
	'cleared'			BOOLEAN,
	'accountID'			INTEGER,
	'payee'				TEXT,
	'checkNumber'			TEXT,
	'subTotal'			REAL,
	'ofxID'				TEXT,									-- db version 15
	'image'				BLOB,									-- db version 15  semi-colon separated list of filenames
	'serverID'			TEXT,									-- db version 20
	'overdraftID'			TEXT									-- db version 23
	);
CREATE TABLE categorypayee
	(
	'categoryID'				INTEGER,								-- these need to be text will be a serverID
	'payeeID'				INTEGER,								-- these need to be text will be a serverid
	'deleted'				BOOLEAN DEFAULT 0,							-- db version 20
	'serverID'				TEXT,									-- db version 20
	'timestamp'				INTEGER,								-- db version 20
	PRIMARY KEY (categoryID, payeeID)
	);
CREATE TABLE classes
	(
	'deleted'				BOOLEAN DEFAULT 0,
	'timestamp'				INTEGER,

	'classID'				INTEGER PRIMARY KEY AUTOINCREMENT,
	'class'					TEXT UNIQUE,
	'serverID'				TEXT									-- db version 20
	);
CREATE TABLE ids
	(
	'deleted'				BOOLEAN DEFAULT 0,
	'timestamp'				INTEGER,
	'idID'					INTEGER PRIMARY KEY AUTOINCREMENT,
	'id'					TEXT UNIQUE,
	'serverID'				TEXT									-- db version 20
	);
CREATE TABLE exchangeRates
	(
	'deleted'			BOOLEAN DEFAULT 0,
	'timestamp'			INTEGER,
	'currencyCode'			TEXT PRIMARY KEY,
	'exchangeRate'			REAL
	);
CREATE TABLE repeatingTransactions
	(
	'repeatingID'			INTEGER PRIMARY KEY AUTOINCREMENT,
	'deleted'			BOOLEAN DEFAULT 0,
	'timestamp'			INTEGER,
	'lastProcessedDate'		INTEGER,
	'transactionID'			INTEGER,
	'type'				INTEGER,		-- none = 0, daily=1, weekly=2, monthlybyday = 3, monthlybydate = 4, yearly = 5
	'endDate'			INTEGER,
	'frequency'			INTEGER,
	'repeatOn'			INTEGER,
	'startOfWeek'			INTEGER,
	'serverID'			TEXT,									-- db version 20
	'sendLocalNotifications'	INTEGER,								-- db version 29
	'notifyDaysInAdvance'		INTEGER									-- db version 29
	);
CREATE TABLE categoryBudgets -- db version 29
	(
	'categoryBudgetID' 		INTEGER PRIMARY KEY AUTOINCREMENT,
	'deleted' 			BOOLEAN DEFAULT 0, 
	'serverID' 			TEXT, 
	'timestamp' 			INTEGER, 
	'categoryName' 			TEXT, 
	'date' 				INTEGER, 
	'budgetLimit' 			REAL, 
	'resetRollover' 		BOOLEAN DEFAULT 0
	);
INSERT INTO "categoryBudgets" VALUES(1,1,'F2522835-FD8C-40C5-BD60-6E6A4477D46B',1369406886,'me.groceries',1369353600,2000.0,0);
CREATE TABLE databaseSyncList
	(
	'databaseID'			TEXT PRIMARY KEY,			-- DBVer 19 -- can be UDID from iphones or somethign else --DBVer 21 - didn't set primary key
	'lastSyncTime'			INTEGER
	);
INSERT INTO "databaseSyncList" VALUES('356513041103625',1371071882);
CREATE TABLE filters ( 'filterID' INTEGER PRIMARY KEY AUTOINCREMENT, 'deleted' BOOLEAN DEFAULT 0, 'timestamp' INTEGER, 'filterName' TEXT, 'type' INTEGER, 'dateFrom' INTEGER, 'dateTo' INTEGER, 'accountID' INTEGER, 'categoryID' TEXT, 'payee' TEXT, 'classID' TEXT, 'checkNumber' TEXT, 'cleared' INTEGER, 'spotlight' TEXT, 'selectedFilterName' TEXT, 'serverID' TEXT );
