

/*  Sherhone Grant
	Professor Block
	IST 659: Database Administration and Database Management Concepts
	Project Deliverable 
*/


-- Drop Procedure

If OBJECT_ID('UpdateCreditCardNumberandExpirationInfo') is not null
	drop procedure dbo.UpdateCreditCardNumberandExpirationInfo

--Drop Views

 If OBJECT_ID('dbo.OutstandingPayments') is not null
	drop view dbo.OutstandingPayments
If OBJECT_ID('dbo.PaymentsReceivedFromSessions') is not null
	drop view dbo.PaymentsReceivedFromSessions

-- Drop Tables


If OBJECT_ID('dbo.TutorReviews') is not null
	drop table dbo.TutorReviews
If OBJECT_ID('dbo.Availability') is not null
	drop table dbo.Availability
If OBJECT_ID('dbo.TutorSession')  is not null
	drop table dbo.TutorSession
If OBJECT_ID('dbo.HourlyRate') is not null
	drop table dbo.HourlyRate
If OBJECT_ID('dbo.PaymentMethod') is not null
	drop table dbo.PaymentMethod
If OBJECT_ID('dbo.subjects') is not null
	drop table dbo.Subjects
If OBJECT_ID('dbo.userprofile') is not null
	drop table dbo.UserProfile



-- Creating UserProfile Table

create table UserProfile ( 
	UserProfileID int identity not null,
	FirstName varchar(30) not null,
	LastName varchar(30) not null,
	HomeAddress varchar(50) not null,
	City varchar(100) not null,
	State char(2) not null,
	ZipCode char(5) not null,
	EmailAddress varchar(100) not null,
	Password varchar(16) not null,
	Tutor_Student_Flag varchar(100) not null,
--Constraints on the User_Profile Table
Constraint PK_UserProfile Primary Key (UserProfileID),
Constraint U1_UserProfile Unique (EmailAddress),
)
go



-- Creating Subjects Table

Create table Subjects (
-- Columns for Subjects table
	SubjectsID int identity not null,
	SubjectName varchar(50) not null,
--Constraints on the SUbject Table
Constraint PK_Subjects primary key (SubjectsID)
)
go



-- Creating Payment Method Table

create table PaymentMethod (
	PaymentMethodID int identity not null,
	UserProfileID int  not null,
	Bill_to_Name varchar(30),
	BillingAddress varchar(200) not null,
	CreditCardNumber char(16) not null,
	ExpirationDate char(4) not null,
--Constraints on Payment Method Table
constraint PK_PaymentMethod Primary key (PaymentMethodID),
constraint FK1_PaymentMethod Foreign Key (UserProfileID) references UserProfile(UserProfileID)
)
go

-- Create HourlyRate Table

Create table HourlyRate (
	HourlyRateID int identity not null,
	Rate_of_Pay varchar(6) not null, 
	SubjectsID int not null,
	UserProfileID int not null,
--Constraints for HourlyRate Table
COnstraint PK_HourlyRate Primary key (HourlyRateID),
Constraint FK1_HourlyRate Foreign Key (SubjectsID) references Subjects(SubjectsID),
constraint FK2_HourlyRate Foreign Key (UserProfileID) references UserProfile(UserProfileID)
)

go


-- Creating TutorSession Table

Create table TutorSession (
	TutorSessionID int identity not null,
	TutorUserID int not null,
	StudentUserID int not null,
	SubjectsID int not null,
	Date int not null,
	Time int not null,
	DurationInHours int not null,
	HourlyRateID int not null,
	SessionCost int not null,
	PaymentMethodID int not null,

--Constraints on the TutorSession Table
Constraint PK_TutorSession Primary Key (TutorSessionID),
Constraint FK1_TutorSession Foreign Key (SubjectsID) references Subjects(SubjectsID),
Constraint FK2_TutorSession Foreign Key (HourlyRateID) references HourlyRate(HourlyRateID),
Constraint FK3_TutorSession Foreign Key (PaymentMethodID) references PaymentMethod(PaymentMethodID)
)
go


-- Creating Availability table

