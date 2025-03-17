DROP TABLE police_officer CASCADE CONSTRAINTS;
DROP TABLE inspector CASCADE CONSTRAINTS;
DROP TABLE detective CASCADE CONSTRAINTS;
DROP TABLE note_recorder CASCADE CONSTRAINTS;
DROP TABLE suspect CASCADE CONSTRAINTS;
DROP TABLE location CASCADE CONSTRAINTS;
DROP TABLE crime CASCADE CONSTRAINTS;
DROP TABLE police_investigation CASCADE CONSTRAINTS;
DROP TABLE crime_reporter CASCADE CONSTRAINTS;
DROP TABLE victim CASCADE CONSTRAINTS;
DROP TABLE victim_detail CASCADE CONSTRAINTS;
DROP TABLE criminal CASCADE CONSTRAINTS;
DROP TABLE offence CASCADE CONSTRAINTS;
DROP TABLE crime_offence CASCADE CONSTRAINTS;
DROP TABLE criminal_offence CASCADE CONSTRAINTS;
DROP TABLE evidence CASCADE CONSTRAINTS;
DROP TABLE object CASCADE CONSTRAINTS;
DROP TABLE witness CASCADE CONSTRAINTS;
DROP TABLE witness_detail CASCADE CONSTRAINTS;
DROP TABLE criminal_object CASCADE CONSTRAINTS;
DROP TABLE crime_suspect CASCADE CONSTRAINTS;
DROP TABLE detective_investigation CASCADE CONSTRAINTS;
DROP TABLE evidence_collection CASCADE CONSTRAINTS;

CREATE TABLE police_officer(
    police_id VARCHAR2(8) primary key,
    first_name VARCHAR2(20),
    surname VARCHAR2(20),
    gender VARCHAR2(6),
    nationality VARCHAR2(20),
    date_of_birth DATE,
    address VARCHAR2(50),
    phone NUMBER(11),
    email VARCHAR2(50),
    rank VARCHAR2(30),
    department VARCHAR2(40));

CREATE TABLE inspector(
    police_id VARCHAR2(8) primary key,
    team_size NUMBER(4),
    foreign key (police_id) references police_officer(police_id));

CREATE TABLE detective(
    police_id VARCHAR2(8) primary key,
    case_solved NUMBER(5), 
    inspector_id VARCHAR2(8), -- inspector manges them
    foreign key (police_id) references police_officer(police_id), 
    foreign key (inspector_id) references inspector(police_id));

CREATE TABLE note_recorder(
    police_id VARCHAR2(8) primary key,
    notes_report VARCHAR2(200),
    inspector_id VARCHAR2(8), -- inspector manges them
    foreign key (police_id) references police_officer(police_id),
    foreign key (inspector_id) references inspector(police_id));

CREATE TABLE suspect(
    suspect_id VARCHAR2(8) primary key,
    first_name VARCHAR2(20),
    surname VARCHAR2(20),
    gender VARCHAR2(6),
    nationality VARCHAR2(20),
    date_of_birth DATE,
    address VARCHAR2(50),
    phone NUMBER(11),
    email VARCHAR2(50),
    medical_record VARCHAR2(80));

CREATE TABLE location(
    postcode VARCHAR2(10) primary key,
    country VARCHAR2(20),
    city VARCHAR2(20),
    region VARCHAR2(20));

CREATE TABLE crime(
    crime_id VARCHAR2(20) primary key,
    crime_type VARCHAR2(10),
    crime_date DATE,
    crime_state VARCHAR2(6),
    crime_status VARCHAR2(7),
    solved_date DATE,
    postcode VARCHAR2(10) references location(postcode));

CREATE TABLE police_investigation(
    crime_id VARCHAR2(20),
    police_id VARCHAR2(8),
    primary key (crime_id, police_id),
    foreign key (crime_id) references crime(crime_id),
    foreign key (police_id) references police_officer(police_id));

CREATE TABLE crime_reporter(
    crime_reporter_id VARCHAR2(8) primary key,
    first_name VARCHAR2(20),
    surname VARCHAR2(20),
    gender VARCHAR2(6),
    nationality VARCHAR2(20),
    date_of_birth DATE,
    address VARCHAR2(50),
    phone NUMBER(11),
    email VARCHAR2(50),
    report_statement VARCHAR2(100),
    report_date DATE,
    crime_id VARCHAR2(20) references crime(crime_id),
    police_id VARCHAR2(8) references note_recorder(police_id));
    
