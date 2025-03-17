DROP TABLE suspect CASCADE CONSTRAINTS;
DROP TABLE crime CASCADE CONSTRAINTS;
DROP TABLE crime_reporter CASCADE CONSTRAINTS;
DROP TABLE Victim CASCADE CONSTRAINTS;
DROP TABLE Victim_detail CASCADE CONSTRAINTS;

DROP VIEW suspect_crime_view CASCADE CONSTRAINTS;
/
CREATE TABLE suspect(
    suspect_id VARCHAR2(8) primary key,
    first_name VARCHAR2(20) NOT NULL,
    surname VARCHAR2(20) NOT NULL,
    gender VARCHAR2(6) NOT NULL,
    nationality VARCHAR2(20) NOT NULL,
    date_of_birth DATE CHECK (date_of_birth < TO_DATE('01/01/2006', 'MM-DD-YYYY')),
    address VARCHAR2(50) NOT NULL,
    phone NUMBER(11) NOT NULL,
    email VARCHAR2(50),
    medical_record VARCHAR2(80) NOT NULL);

CREATE TABLE crime(
    crime_id VARCHAR2(20) primary key,
    crime_type VARCHAR2(10) NOT NULL,
    crime_date DATE NOT NULL,
    crime_state VARCHAR2(6) NOT NULL,
    crime_status VARCHAR2(7) NOT NULL,
    solved_date DATE);

CREATE TABLE crime_reporter(
    crime_reporter_id VARCHAR2(8) primary key,
    first_name VARCHAR2(20) NOT NULL,
    surname VARCHAR2(20) NOT NULL,
    gender VARCHAR2(6) NOT NULL,
    nationality VARCHAR2(20) NOT NULL,
    date_of_birth DATE NOT NULL,
    address VARCHAR2(50) NOT NULL,
    phone NUMBER(11) UNIQUE,
    email VARCHAR2(50) UNIQUE,
    report_statement VARCHAR2(100) NOT NULL,
    report_date DATE NOT NULL,
    crime_id VARCHAR2(20) references crime(crime_id));

CREATE TABLE victim(
    victim_id VARCHAR2(8) primary key,
    first_name VARCHAR2(20) NOT NULL,
    surname VARCHAR2(20) NOT NULL,
    gender VARCHAR2(6) NOT NULL,
    nationality VARCHAR2(20) NOT NULL,
    date_of_birth DATE NOT NULL,
    address VARCHAR2(50) NOT NULL,
    phone NUMBER(11) UNIQUE,
    email VARCHAR2(50) UNIQUE,
    crime_id VARCHAR2(20) references crime(crime_id));

CREATE TABLE victim_detail(
    victim_detail_no VARCHAR2(8),
    personal_statement VARCHAR2(300) NOT NULL,
    record_date DATE NOT NULL,
    primary key (victim_detail_no, victim_id),
    victim_id VARCHAR2(8) references victim(victim_id));

CREATE VIEW suspect_crime_view AS
SELECT c.crime_id, c.crime_type, c.crime_date, c.crime_state, s.suspect_id, s.first_name, s.surname, s.gender, s.nationality, s.medical_record
FROM crime c
INNER JOIN crime_suspect cs ON c.crime_id = cs.crime_id
INNER JOIN suspect s ON cs.suspect_id = s.suspect_id
WHERE s.gender = 'Male'
ORDER BY c.crime_date;

SELECT * FROM suspect_view;

INSERT INTO suspect VALUES ('s1001', 'Marco', 'Mark', 'Male', 'British', TO_DATE('05/03/1964','MM-DD-YYYY'), '1A, Area Village, Jason St., Leeds, LS2 9QW', 07678701231, 'marckomark@gmail.com', 'Low Thyroid problem');
INSERT INTO suspect VALUES ('s1002', 'Samson', 'Sam', 'Male', 'Germany', TO_DATE('03/14/1980','MM-DD-YYYY'), '12B, Area Village, Jason St., Leeds, LS2 9QW', 07102937512, 'samsonsam@gmail.com', 'Hypertension, Diabetes');
INSERT INTO suspect VALUES ('s1003', 'Donald', 'Duck', 'Male', 'Fruitopia', TO_DATE('06/09/1993','MM-DD-YYYY'), '14C, fruit house, bad St., London, NW3 9AL', 07120121221, 'donaldduck@gmail.com', 'obese');
INSERT INTO suspect VALUES ('s1004', 'Joker', 'Clown', 'Male', 'British', TO_DATE('12/05/1999','MM-DD-YYYY'), '15B, sweet house, good St., Manchester, M1 1TR', 07123498676, 'jokerclown@gmail.com', 'homicide, vandalism');
INSERT INTO suspect VALUES ('s1005', 'Ursula', 'Medusa', 'Female', 'British', TO_DATE('12/18/1993','MM-DD-YYYY'), '16A, apple house, okay St., Bangor, LL57 1AB', 07234689354, 'ursulamedusa@gmail.com', 'theft, robbery');

INSERT INTO crime VALUES ('brg000109142024', 'Primary', TO_DATE('09/14/2024','MM-DD-YYYY'), 'Open', 'Pending', null);
INSERT INTO crime VALUES ('mur000208192024', 'Primary', TO_DATE('08/19/2024','MM-DD-YYYY'), 'Open', 'Pending', null);
INSERT INTO crime VALUES ('drg000303132024', 'Secondary', TO_DATE('03/13/2024','MM-DD-YYYY'), 'Closed', 'Solved', TO_DATE('05/30/2024','MM-DD-YYYY'));
INSERT INTO crime VALUES ('spd000404272024', 'Secondary', TO_DATE('04/27/2024','MM-DD-YYYY'), 'Closed', 'Solved', TO_DATE('04/30/2024','MM-DD-YYYY'));
INSERT INTO crime VALUES ('dmv000501222024', 'Primary', TO_DATE('01/22/2024','MM-DD-YYYY'), 'Closed', 'Pending', null);