Create table Availability (
	AvailabilityID int identity not null,
	DaysAvailable varchar(200) not null,
	TimesAvailable int not null,
	TimeZone varchar(10) not null,
	USerProfileID int not null,
	SubjectsID int not null,
Constraint PK_Availability Primary Key (AvailabilityID),
COnstraint FK1_Availability Foreign Key (UserProfileID) references UserProfile(UserProfileID),
COnstraint FK2_Availabiltiy Foreign Key (SubjectsID) references Subjects(SubjectsID)
)
go


--Creating Tutor Reviews Table

Create Table TutorReviews (
	TutorReviewID int identity,
	UserProfileID int not null,
	TutorRating int not null,
	TutorRank varchar(10) not null,
	TutorSessionID int not null,
Constraint PK_TutorReviews Primary Key (TutorReviewID),
Constraint FK1_TutorReviews Foreign Key (UserPRofileID) references UserProfile(UserProfileID),
Constraint FK2_TutorRviews Foreign Key (TutorSessionID) references TutorSession(TutorSessionID)
)
go



-- Insert Statements -- Data Eentry --

Insert into UserProfile(FirstName, LastName, HomeAddress,  City, State, ZipCode, EmailAddress, Password, Tutor_Student_Flag)
	Values('Jacob', 'Cooper', '2652 Skinner Hollow Road', 'Waipahu', 'HI', '96797', 'j.cooper@randatmail.com', 'kbm7gaxzqw', 'Student')
			, ('Ryan', 'Armstrong', '4812  Blackwell Street', 'Dry Creek', 'AK',	'99737', 'r.armstrong@randatmail.com', 'rhoqflyt19', 'Student')
			, ('Grace',	'Higgins',	'1293  Mesa Drive', 'Nevada',	'NV',	'42821',	'g.higgins@randatmail.com',	'4poy7ri2sx',	'Student')
			, ('Lydia',	'Morris',	'2810  Ashton Lane',	'Austin',	'TX',	'45803',	'l.morris@randatmail.com',	'hkqzpojcd3',	'Student')
			, ('Oliver', 'Casey', '1854  Murry Street',	'Norfolk',	'VA',	'23510',	'o.casey@randatmail.com',	'wf5uwu8n6h',	'Student')
			, ('Oliver', 'Perkins',	'4728  Briercliff Road',	'Staten Island',	'NY',	'10314',	'o.perkins@randatmail.com',	'g1lsstfch5',	'Student')
			, ('Garry',	'Warren',	'1824  Harley Brook Lane',	'Spartansburg',	'PA',	'16434'	, 'g.warren@randatmail.com',	'23p1ndzywt',	'Student')
			, ('Victor',	'Craig',	'2421  Bloomfield Way',	'Leonard',	'MN',	'56652'	,'v.craig@randatmail.com',	'rgxnueqnun',	'Student')
			, ('Caroline',	'Cameron',	'4540  Margaret Street',	'Houston',	'TX',	'77024',	'c.cameron@randatmail.com',	'q4cj4pk8bd',	'Student')
			, ('Emma',	'Edwards',	'3035  North Avenue',	'Omaha',	'NE',	'68137',	'e.edwards@randatmail.com',	'zksona7fc5',	'Student')
			, ('Antony',	'Cooper',	'2281  Grant View Drive',	'Mount Washington',	'KY',	'40047',	'a.cooper@randatmail.com',	'iktg186r41',	'Student')
			, ('Max',	'Grant',	'1364  Conifer Drive',	'Seattle',	'WA',	'98106',	'm.grant@randatmail.com',	'ugyknwu86y',	'Student')
			, ('Melanie',	'Hamilton',	'1772  Gregory Lane',	'Albany',	'NY',	'12224',	'm.hamilton@randatmail.com',	'80bgbm1yl4',	'Student')
			, ('Lyndon',	'Cole',	'147  Clement Street',	'Norcross',	'GA',	'44705',	'l.cole@randatmail.com',	'oluzo2zixi',	'Student')
			, ('Alissa',	'Carroll',	'1305  Smith Street',	'Worcester',	'MA',	'01610',	'a.carroll@randatmail.com',	'1iyzlle4d6',	'Student')
			, ('Briony', 'Ryan',	'510  Pallet Street',	'Monsey',	'NY',	'10952',	'b.ryan@randatmail.com',	'84nuljgj55',	'Student')
			, ('Aiden',	'Cole',	'4964  Walnut Hill Drive',	'SUMNER',	'IL',	'62466',	'a.cole@randatmail.com',	'239fpn3cmq',	'Student')
			, ('Stella',	'Anderson',	'4867  Stockert Hollow Road',	'Everett',	'WA',	'98208',	's.anderson@randatmail.com',	'0hjf3rt72n',	'Student')
			, ('Adrian',	'Martin',	'180  Roosevelt Road',	'Wichita',	'KS',	'67202',	'a.martin@randatmail.com',	'sicauq39el',	'Student')
			, ('Natalie',	'Casey',	'1033  Lonely Oak Drive',	'POLARIS',	'MT',	'59746',	'n.casey@randatmail.com',	'wa8692179r',	'Student')
			, ('Michelle',	'Montgomery',	'232  Poling Farm Road',	'Omaha',	'NE',	'68102',	'm.montgomery@randatmail.com',	'8bt55tttzf',	'Student')
			, ('Lenny',	'Ross', '3476  Cambridge Court',	'Magazine',	'AR',	'72943',	'l.ross@randatmail.com',	'n3y09bfuzx',	'Student')
			, ('Wilson',	'Robinson',	'1276  Irving Road',	'Bartlett',	'OH',	'45713',	'w.robinson@randatmail.com',	'o79rk4rgaw',	'Student')
			, ('Maria',	'Barnes',	'1363  Oak Way',	'Lincoln',	'NE',	'68501',	'm.barnes@randatmail.com',	'cti4tursh7',	'Student')
			, ('Vanessa',	'Robinson',	'3417  Freedom Lane',	'KENNARD',	'NE',	'68034',	'v.robinson@randatmail.com',	'bmjwqdazhv',	'Student')
			, ('Maya',	'Myers',	'1223  Ash Street',	'OYENS',	'IA',	'51045',	'm.myers@randatmail.com',	'06ceidrs3e',	'Student')
			, ('Amelia',	'Morris',	'1460  Heavens Way',	'Tampa',	'FL', '33610',	'a.morris@randatmail.com',	'0cd7kvo2gj',	'Student')
			, ('Adrian',	'Wilson',	'315  Waterview Lane',	'Albuquerque',	'NM',	'87102',	'a.wilson@randatmail.com',	'n8tfnxjali',	'Student')
			, ('Belinda',	'Stevens',	'3693  Hill Street',	'OKEANA',	'OH',	'45053',	'b.stevens@randatmail.com',	'lvk6fczt97',	'Student')
			, ('Justin', 'Phillips',	'820  Hickory Heights Drive',	'Baltimore',	'MD',	'21202',	'j.phillips@randatmail.com',	'3d4bat7lv0',	'Tutor')
			, ('Vincent',	'Johnston',	'2610  Blackwell Street',	'WINGER',	'MN',	'56592',	'v.johnston@randatmail.com',	'msvpio9u0g',	'Tutor')
			, ('Amanda', 'Hawkins',	'2609  College View',	'O Fallon',	'IL',	'62269',	'dmyh1elgdp7@temporary-mail.net',	'qnfmbhmdzw',	'Tutor')
			, ('Kimberly', 'Taylor',	'4247  Candlelight Drive',	'Spring',	'TX',	'77386',	'v7plyhez7r@temporary-mail.net',	'2cre3wgf78',	'Tutor')
			, ('Aiden',	'Ferguson',	'3552  Progress Way',	'Cedar Rapids',	'IA',	'52401',	'a.ferguson@randatmail.com',	'4jzv9hqzk8',	'Tutor')
			, ('Chester',	'Dixon',	'3302  Progress Way',	'Cedar Rapids',	'IA',	'52401',	'c.dixon@randatmail.com',	'0ul1skz845',	'Tutor')
			, ('Adrianna',	'Howard',	'4004  Rosewood Lane',	'New York',	'NY',	'10040',	'a.howard@randatmail.com',	'5uu07j2s1s',	'Tutor')
			, ('Justin', 'Foster',	'1801  Hickory Lane',	'Washington',	'DC',	'20005',	'j.foster@randatmail.com',	'nguvwkahl0',	'Tutor')
			, ('Brianna', 'West',	'3342  Poplar Lane',	'CARRIER',	'OK',	'73727',	'b.west@randatmail.com',	'1nu4a3dn1u',	'Tutor')
			, ('Antony', 'Hamilton',	'1935  Maryland Avenue',	'Tampa',	'FL',	'33614',	'a.hamilton@randatmail.com',	'z7sbamsr26',	'Tutor')