CREATE TABLE victim(
    victim_id VARCHAR2(8) primary key,
    first_name VARCHAR2(20),
    surname VARCHAR2(20),
    gender VARCHAR2(6),
    nationality VARCHAR2(20),
    date_of_birth DATE,
    address VARCHAR2(50),
    phone NUMBER(11),
    email VARCHAR2(50),
    crime_id VARCHAR2(20) references crime(crime_id),
    police_id VARCHAR2(8) references note_recorder(police_id));

CREATE TABLE victim_detail(
    victim_detail_no VARCHAR2(8),
    personal_statement VARCHAR2(300),
    record_date DATE,
    primary key (victim_detail_no, victim_id),
    victim_id VARCHAR2(8) references victim(victim_id));

CREATE TABLE criminal(
    criminal_id VARCHAR2(8) primary key,
    first_name VARCHAR2(20),
    surname VARCHAR2(20),
    gender VARCHAR2(6),
    nationality VARCHAR2(20),
    date_of_birth DATE,
    address VARCHAR2(50),
    phone NUMBER(11),
    email VARCHAR2(50),
    background_information VARCHAR2(80),
    crime_commited NUMBER(4),
    crime_id VARCHAR2(20) references crime(crime_id),
    postcode VARCHAR2(10) references location(postcode));

CREATE TABLE offence(
    offence_id VARCHAR2(8) primary key,
    offence_type VARCHAR2(20),
    crime_id VARCHAR2(20) references crime(crime_id));

CREATE TABLE crime_offence( 
    crime_id VARCHAR2(20),
    offence_id VARCHAR2(8),
    primary key (crime_id, offence_id),
    foreign key (crime_id) references crime(crime_id),
    foreign key (offence_id) references offence(offence_id));

CREATE TABLE criminal_offence(
    criminal_id VARCHAR2(8),
    offence_id VARCHAR2(8),
    primary key (criminal_id, offence_id),
    foreign key (criminal_id) references criminal(criminal_id),
    foreign key (offence_id) references offence(offence_id));

CREATE TABLE evidence(
    evidence_id VARCHAR2(15) primary key,
    evidence_type VARCHAR2(10),
    obtain_date DATE,
    crime_id VARCHAR2(20) references crime(crime_id),
    offence_id VARCHAR2(8) references offence(offence_id),
    postcode VARCHAR2(10) references location(postcode));

CREATE TABLE object(
    evidence_id VARCHAR2(15) primary key,
    object_type VARCHAR2(30),
    amount NUMBER(3),
    foreign key (evidence_id) references evidence(evidence_id));

CREATE TABLE witness(
    evidence_id VARCHAR2(15) primary key,
    first_name VARCHAR2(20),
    surname VARCHAR2(20),
    gender VARCHAR2(6),
    nationality VARCHAR2(20),
    date_of_birth DATE,
    address VARCHAR2(50),
    phone NUMBER(11),
    email VARCHAR2(50),
    foreign key (evidence_id) references evidence(evidence_id),
    crime_id VARCHAR2(20) references crime(crime_id));

CREATE TABLE witness_detail(
    witness_detail_no VARCHAR2(8),
    personal_statement VARCHAR2(200),
    record_date DATE,
    primary key (evidence_id, witness_detail_no),
    evidence_id VARCHAR2(8) references evidence(evidence_id),
    police_id VARCHAR2(8) references detective(police_id));

CREATE TABLE criminal_object(
    criminal_id VARCHAR2(8),
    evidence_id VARCHAR2(15),
    primary key (criminal_id, evidence_id),
    foreign key (criminal_id) references criminal(criminal_id),
    foreign key (evidence_id) references object(evidence_id));

CREATE TABLE crime_suspect(
    crime_id VARCHAR2(20),
    suspect_id VARCHAR2(8),
    primary key (crime_id, suspect_id),
    foreign key (crime_id) references crime(crime_id),
    foreign key (suspect_id) references suspect(suspect_id));

CREATE TABLE detective_investigation(
    police_id VARCHAR2(8),
    suspect_id VARCHAR2(8),
    primary key (police_id, suspect_id),
    foreign key (police_id) references detective(police_id),
    foreign key (suspect_id) references suspect(suspect_id));

CREATE TABLE evidence_collection(
    police_id VARCHAR2(8),
    evidence_id VARCHAR2(15),
    primary key (police_id, evidence_id),
    foreign key (police_id) references detective(police_id),
    foreign key (evidence_id) references evidence(evidence_id));