INSERT INTO crime_reporter VALUES ('cr01201', 'Clement', 'Chu', 'Male', 'Asain', TO_DATE('11/04/2003','MM-DD-YYYY'), '15A, sweet home, briggate St., Leeds, LS3 4BH', 07458196482, 'clementchu@gmail.com', 'My brothers unit has been burglarized; everything is on the floor.', TO_DATE('09/14/2024','MM-DD-YYYY'), 'brg000109142024');
INSERT INTO crime_reporter VALUES ('cr01202', 'Daniel', 'Danan', 'Male', 'American', TO_DATE('02/11/2002','MM-DD-YYYY'), '2C, lovely home, poke St., York, YO1 0SF', 07786321452, 'daneildd@gmail.com', 'Help! I saw a man masked with a knife! He has damaged people at the bus stop!', TO_DATE('08/19/2024','MM-DD-YYYY'), 'mur000208192024');
INSERT INTO crime_reporter VALUES ('cr01203', 'Marry', 'Marie', 'Female', 'Canadian', TO_DATE('05/29/2004','MM-DD-YYYY'), '23C, housey house, hope St., London, NW1 4NP', 07123455432, 'mmary@gmail.com', 'I saw a creepy woman crouching in an alley, I thought she is doing drugs.', TO_DATE('03/13/2024','MM-DD-YYYY'), 'drg000303132024');
INSERT INTO crime_reporter VALUES ('cr01204', 'Lussie', 'Lucy', 'Female', 'Russian', TO_DATE('08/14/2024','MM-DD-YYYY'), '9B, Emohy home, queen St., Cardiff, CF10 3NB', 07987655678, 'luusee@gmail.com', 'That car is definitely overspeeding! That is too fast, its dangerous!', TO_DATE('04/27/2024','MM-DD-YYYY'), 'spd000404272024');
INSERT INTO crime_reporter VALUES ('cr01205', 'Markson', 'Mark', 'Male', 'British', TO_DATE('09/12/2024','MM-DD-YYYY'), '10F, Area Village, Jason St., Leeds, LS2 9QW', 07123456789, 'mamark@gmail.com', 'I believe that couple are having an argument again, I heard they are fighting!', TO_DATE('01/25/2024','MM-DD-YYYY'), 'dmv000501222024');

INSERT INTO Victim VALUES ('vm1011', 'Cyrus', 'Chu', 'Male', 'Asain', TO_DATE('06/02/2005','MM-DD-YYYY'), '11A, Area Village, Jason St., Leeds, LS2 9QW', 07773102609, 'cyruschu@gmail.com', 'brg000109142024');
INSERT INTO Victim VALUES ('vm1012', 'Zizzi', 'Zizie', 'Female', 'Indian', TO_DATE('01/12/1989','MM-DD-YYYY'), '23B, Parkside Horizon, High St., York, Y04 1AB', 07484356312, 'zizizyzy@gmail.com', 'mur000208192024');
INSERT INTO Victim VALUES ('vm1013', 'Karen', 'Kraken', 'Female', 'British', TO_DATE('12/12/2002','MM-DD-YYYY'), '45D, Metro Aurora, Light St., Swansea, SA2 2EF', 07768553053, 'krakren@gmail.com', 'mur000208192024');
INSERT INTO Victim VALUES ('vm1014', 'Emily', 'Emma', 'Female', 'British', TO_DATE('05/31/2004','MM-DD-YYYY'), '67F, Skyline Garden, Green St., London, NW1 4NP', 07294837453, 'emmie@gmail.com', 'dmv000501222024');
INSERT INTO Victim VALUES ('vm1015', 'Jimmy', 'James', 'Male', 'French', TO_DATE('08/31/2003','MM-DD-YYYY'), '78C, Modern Gorden, Keen St., Llandudno, LL30 4VA', 07938453124, 'jimjam@gmail.com', 'mur000208192024');

INSERT INTO victim_detail VALUES ('c1011', 'When I came back to my accommodation from summer holiday, I saw my unit has been burglarised. I have locked all the doors and windows.', TO_DATE('09/14/2024','MM-DD-YYYY'), 'vm1011');
INSERT INTO victim_detail VALUES ('c1012', 'It is a sunny day; I am returning back home after work. I saw a person with a knife all in a sudden at a corner on the road. Then he stabbed me 3 times and ran.', TO_DATE('08/21/2024','MM-DD-YYYY'), 'vm1013');
INSERT INTO victim_detail VALUES ('c1013', 'I am walking back home from school library, then I felt a sudden pain on my back. It was really painful! Then I turned around, and saw a man with a black mask, and he got a knife! So, I just tried to run quickly as I could. Then, I am safely be rescued and sent to the hospital.', TO_DATE('08/20/2024','MM-DD-YYYY'), 'vm1012');
INSERT INTO victim_detail VALUES ('c1014', 'I am just listening to music and chilling on the bus stop. I never thought this will happen to me. When I am waiting for the bus, there is a man nicked my arm with a knife. It is sharp. After that, that man just ran away quickly ', TO_DATE('08/21/2024','MM-DD-YYYY'), 'vm1015');
INSERT INTO victim_detail VALUES ('c1015', 'He is my love of all time. No matter what, I dont believe he will do that to me. Even so, maybe he is just quite emotional at the moment. But this time is way too severe. He punched me several times at that night, I could not tolerate it anymore! ', TO_DATE('01/26/2024','MM-DD-YYYY'), 'vm1014');