---- Checking data in User Profile table
select * from  UserProfile

	
----------------------------
 
Insert into Subjects(SubjectName)
	Values ('Fractions')
	, ('Algebra')
	, ('Arithmetic')
	, ('Calculus A/B')
	, ('Calculus B/C')
	, ('Statistics')
	, ('Geometry')
	, ('Pre-Calculus')
	, ('Statistics')
	, ('Trigonometry')
	
	
-- Checking data in the table. Select Script

select * from Subjects



---- Inserting Values into PaymentMethod

Insert into PaymentMethod(UserProfileID, Bill_to_Name, BillingAddress, CreditCardNumber, ExpirationDate) 
	Values ('1', 'Jacob Cooper', '2652 Skinner Hollow Road, Waipahu, HI, 96797', '6594631937645870', '0327')
			, ('2', 'Ryan Armstrong', '4812  Blackwell Street, Dry Creek, AK, 99737', '6262632743692256', '1128')
			, ('3', 'Grace Higgins', '1293  Mesa Drive, Nevada, NV,	42821',	'8439488816541302','0426')
			, ('4', 'Lydia Morris',	'2810  Ashton Lane, Austin, TX, 45803', '8439432999541302',	'0627')
			, ('5', 'OliverCasey', '1854  Murry Street,	Norfolk, VA, 23510', '8439432516541302', '0924')
			, ('6', 'Oliver Perkins', '4728  Briercliff Road,	Staten Island,	NY,	10314',	'8439436616541302',	'1229')
			, ('7', 'Garry Warren', '1824  Harley Brook Lane,	Spartansburg,	PA,	16434', '8439432516541302',	'0522')
			, ('8', 'Victor Craig', '2421  Bloomfield Way,	Leonard, MN, 56652', '8439432516982130', '0321')
			, ('9', 'Caroline Cameron', '4540  Margaret Street, Houston, TX, 77024', 'NULL', 'NULL')	
			, ('10', 'Emma Edwards', '3035  North Avenue, Omaha, NE, 68137', 'NULL', 'NULL')
			, ('11', 'Antony Cooper', '2281  Grant View Drive, Mount Washington, KY, 40047', 'NULL', 'NULL')
			, ('12', 'Max Grant', '1364  Conifer Drive, Seattle, WA, 98106', 'NULL', 'NULL')
			, ('13', 'Melanie Hamilton', '1772  Gregory Lane, Albany, NY, 12224', 'NULL', 'NULL')
		    , ('14', 'Lyndon Cole',	'147  Clement Street, Norcross,	GA,	44705', '6313056166956979', '0427')
			, ('15', 'Alissa Carroll',	'1305  Smith Street, Worcester,	MA,	01610',	'6313056166953011', '0322')
			, ('16', 'Briony Ryan', '510  Pallet Street, Monsey, NY, 10952', '1053652366099920', '1122')
			, ('17', 'Aiden Cole',	'4964  Walnut Hill Drive, SUMNER, IL, 62466', '8313056166953011', '0522')
			, ('18', 'Stella Anderson',	'4867  Stockert Hollow Road, Everett, WA, 98208','9312746165308911', '0422')
			, ('19', 'Adrian Martin', '180  Roosevelt Road,	Wichita, KS,	67202', '6999056166956011', '0329')
			, ('20', 'Natalie Casey', '1033  Lonely Oak Drive,	POLARIS, MT, 59746','6388856166951011', '0222')
			, ('21', 'Michelle Montgomery',	'232  Poling Farm Road,	Omaha, NE,	68102',	'6377756166954011', '0622')
			, ('22', 'Lenny Ross', '3476  Cambridge Court,	Magazine, AR, 72943', '6313099996953011', '0725')
			, ('23', 'Wilson Robinson',	'1276  Irving Road, Bartlett, OH, 45713', 'NULL', 'NULL')
			, ('24', 'Maria Barnes', '1363  Oak Way, Lincoln, NE, 68501', '6313099999959011', '0828')
			, ('25', 'Vanessa Robinson', '3417  Freedom Lane, KENNARD,  NE,	68034',	'6366655166953011', '0924')
			, ('26', 'Maya Myers', '1223  Ash Street,	OYENS,	IA,	51045', 'NULL',	'NULL')
			, ('27', 'Amelia Morris', '1460  Heavens Way, Tampa, FL, 33610', '6313056333337011', '0521')
			, ('28', 'Adrian Wilson', '315  Waterview Lane,	Albuquerque, NM, 87102', '6313222226952011', '0322')
			, ('29', 'Belinda Stevens',	'3693  Hill Street, OKEANA,	OH,	45053', '6313058686952011', '0429')