INSERT INTO police_officer VALUES ('pc17091', 'Chris', 'Milson', 'Male', 'British', TO_DATE('03/17/1989','MM-DD-YYYY'), '2D, dream house, Sky St., Leeds, LS5 8CV', 07936021154, 'chrismilson@westyorkshire.police.uk', 'Detective Constable', 'Burglary Investigation Team');
INSERT INTO police_officer VALUES ('pc17092', 'Conan', 'Edogawa', 'Male', 'Japanese', TO_DATE('05/04/1994','MM-DD-YYYY'), '20D, dream house, Sky St., Leeds, LS5 8CV', 07999088807, 'conandetec@westyorkshire.police.uk', 'Detective Sergeant', 'Criminal Investigation Department');
INSERT INTO police_officer VALUES ('pc17093', 'Samuel', 'Li', 'Male', 'Asain', TO_DATE('05/01/1995','MM-DD-YYYY'), '42, yummy house, sweet St., Leeds, LS3 4RT', 07172737475, 'samueli@westyorkshire.police.uk', 'Chief Inspector', 'Criminal Investigation Department');
INSERT INTO police_officer VALUES ('pc17094', 'Emma', 'Walton', 'Female', 'British', TO_DATE('09/19/1990','MM-DD-YYYY'), '3E, plain house, Block St., Wrexham, LL12 8HU', 07138912040, 'emmawalton@northwales.police.uk', 'Detective Constable', 'Criminal Investigation Department');
INSERT INTO police_officer VALUES ('pc17095', 'Eddison', 'Jones', 'Male', 'British', TO_DATE('08/09/1992','MM-DD-YYYY'), '14F, Cloud House, Ground St., Leeds, LS2 9LI', 07899870123, 'eddisonjones@westyorkshire.police.uk', 'Detective Constable', 'Criminal Investigation Department');
INSERT INTO police_officer VALUES ('pc17096', 'Tommy', 'Tom', 'Male', 'British', TO_DATE('03/15/1993','MM-DD-YYYY'), '1D, rice house, fruit St., Truro, TR1 1AB', 70908070605, 'tommytom@cornwall.police.uk', 'Detective Sergeant', 'Major Investigation Team');
INSERT INTO police_officer VALUES ('pc17097', 'Harry', 'Potter', 'Male', 'British', TO_DATE('07/31/1980','MM-DD-YYYY'), '13, Hogwarts House, magic St., Ripon, HG4 9GB', 07918273645, 'harrypotter@northyorksshire.police.uk', 'Inspector', 'Major Investigation Team');
INSERT INTO police_officer VALUES ('pc17098', 'Emma', 'Emily', 'Female', 'British', TO_DATE('04/12/1990','MM-DD-YYYY'), '16, Ground house, Saint St., Newport, NP10 1AB', 07912381237, 'emmaemily@wales.police.uk', 'Detective Constable', 'Major Investigation Team');
INSERT INTO police_officer VALUES ('pc17099', 'Jerry', 'Jordan', 'Male', 'British', TO_DATE('12/12/1992','MM-DD-YYYY'), '4F, banana house, club St., Leeds, LS1 7YU', 07982346132, 'jerryjoran@westyorkshire.police.uk', 'Detective Constable', 'Drugs and Organized Crime Unit');
INSERT INTO police_officer VALUES ('pc17100', 'Mickey', 'Mouse', 'Male', 'British', TO_DATE('11/18/1998','MM-DD-YYYY'), '1C, club house, play St., Manchester, M2 2MN', 07213836756, 'mickeymouse@gmp.police.uk', 'Assistant Chief Inspector', 'Drugs and Organized Crime Unit');
INSERT INTO police_officer VALUES ('pc17101', 'Mike', 'McGrath', 'Male', 'British', TO_DATE('09/09/1990','MM-DD-YYYY'), '12, lunar house, moon St., Leeds, LS3 7GY', 07649172261, 'mikemcgrath@westyorkshire.police.uk', 'Detective Sergeant', 'Drugs and Organized Crime Unit');
INSERT INTO police_officer VALUES ('pc17102', 'Minnie', 'Mouse', 'Female', 'British', TO_DATE('11/18/1990','MM-DD-YYYY'), '1A, club house, play St., Manchester, M2 2MN', 07105809234, 'minniemouse@gmp.police.uk', 'Detective Sergeant', 'Major Investigation Team');
INSERT INTO police_officer VALUES ('pc17103', 'Grace', 'Taylor', 'Female', 'British', TO_DATE('01/04/1997','MM-DD-YYYY'), '12A, great house, well St., Manchester, M1 1FC', 07128765498, 'gracetaylor@gmp.police.uk', 'Detective Inspector', 'Burglary Investigation Team');
INSERT INTO police_officer VALUES ('pc17104', 'Sherlock', 'Holmes', 'Male', 'British', TO_DATE('01/06/1980','MM-DD-YYYY'), '221B,  Baker St., London, NW3 9AS', 07124296981, 'sherlock@cityoflondon.police.uk', 'Detective Constable', 'Drugs and Organized Crime Unit');
INSERT INTO police_officer VALUES ('pc17105', 'Ivy', 'Smith', 'Female', 'British', TO_DATE('09/09/1990','MM-DD-YYYY'), '13B, cool house, good St., London, NW4 8WA', 07128976123, 'ivysmith@cityoflondon.police.uk', 'Detective Chief Inspector', 'Criminal Investigation Department');