-- Checking data in the table. Select Sript.
select * from PaymentMethod



-------

select * from Subjects

Insert into HourlyRate(Rate_of_Pay, SubjectsID, UserProfileID) 
	Values('$30','3','30')
		, ('$30','4','30')
		, ('$30','7','30')
		, ('$25','1','31')
		, ('$25','6','31')
		, ('$25','9','31')
		, ('$45','8','32')
		, ('$40','3','33')
		, ('$40','4','33')
		, ('$40','5','33')
		, ('$40','7','33')
		, ('$40','8','33')
		, ('$32.50','1','34')
		, ('$32.50','10','34')
		, ('$32.50','6','34')
		, ('$30','3','35')
		, ('$40','4','35')
		, ('$30','7','35')
		, ('$30','9','36')
		, ('$30','10','36')
		, ('$40','8','37')
		, ('$30','9','37')
		, ('$20','10','38')
		, ('$25','2','38')
		, ('$30','7','38')
		, ('$35','2','39')
		, ('$35','3','39')
		, ('$35','4','39')
		, ('$35','5','39')
		, ('$35','6','39')
		, ('$35','7','39')
		, ('$35','8','39')
		, ('$35','9','39')
		, ('$35','10','39')
		
Select * from HourlyRate



-------------------------------------

---------------------------------------
-- for reference purposes i created a select statement to see whats in the TutorSession Table
select * from Subjects
select * from TutorSession
select * from HourlyRate
select * from PaymentMethod

--------
Insert into TutorSession(TutorUserID, StudentUserID, SubjectsID, Date, Time, DurationInHours, HourlyRateID, SessionCost, PaymentMethodID)
	Values('30','2', '3', '11122020','0800','2','2','60','1')
		,('30','5', '4', '11132020','0800','1','3','30','2')
		,('30','6', '7', '11142020','0800','3','4','90','3')
		,('30','7', '3', '11152020','0800','2','2','60','4')
		,('30','7', '7', '11162020','0800','2','4','60','5')
		,('31','8', '6', '10112020','1800','1','6','25','6')
		,('31','8', '9', '10132020','1800','1','7','25','7')
		,('31','9', '1', '10152020','1800','1','5','25','8')
		, ('31','9', '9', '10122020','1800','1','1','25','9')
		, ('31','9', '1', '10142020','1800','1','1','25','10')
		, ('31','8', '6', '10162020','1800','1','1','25','11')
		, ('32','10', '3', '09122020','1200','1','9','45','12')
		, ('32','11', '3', '09122020','1200','1','9','45','13')
		, ('32','10', '3', '09142020','1200','1','9','45','14')
		, ('32','11', '3', '09142020','1400','1','9','45','15')
		, ('32','10', '3', '09192020','1600','1','9','45','16')
		, ('32','11', '3', '09192020','1600','1','9','45','17')
		, ('32','10', '3', '09192020','1400','1','9','45','18')
		, ('32','11', '3', '09212020','1200','1','9','45','19')
		, ('32','11', '3', '09212020','1200','1','9','45','20')
		, ('32','10', '3', '09282020','1400','1','9','45','21')
		, ('33','12', '3', '10222020','1400','3','1','40','22')
		, ('33','12', '3', '10232020','1400','3','1','40','23')
		, ('33','12', '3', '10242020','1400','3','1','40','24')
		, ('33','12', '3', '10252020','1400','3','1','40','25')
		, ('34','10', '6', '08052020','1600','2','1','81','26')
		, ('34','1', '1', '08062020','1600','2','1','81','27')
		, ('34','10', '10', '08022020','1600','2','1','81','28')
		, ('34','10', '10', '08062020','1600','2','1','81','29')
		, ('34','1', '4', '08042020','1600','2','1','80','3')
		, ('34','6', '3', '08052020','1600','2','1','90','1')
		, ('34','6', '3', '08062020','1600','2','1','80','2')
		, ('34','6', '3', '08072020','1600','2','1','80','3')
		, ('35','12', '3', '12102020','0800','1','1','20','4')
		, ('35','1', '4', '12112020','0800','1','1','20','5')
		, ('35','2', '3', '12122020','0800','1','1','20','6')
		, ('35','3', '4', '12122020','0800','1','1','20','7')
		, ('35','5', '3', '12132020','0800','1','1','20','8')
		, ('35','15', '4', '12142020','0800','1','1','20','9')
		, ('36','13', '9', '12102020','0900','2','1','50','4')
		, ('36','14', '10', '1211020','1000','2','1','50','5')
		, ('36','15', '9', '12102020','1100','2','1','50','6')
		, ('36','16', '10', '12102020','1200','2','1','50','3')
		, ('36','17', '9', '12102020','1300','2','1','50','4')
		, ('36','18', '9', '12102020','1400','2','1','50','5')
		, ('37','12', '8', '11122020','1900','2','1','80','9')
		, ('37','12', '8', '11122020','2000','2','1','80','9')
		, ('37','12', '9', '11122020','2100','2','1','80','9')
		, ('37','12', '9', '11132020','2100','2','1','80','4')
		, ('37','12', '9', '11142020','2100','2','1','80','9')
		, ('38','20', '2', '11122020','0830','3','1','120','7')
		, ('38','21', '7', '11122020','0930','3','1','120','8')
		, ('38','22', '10', '11122020','0830','3','1','120','9')
		, ('38','23', '2', '11122020','1030','3','24','75','1')
		, ('39','24', '2', '11122020','1130','2','26','70','1')
		, ('39','25', '3', '11122020','1230','2','27','70','2')
		, ('39','26', '4', '11122020','1330','3','28','105','3')
		, ('39','26', '5', '11122020','1430','3','29','105','4')