INSERT INTO inspector VALUES ('pc17093', 500);
INSERT INTO inspector VALUES ('pc17097', 300);
INSERT INTO inspector VALUES ('pc17100', 350);
INSERT INTO inspector VALUES ('pc17103', 250);
INSERT INTO inspector VALUES ('pc17105', 150);

INSERT INTO detective VALUES ('pc17092', 1000, 'pc17105');
INSERT INTO detective VALUES ('pc17095', 50, 'pc17105');
INSERT INTO detective VALUES ('pc17098', 14, 'pc17097');
INSERT INTO detective VALUES ('pc17101', 20, 'pc17100');
INSERT INTO detective VALUES ('pc17104', 100, 'pc17100');

INSERT INTO note_recorder VALUES ('pc17091', 'When I came back to my accommodation from the summer holiday, I saw my unit had been burglarized. I have locked all the doors and windows.', 'pc17103');
INSERT INTO note_recorder VALUES ('pc17094', 'I heard a woman scream above my unit. I believe there is somewhat of an accident.', 'pc17105');
INSERT INTO note_recorder VALUES ('pc17096', 'I saw a man chasing some people with a knife! Then I just escaped as fast as I could.', 'pc17097');
INSERT INTO note_recorder VALUES ('pc17099', 'I saw 2 guys over there sitting on the ground, and looked very suspicious, and stinks.', 'pc17100');
INSERT INTO note_recorder VALUES ('pc17102', 'I saw a man with a knife walking slowly to the bus stop. And he is trying to hide the knife.', 'pc17097');
INSERT INTO note_recorder VALUES ('pc17104', 'The car is rushing speedly on the road!', 'pc17105');

INSERT INTO suspect VALUES ('s1001', 'Marco', 'Mark', 'Male', 'British', TO_DATE('05/03/1964','MM-DD-YYYY'), '1A, Area Village, Jason St., Leeds, LS2 9QW', 07678701231, 'marckomark@gmail.com', null);
INSERT INTO suspect VALUES ('s1002', 'Samson', 'Sam', 'Male', 'Germany', TO_DATE('03/14/1980','MM-DD-YYYY'), '12B, Area Village, Jason St., Leeds, LS2 9QW', 07102937512, 'samsonsam@gmail.com', 'Hypertension, Diabetes');
INSERT INTO suspect VALUES ('s1003', 'Donald', 'Duck', 'Male', 'Fruitopia', TO_DATE('06/09/1993','MM-DD-YYYY'), '14C, fruit house, bad St., London, NW3 9AL', 07120121221, 'donaldduck@gmail.com', null);
INSERT INTO suspect VALUES ('s1004', 'Joker', 'Clown', 'Male', 'British', TO_DATE('12/05/1999','MM-DD-YYYY'), '15B, sweet house, good St., Manchester, M1 1TR', 07123498676, 'jokerclown@gmail.com', 'homicide, vandalism');
INSERT INTO suspect VALUES ('s1005', 'Ursula', 'Medusa', 'Female', 'British', TO_DATE('12/18/1993','MM-DD-YYYY'), '16A, apple house, okay St., Bangor, LL57 1AB', 07234689354, 'ursulamedusa@gmail.com', 'theft, robbery');

INSERT INTO location VALUES ('LS2 9QW', 'England', 'Leeds', 'City Centre');
INSERT INTO location VALUES ('YO3 7HN', 'England', 'York', 'Clifton');
INSERT INTO location VALUES ('LL30 1AB', 'Wales', 'Llandudno', 'West Shore');
INSERT INTO location VALUES ('SA1 1BC', 'Wales', 'Swansea', 'Uplands');
INSERT INTO location VALUES ('NW3 6JH', 'England', 'London', 'Westminster');