Insert into Availability(DaysAvailable, TimesAvailable, TimeZone, USerProfileID, SubjectsID)
	Values('Mon,Fri, Sat, Sun', '8001200', 'PST', '30', '1')
		, ('Sat,Thur, Fri, Mon', '12002000', 'CST', '31', '5')
		, ('Tues,Wed,Thurs', '14002100', 'EST', '32', '9')
		, ('Tues,Wed,Thur', '11001800', 'PST', '33', '3')
		, ('Tues,Thurs,Fri', '13002200', 'PST', '34', '6')
		, ('Sun,Wed,Mon', '12001600', 'EST', '35', '7')
		, ('Sun,Tues,Fri', '07001600', 'EST', '36', '8')
		, ('Sat,Fri,Mon', '09001500', 'CST', '37', '4')
		, ('Sat,Tues,Wed', '06001200', 'CST', '38', '3')
		, ('Wed,Thurs,Fri,Sat', '10001800', 'CST', '39', '1')
		, ('Mon,Fri, Sat, Sun', '8001200', 'PST', '30', '7')
		, ('Sat,Thur, Fri, Mon', '12002000', 'CST', '31', '3')
		, ('Sat,Thur, Fri, Mon', '12002000', 'CST', '31', '2')
		, ('Tues,Wed,Thurs', '14002100', 'EST', '32', '4')
		, ('Tues,Wed,Thur', '11001800', 'PST', '33', '9')
		, ('Tues,Thurs,Fri', '13002200', 'PST', '34', '5')
		, ('Sun,Wed,Mon', '12001600', 'EST', '35', '2')
		, ('Sun,Tues,Fri', '07001600', 'EST', '36', '6')
		, ('Sat,Fri,Mon', '09001500', 'CST', '37', '1')
		, ('Sat,Tues,Wed', '06001200', 'CST', '38', '1')
		, ('Wed,Thurs,Fri,Sat', '10001800', 'CST', '39', '4')

------Cheking Data in Table

Select * from Availability
order by SubjectsID

---------

select * from TutorSession
select * from TutorReviews

Insert into TutorReviews( UserProfileID, TutorRating, TutorRank, TutorSessionID)
	Values('34', '10', '5','55')
		, ('34', '7', '5','56')
		, ('34', '8', '5','57')
		, ('34', '7', '5','58')
		, ('34', '10', '5','55')
		, ('34', '8', '5','58')
		, ('31', '9', '2','35')
		, ('31', '9', '2','36')
		, ('31', '9', '2','37')
		, ('31', '9', '2','38')
		, ('31', '9', '2','39')
		, ('31', '10', '2','40')
		, ('32', '9', '3','41')
		, ('32', '8', '3','42')
		, ('32', '10', '3','43')
		, ('32', '9', '3','44')
		, ('32', '8', '3','45')
		, ('32', '10', '3','46')
		, ('32', '9', '3','47')
		, ('32', '9', '3','48')
		, ('32', '10', '3','49')
		, ('32', '10', '3','50')
		, ('33', '8', '4','51')
		, ('33', '9', '4','52')
		, ('33', '8', '4','53')
		, ('33', '9', '4','54')
		, ('30', '10', '1','30')
		, ('30', '10', '1','31') 
		, ('30', '10', '1','32') 
		, ('30', '10', '1','33') 
		, ('30', '9', '1','34') 
		, ('30', '10', '1','30') 
		, ('30', '10', '1','30') 
	
	

----- Data Question

------ How many Students live in New York?
select * from UserProfile
	Where State = 'NY' and Tutor_Student_Flag = 'student'
	order by FirstName

--- Data Question
--- A Math tutoring website should have a variety of math topics available for tutoring. How many math based subjects does MathTopia provide tutoring for?

select count  (SubjectsID) from  Subjects

----- It is imperative that we have tutors teach more than one subject to provide increased tutoring availability. How many  tutors teach more than one subject? 

select     

UserProfile.FirstName, Count(HourlyRate.HourlyRateID) as NumberOfSubjectsTaught
From HourlyRate
inner join Userprofile on userprofile.userprofileid = hourlyrate.userprofileid
group by     UserProfile.FirstName
having count(HourlyRate.HourlyRateID) > 2


--- It looks like ALl of our tutors teach multiple topics

---Checking data in the table. Select Script
select * from PaymentMethod
select * from userprofile  

-- Data Question:
-- All students must have a payment method associated with their account. How many students do not have a complete payment profile>?

Select * from PaymentMethod 
	where CreditCardNumber = 'NULL'

--- testing select statements
select * from UserProfile
	where Tutor_Student_Flag = 'Tutor'
	order by UserProfileID

----- How many Tutors charge an hourly rate for Calculus B/C?
Select * From HourlyRate
	where SubjectsID = '4'
	order by SubjectsID



--- We need to bill the students who have not confirmed their payment information. 
--- We must Join The UserProfileID to the Payment Mothods that contail a "Null" value 
--- in the Credit Card section.
--- Some values may repeat, but the information is still correct. (this is an error in the code.)
	

Select distinct PaymentMethod.UserProfileID, PaymentMethod.PaymentMethodID, PaymentMethod.Bill_to_Name,PaymentMethod.CreditCardNumber
from PaymentMethod
join TutorSession on
	StudentUserID = UserProfileID
	where CreditCardNumber= 'Null'
	order by UserProfileID 

--- We will need to follow-up with each student who does not have 
--- Complete credit Card information. Lets create a view to see 
--- Which students do not have not credit card information on file but have 
--- have had a tutoring session but Mathtopia.com was unable to bill for the invoice


CREATE VIEW OutstandingPayments
AS
SELECT 
		TutorSession.TutorSessionID as SessionBilled,
		PaymentMethod.Bill_to_Name as Student,
		PaymentMethod.CreditCardNumber as MissingCreditInformation 
		from PaymentMethod
		inner join TutorSession
		on TutorSession.PaymentMethodID = PaymentMethod.PaymentMethodID
		where PaymentMethod.CreditCardNumber = 'Null'
		
select * from OutstandingPayments

--- Woah! we are missing (13) payments from (7) students. We will need to create an invoice 


/* I received an update from a few of of the students who did not provide their payment information
	they have agreed to share that information and update their profile. The following upadte commands 
*/