INSERT INTO detective_investigation VALUES ('pc17092', 's1001');
INSERT INTO detective_investigation VALUES ('pc17092', 's1002');
INSERT INTO detective_investigation VALUES ('pc17095', 's1003');
INSERT INTO detective_investigation VALUES ('pc17098', 's1004');
INSERT INTO detective_investigation VALUES ('pc17098', 's1005');

INSERT INTO crime VALUES ('brg000109142024', 'Primary', TO_DATE('09/14/2024','MM-DD-YYYY'), 'Open', 'Pending', null, 'LS2 9QW');
INSERT INTO crime VALUES ('mur000208192024', 'Primary', TO_DATE('08/19/2024','MM-DD-YYYY'), 'Open', 'Pending', null, 'YO3 7HN');
INSERT INTO crime VALUES ('drg000303132024', 'Secondary', TO_DATE('03/13/2024','MM-DD-YYYY'), 'Closed', 'Solved', TO_DATE('05/30/2024','MM-DD-YYYY'), 'SA1 1BC');
INSERT INTO crime VALUES ('spd000404272024', 'Secondary', TO_DATE('04/27/2024','MM-DD-YYYY'), 'Closed', 'Solved', TO_DATE('04/30/2024','MM-DD-YYYY'), 'NW3 6JH');
INSERT INTO crime VALUES ('dmv000501222024', 'Primary', TO_DATE('01/22/2024','MM-DD-YYYY'), 'Closed', 'Pending', null, 'LL30 1AB');

INSERT INTO crime_suspect VALUES ('brg000109142024', 's1001');
INSERT INTO crime_suspect VALUES ('brg000109142024', 's1002');
INSERT INTO crime_suspect VALUES ('dmv000501222024', 's1003');
INSERT INTO crime_suspect VALUES ('mur000208192024', 's1004');
INSERT INTO crime_suspect VALUES ('mur000208192024', 's1005');

INSERT INTO police_investigation VALUES ('brg000109142024', 'pc17091');
INSERT INTO police_investigation VALUES ('mur000208192024', 'pc17104');
INSERT INTO police_investigation VALUES ('drg000303132024', 'pc17098');
INSERT INTO police_investigation VALUES ('spd000404272024', 'pc17101');
INSERT INTO police_investigation VALUES ('dmv000501222024', 'pc17098');

INSERT INTO crime_reporter VALUES ('cr01201', 'Clement', 'Chu', 'Male', 'Asain', TO_DATE('11/04/2003','MM-DD-YYYY'), '15A, sweet home, briggate St., Leeds, LS3 4BH', 07458196482, 'clementchu@gmail.com', 'My brothers unit has been burglarized; everything is on the floor.', TO_DATE('09/14/2024','MM-DD-YYYY'), 'brg000109142024', 'pc17091');
INSERT INTO crime_reporter VALUES ('cr01202', 'Daniel', 'Danan', 'Male', 'American', TO_DATE('02/11/2002','MM-DD-YYYY'), '2C, lovely home, poke St., York, YO1 0SF', 07786321452, 'daneildd@gmail.com', 'Help! I saw a man masked with a knife! He has damaged people at the bus stop!', TO_DATE('08/19/2024','MM-DD-YYYY'), 'mur000208192024', 'pc17102');
INSERT INTO crime_reporter VALUES ('cr01203', 'Marry', 'Marie', 'Female', 'Canadian', TO_DATE('05/29/2004','MM-DD-YYYY'), '23C, housey house, hope St., London, NW1 4NP', 07123455432, 'mmary@gmail.com', 'I saw a creepy woman crouching in an alley, I thought she is doing drugs.', TO_DATE('03/13/2024','MM-DD-YYYY'), 'drg000303132024', 'pc17099');
INSERT INTO crime_reporter VALUES ('cr01204', 'Lussie', 'Lucy', 'Female', 'Russian', TO_DATE('08/14/2024','MM-DD-YYYY'), '9B, Emohy home, queen St., Cardiff, CF10 3NB', 07987655678, 'luusee@gmail.com', 'That car is definitely overspeeding! That is too fast, its dangerous!', TO_DATE('04/27/2024','MM-DD-YYYY'), 'spd000404272024', 'pc17104');
INSERT INTO crime_reporter VALUES ('cr01205', 'Markson', 'Mark', 'Male', 'British', TO_DATE('09/12/2024','MM-DD-YYYY'), '10F, Area Village, Jason St., Leeds, LS2 9QW', 07123456789, 'mamark@gmail.com', 'I believe that couple are having an argument again, I heard they are fighting!', TO_DATE('01/25/2024','MM-DD-YYYY'), 'dmv000501222024', 'pc17094');

INSERT INTO Victim VALUES ('vm1011', 'Cyrus', 'Chu', 'Male', 'Asain', TO_DATE('06/02/2005','MM-DD-YYYY'), '11A, Area Village, Jason St., Leeds, LS2 9QW', 07773102609, 'cyruschu@gmail.com', 'brg000109142024', 'pc17091');
INSERT INTO Victim VALUES ('vm1012', 'Zizzi', 'Zizie', 'Female', 'Indian', TO_DATE('01/12/1989','MM-DD-YYYY'), '23B, Parkside Horizon, High St., York, Y04 1AB', 07484356312, 'zizizyzy@gmail.com', 'mur000208192024', 'pc17102');
INSERT INTO Victim VALUES ('vm1013', 'Karen', 'Kraken', 'Female', 'British', TO_DATE('12/12/2002','MM-DD-YYYY'), '45D, Metro Aurora, Light St., Swansea, SA2 2EF', 07768553053, 'krakren@gmail.com', 'mur000208192024', 'pc17096');
INSERT INTO Victim VALUES ('vm1014', 'Emily', 'Emma', 'Female', 'British', TO_DATE('05/31/2004','MM-DD-YYYY'), '67F, Skyline Garden, Green St., London, NW1 4NP', 07294837453, 'emmie@gmail.com', 'dmv000501222024', 'pc17094');
INSERT INTO Victim VALUES ('vm1015', 'Jimmy', 'James', 'Male', 'French', TO_DATE('08/31/2003','MM-DD-YYYY'), '78C, Modern Gorden, Keen St., Llandudno, LL30 4VA', 07938453124, 'jimjam@gmail.com', 'mur000208192024', 'pc17102');

INSERT INTO victim_detail VALUES ('c1011', 'When I came back to my accommodation from summer holiday, I saw my unit has been burglarised. I have locked all the doors and windows.', TO_DATE('09/14/2024','MM-DD-YYYY'), 'vm1011');
INSERT INTO victim_detail VALUES ('c1012', 'It is a sunny day; I am returning back home after work. I saw a person with a knife all in a sudden at a corner on the road. Then he stabbed me 3 times and ran.', TO_DATE('08/21/2024','MM-DD-YYYY'), 'vm1013');
INSERT INTO victim_detail VALUES ('c1013', 'I am walking back home from school library, then I felt a sudden pain on my back. It was really painful! Then I turned around, and saw a man with a black mask, and he got a knife! So, I just tried to run quickly as I could. Then, I am safely be rescued and sent to the hospital.', TO_DATE('08/20/2024','MM-DD-YYYY'), 'vm1012');
INSERT INTO victim_detail VALUES ('c1014', 'I am just listening to music and chilling on the bus stop. I never thought this will happen to me. When I am waiting for the bus, there is a man nicked my arm with a knife. It is sharp. After that, that man just ran away quickly ', TO_DATE('08/21/2024','MM-DD-YYYY'), 'vm1015');
INSERT INTO victim_detail VALUES ('c1015', 'He is my love of all time. No matter what, I dont believe he will do that to me. Even so, maybe he is just quite emotional at the moment. But this time is way too severe. He punched me several times at that night, I could not tolerate it anymore! ', TO_DATE('01/26/2024','MM-DD-YYYY'), 'vm1014');