----- Update Payment Method table

update PaymentMethod
	set CreditCardNumber = '6548965723156894' where PaymentMethodID = '9'

update PaymentMethod	
	set ExpirationDate = '0823' where PaymentMethodID = '9'

update PaymentMethod	
	set CreditCardNumber = '6548965474156894' where PaymentMethodID = '10'

update PaymentMethod	
	set ExpirationDate = '0923' where PaymentMethodID = '10'

update PaymentMethod
	set CreditCardNumber = '6548933223156894' where PaymentMethodID = '11'

update PaymentMethod	
	set ExpirationDate = '0723' where PaymentMethodID = '11'

update PaymentMethod
	set CreditCardNumber = '6548221123156894' where PaymentMethodID = '12'

update PaymentMethod	
	set ExpirationDate = '0623' where PaymentMethodID = '12'

update PaymentMethod
	set CreditCardNumber = '6548965723998794' where PaymentMethodID = '13'

update PaymentMethod	
	set ExpirationDate = '0523' where PaymentMethodID = '13'

update PaymentMethod
	set CreditCardNumber = '6548965723998794' where PaymentMethodID = '23'

update PaymentMethod	
	set ExpirationDate = '0423' where PaymentMethodID = '23'

update PaymentMethod
	set CreditCardNumber = '6548965723998794' where PaymentMethodID = '26'

update PaymentMethod	
	set ExpirationDate = '0323' where PaymentMethodID = '26'

---- Lets see if the information has updated in our  table

Z

------ Its been up dated :-) 
--- We have received payments since the students updated their user profile. 
--- Our Tutors will get paid. :-)



--- Let's create a procedure to update a Student's CreditCard Number once updated  
--- Information is received

Create Procedure UpdateCreditCardNumberandExpirationInfo(@Bill_to_Name varchar(100), @newcreditcardnumber char(16), @NewExpirationDate char(4))
as
Begin
update PaymentMethod set CreditCardNumber = @newcreditcardNumber,
ExpirationDate = @NewExpirationDate
where Bill_to_Name = @Bill_to_Name 
End
Go


Exec UpdateCreditCardNumberandExpirationInfo 'Jacob Cooper', '6773666848399287', '0129'

----Let us check if the row was effected

Select *  from PaymentMethod




--- It looks as though a student sent an email to our team requesting to delete a review after futher consideration of a session
--- Submitted on our website. We will need to delete these reviews to maintain the integrity 
--- of our website. 

delete TutorReviews
	where TutorReviewID = '33'

delete TutorReviews
	where TutorReviewID = '32'

	select * from TutorReviews

--- We now that we have payments for all our sessions, lets create a procedure that calculates
--- the gross amount for each tutor

Create View PaymentsReceivedFromSessions
as
SELECT 
		TutorSession.TutorUserID as Tutor,
		TutorSession.SessionCost as AmountBilled,
		TutorSession.StudentUserID as StudentIDofStudentBilled
		from TutorSession
		inner join UserProfile
		on UserProfile.UserProfileID = TutorSession.TutorUserID
go

--- Lets see if the  view was properly created

select * from PaymentsReceivedFromSessions

---- We have a view of the different sessions that our tutors billed for 
---- But we need a function that will allow us to calculate the minimum rate a tutor charges,
---- per hour and the total amount of money  the site has generated.
---- And the  Each tutor has made from the website.



SELECT 
		TutorSession.TutorUserID as Tutor,
		TutorSession.SessionCost as AmountBilled,
		TutorSession.StudentUserID as StudentIDofStudentBilled
		from TutorSession
		inner join UserProfile
		on UserProfile.UserProfileID = TutorSession.TutorUserID
go


select * From TutorSession

Select 
	count(TutorSessionID) as NumberOfTutorSessions
	, Sum(SessionCost) as  TotalGrossGeneratedFromSessions
	, Min(SessionCost) as  MinGrossGeneratedFromSessions
	, AVG(SessionCost) as AvgGrossGeneratedFromSessions
	, MAX(SessionCost) as MaxGrossIncomeGeneratedFromSessions
From TutorSession

--- This is awesome, we have managed to generate over $3,330 in income for our participating tutors :-)
--- Our Website is a sucess!!