INSERT INTO criminal VALUES ('crm0123', 'Ethan', 'Hann', 'Male', 'Brazilian', TO_DATE('12/09/1990','MM-DD-YYYY'), '1B, hostel house, Joban St., Stonegate, TN7 2EV', 07213269414, 'hanethan@gmail.com', 'robbery, fraud, burglary', 3, 'mur000208192024', 'LS2 9QW');
INSERT INTO criminal VALUES ('crm0124', 'Issac', 'Hann', 'Male', 'Brazilian', TO_DATE('12/15/1990','MM-DD-YYYY'), '1A, hostel house, Joban St., Stonegate, TN7 2EV', 07375983447, 'hanissac@gmail.com', 'robbery, selling drugs', 2, 'dmv000501222024', 'LL30 1AB');
INSERT INTO criminal VALUES ('crm0125', 'Fiona', 'Finn', 'Female', 'British', TO_DATE('03/04/1981','MM-DD-YYYY'), '3F, Harbour view, Saint St., Leeds, LS1 9UB', 07107025193, 'fionafin@gmail.com', null, 0, 'spd000404272024', 'NW3 6JH');
INSERT INTO criminal VALUES ('crm0126', 'Jameson', 'James', 'Male', 'German', TO_DATE('05/06/1987','MM-DD-YYYY'), '5E, Azure house, Raven St., Liverpool, CH49 3KJ', 07412479785, 'jjames@gmail.com', 'drunk, driving', 1, 'drg000303132024', 'SA1 1BC');
INSERT INTO criminal VALUES ('crm0127', 'Jimmy', 'John', 'Male', 'German', TO_DATE('03/01/1987','MM-DD-YYYY'), '7F, Azure house, Raven St., Liverpool, CH49 3KI', 07391056123, 'jimmyjogn@gmail.com', null, 0, 'drg000303132024', 'SA1 1BC');

INSERT INTO offence VALUES ('of8001', 'Burglary', 'brg000109142024');
INSERT INTO offence VALUES ('of3001', 'Murder', 'mur000208192024');
INSERT INTO offence VALUES ('of6006', 'Doing Drug' , 'drg000303132024');
INSERT INTO offence VALUES ('of6008', 'Domestic Violence', 'dmv000501222024');
INSERT INTO offence VALUES ('of7001', 'Speeding', 'spd000404272024');

INSERT INTO criminal_offence VALUES ('crm0123', 'of3001');
INSERT INTO criminal_offence VALUES ('crm0124', 'of6008');
INSERT INTO criminal_offence VALUES ('crm0125', 'of7001');
INSERT INTO criminal_offence VALUES ('crm0126', 'of6006');
INSERT INTO criminal_offence VALUES ('crm0127', 'of6006');

INSERT INTO crime_offence VALUES ('brg000109142024', 'of8001');
INSERT INTO crime_offence VALUES ('mur000208192024', 'of3001');
INSERT INTO crime_offence VALUES ('drg000303132024', 'of6006');
INSERT INTO crime_offence VALUES ('spd000404272024', 'of7001');
INSERT INTO crime_offence VALUES ('dmv000501222024', 'of6008');

INSERT INTO evidence VALUES ('ob1001', 'object', TO_DATE('09/14/2024','MM-DD-YYYY'), 'brg000109142024', 'of8001', 'LS2 9QW');
INSERT INTO evidence VALUES ('ob1002', 'object', TO_DATE('09/14/2024','MM-DD-YYYY'), 'brg000109142024', 'of8001', 'LS2 9QW');
INSERT INTO evidence VALUES ('wt1001', 'witness', TO_DATE('08/19/2024','MM-DD-YYYY'), 'mur000208192024', 'of3001', 'YO3 7HN');
INSERT INTO evidence VALUES ('ob1003', 'object', TO_DATE('08/19/2024','MM-DD-YYYY'), 'mur000208192024', 'of3001', 'YO3 7HN');
INSERT INTO evidence VALUES ('wt1002', 'witness', TO_DATE('03/13/2024','MM-DD-YYYY'), 'drg000303132024', 'of6006', 'SA1 1BC');
INSERT INTO evidence VALUES ('ob1004', 'object', TO_DATE('03/13/2024','MM-DD-YYYY'), 'drg000303132024', 'of6006', 'SA1 1BC');
INSERT INTO evidence VALUES ('wt1003', 'witness', TO_DATE('04/27/2024','MM-DD-YYYY'), 'spd000404272024', 'of7001', 'NW3 6JH');
INSERT INTO evidence VALUES ('wt1004', 'witness', TO_DATE('01/25/2024','MM-DD-YYYY'), 'dmv000501222024', 'of6008', 'LL30 1AB');
INSERT INTO evidence VALUES ('wt1005', 'witness', TO_DATE('01/25/2024','MM-DD-YYYY'), 'dmv000501222024', 'of6008', 'LL30 1AB');
INSERT INTO evidence VALUES ('ob1005', 'object', TO_DATE('01/26/2024','MM-DD-YYYY'), 'dmv000501222024', 'of6008', 'LL30 1AB');

INSERT INTO object VALUES ('ob1001', 'water bottle', 1);
INSERT INTO object VALUES ('ob1002', 'tape dispenser', 1);
INSERT INTO object VALUES ('ob1003', 'jacket', 2);
INSERT INTO object VALUES ('ob1004', 'white powder in plastic bag', 3);
INSERT INTO object VALUES ('ob1005', 'broken bowl', 5);

INSERT INTO witness VALUES ('wt1001', 'Henry', 'John', 'Male', 'British', TO_DATE('01/01/2004','MM-DD-YYYY'), '12A, Saint Johnson, mint St., Leeds, LS1 4IH', 07812001304, 'henryj@gmail.com', 'mur000208192024');
INSERT INTO witness VALUES ('wt1002', 'Jason', 'Jack', 'Male', 'American', TO_DATE('02/15/2002','MM-DD-YYYY'), '13B, Donaldson house, Hond St., York, YO6 6OY', 07324565442, 'jasonj@gmail.com', 'drg000303132024');
INSERT INTO witness VALUES ('wt1003', 'Daisy', 'Marie', 'Female', 'French', TO_DATE('05/16/2001','MM-DD-YYYY'), '14C, Kitson Park, Lish St., Liverpool, CH30 1MN', 07918273645, 'daisymarie@gmail.com', 'spd000404272024');
INSERT INTO witness VALUES ('wt1004', 'Ariel', 'Kelly', 'Female', 'Australian', TO_DATE('06/06/2003','MM-DD-YYYY'), '15D, Linde house, Road St., Leeds, LS7 9BU', 07192837465, 'arielkelly@gmail.com', 'dmv000501222024');
INSERT INTO witness VALUES ('wt1005', 'Chioma', 'Accu', 'Male', 'Nigerian', TO_DATE('07/07/2000','MM-DD-YYYY'), '16E, Whish house, Mona St., Leeds, LS1 1PK', 07908978675, 'chiomaaccu@gmail.com', 'dmv000501222024');

INSERT INTO witness_detail VALUES ('wd1101', 'That day is unforgettable, I was as usual walking to the bus stop from school, then I saw a man with a knife is rushing to a person inside the bus stop. So, I just hide until he goes away.', TO_DATE('08/19/2024','MM-DD-YYYY'), 'wt1001', 'pc17095');
INSERT INTO witness_detail VALUES ('wd1102', 'It is at night, and I am walking back home that day. when I pass through an alley, I saw a creepy man squat down and seem is doing drugs.', TO_DATE('03/13/2024','MM-DD-YYYY'), 'wt1002', 'pc17104');
INSERT INTO witness_detail VALUES ('wd1103', 'I am hanging out with my friends, and a speedy car rush through on the street. The car is really fast, makes me though Im inside a game.', TO_DATE('04/27/2024','MM-DD-YYYY'), 'wt1003', 'pc17098');
INSERT INTO witness_detail VALUES ('wd1104', 'I am just chilling inside me home; it is at night. I am watching my favourite manga. Suddenly, I heard a screaming of a women! Her voice makes me feel worried.', TO_DATE('01/25/2024','MM-DD-YYYY'), 'wt1004', 'pc17092');
INSERT INTO witness_detail VALUES ('wd1105', 'I heard a voice exactly when I came back to my accommodation downstairs. I heard a loud voice, and I think it is a woman screams with a terrify emotion. That is not common.', TO_DATE('01/25/2024','MM-DD-YYYY'), 'wt1005', 'pc17095');

INSERT INTO criminal_object VALUES ('crm0123', 'ob1003');
INSERT INTO criminal_object VALUES ('crm0124', 'ob1005');
INSERT INTO criminal_object VALUES ('crm0126', 'ob1004');
INSERT INTO criminal_object VALUES ('crm0127', 'ob1004');

INSERT INTO evidence_collection VALUES ('pc17092', 'ob1001');
INSERT INTO evidence_collection VALUES ('pc17092', 'wt1004');
INSERT INTO evidence_collection VALUES ('pc17092', 'ob1005');
INSERT INTO evidence_collection VALUES ('pc17095', 'ob1002');
INSERT INTO evidence_collection VALUES ('pc17095', 'wt1003');
INSERT INTO evidence_collection VALUES ('pc17095', 'wt1005');
INSERT INTO evidence_collection VALUES ('pc17098', 'wt1001');
INSERT INTO evidence_collection VALUES ('pc17098', 'ob1003');
INSERT INTO evidence_collection VALUES ('pc17101', 'ob1004');
INSERT INTO evidence_collection VALUES ('pc17104', 'wt1002');
INSERT INTO evidence_collection VALUES ('pc17104', 'ob1004');
 
