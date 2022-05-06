CREATE TABLE stagiaires
(
 id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
 nom VARCHAR(100),
 prenom VARCHAR(100)
 );

 CREATE TABLE centres
(
 id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
 nom VARCHAR(100),
 lieu VARCHAR(100),
 specialite VARCHAR(100)
 );

INSERT INTO stagiaires (nom, prenom) VALUES 
('Camara', 'Moussa'),
('Dupont', 'Jean'), 
('Henri', 'Zack'),
('Bidule', 'Machin');

INSERT INTO centres (nom, lieu, specialite) VALUES 
('Afpa', 'Paris', 'CDA'),
('Afpa', 'Marseille', 'Dev mobile'), 
('Afpa', 'Lyon', 'marketing');

UPDATE stagiaires SET prenom = 'Kassimi' WHERE id = 3;

ALTER TABLE stagiaires ADD email VARCHAR(100);

DELETE FROM stagiaires WHERE nom = 'Bidule';

INSERT INTO stagiaires (nom, prenom, email) VALUES ('Sultan', 'Vanessa', 'vanessa@afpa.fr');

------------------ Exo avion pilote vol
CREATE TABLE avion 
(
    numeroAv INT PRIMARY KEY AUTO_INCREMENT,
    nomAv VARCHAR(100),
    capacite INT(4),
    localisation VARCHAR(100)
);

CREATE TABLE vol
(
    idVol INT PRIMARY KEY AUTO_INCREMENT,
    numVol VARCHAR(6),
    numPilote INT,
    numAv INT,
    villeDepart VARCHAR(100),
    villeArrivee VARCHAR(100),
    heureDepart TIME,
    heureArrivee TIME,
    CONSTRAINT fk_numPilote FOREIGN KEY (numPilote)
    REFERENCES pilote(numPilote),
    CONSTRAINT fk_numAv FOREIGN KEY (numAv)
    REFERENCES avion(numeroAv)
);

CREATE TABLE pilote
(
    numPilote INT PRIMARY KEY AUTO_INCREMENT,
    nomPilote VARCHAR(100),
    adresse VARCHAR (100),
    salaire INT(6)
);

INSERT INTO avion(numeroAv, nomAv, capacite, localisation) VALUES
(NULL, "Alpha", 300, "Paris"),
(NULL, "Delta", 400, "Milan"),
(NULL, "Delta", 350, "Rome");

INSERT INTO pilote(numPilote, nomPilote, adresse, salaire) VALUES
(NULL, "Moussa", "Paris", 650000),
(NULL, "Afpa", "Marseille", 900000),
(NULL, "Zack", "Cergy", 750901),
(NULL, "Zack", "Cergy", 350000);

INSERT INTO vol VALUES
(NULL, "AF351", 1, 1, "Paris", "New York", "9:00:00", "17:00:00"),
(NULL, "RU154", 2, 2, "Montréal", "Londres", "13:00:00", "22:00:00"),
(NULL, "LH1792", 3, 3, "Paris", "Tunis", "11:00:00", "21:00:00");

-- requete 1
SELECT * FROM pilote;

-- requete 2
SELECT numPilote, villeDepart FROM vol;

-- requete 3
SELECT nomAv, capacite FROM avion WHERE capacite >= 350;

-- requete 4
SELECT numeroAv, nomAv FROM avion WHERE localisation = "Paris";

-- requete 5
SELECT COUNT(DISTINCT localisation)  FROM avion;

-- requete 6
SELECT nomPilote FROM pilote WHERE adresse = "Cergy" AND salaire > 500000;

-- requete 7
SELECT numeroAv, nomAv FROM avion WHERE localisation = "Paris" OR capacite <= 350;

-- requete 8
SELECT numVol FROM vol WHERE villeDepart = "Paris" AND villeArrivee = "New York" AND heureDepart >= "09:00:00";

-- requete 9
SELECT numPilote FROM pilote WHERE numPilote NOT IN (SELECT numPilote FROM vol);

-- requete 10
SELECT numVol, villeDepart FROM vol WHERE numPilote = 1 OR numPilote = 2;

-- requete 11
SELECT nomPilote FROM pilote WHERE nomPilote LIKE "z%";

-- requete 12
SELECT nomPilote FROM pilote WHERE nomPilote LIKE "__u%";

------- exo musique
CREATE TABLE representation
(
    num_rep INT PRIMARY KEY AUTO_INCREMENT,
    titre_rep VARCHAR(100),
    lieu VARCHAR(100)
);

CREATE TABLE musicien
(
    num_mus INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100),
    num_rep INT,
    CONSTRAINT fk_num_rep FOREIGN KEY (num_rep)
    REFERENCES representation(num_rep)
);

CREATE TABLE programmer
(
    id_prog INT PRIMARY KEY AUTO_INCREMENT,
    date_rep DATE,
    num_rep INT,
    tarif INT,
    CONSTRAINT fk_num_rep_prog FOREIGN KEY (num_rep)
    REFERENCES representation(num_rep)
);

INSERT INTO representation(titre_rep, lieu) VALUES
("erat vel pede","Stratford"),
("porta eli","Develi"),
("ornare elit elit","Vienna"),
("tellus Nunc lectus","Isabela City"),
("suscipit nonummy Fusce","Vologda");

INSERT INTO musicien(nom,num_rep) VALUES
("Emmanuel Meyer",3),
("Robin Calderon",2),
("Timothy Welch",4),
("Stone Bush",4),
("Brenden Klein",1);

INSERT INTO programmer(date_rep,num_rep,tarif) VALUES
("20220607",3,27),
("20210930",2,19),
("20221014",4,71),
("20210826",4,59),
("20220930",1,47);

---- requete 1
SELECT titre_rep FROM representation;

--- requete 2
SELECT titre_rep FROM representation WHERE lieu="théâtre JCC";

--- requete 3
SELECT nom, titre_rep FROM musicien, representation WHERE musicien.num_rep = representation.num_rep;

--- requete 4
SELECT titre_rep, lieu, tarif FROM representation INNER JOIN programmer ON representation.num_rep = programmer.num_rep WHERE date_rep = "20220607" ;

--- requete 5
SELECT COUNT(num_mus) FROM musicien WHERE num_rep=4;

--- requete 6
SELECT titre_rep,lieu,date_rep, tarif FROM representation INNER JOIN programmer ON representation.num_rep = programmer.num_rep WHERE tarif < 30;


----------------------------------------------
-------Exo département Employés
CREATE TABLE departements
(
    dNo INT PRIMARY KEY AUTO_INCREMENT,
    dNom VARCHAR(100),
    directeur VARCHAR(100),
    ville VARCHAR(100)
);

CREATE TABLE employes
(
    eNo INT PRIMARY KEY AUTO_INCREMENT,
    eNom VARCHAR(100),
    profession VARCHAR(100),
    dateEmbauche DATE,
    salaire INT(6),
    commission VARCHAR(100),
    dNo INT,
    CONSTRAINT fk_dNo FOREIGN KEY (dNo)
    REFERENCES departements(dNo)
);


INSERT INTO employes(eNom, profession, dateEmbauche, salaire, commission, dNo) VALUES
("Lester Craft","développeur,","20230508",63000,"ZZZZZZZ",5),
("Malik Lindsey","développeur","20210728",89000,"AAAAAAA",2),
("Jameson Warner","chef de projet","20220725",58000,NULL,2),
("Jerome Allen","graphiste","20220515",90000,NULL,5),
("Igor Moreno","comptable","20220720",51000,"BBBBBB",3);

--  1- Donnez la liste des employés ayant une commission
SELECT eNom FROM employes WHERE commission = NULL;

-- 2- Donnez les noms, emplois et salaires des employés par emploi croissant, et pour chaque emploi, par salaire décroissant
SELECT eNom, profession, salaire FROM employes GROUP BY profession, salaire DESC;
-- 3- Donnez le salaire moyen des employés
SELECT AVG(salaire) FROM employes;
-- 4- Donnez le salaire moyen du département Production
SELECT AVG(salaire) FROM employes INNER JOIN departements ON departements.dNo = employes.dNo WHERE dNom = "B";

-- 5- Donnez les numéros de département et leur salaire maximum
SELECT employes.dNo, MAX(salaire) FROM employes INNER JOIN departements ON departements.dNo = employes.dNo GROUP BY dNo;

-- 6- Donnez les différentes professions et leur salaire moyen
SELECT profession, AVG(salaire)  AS salaireMoyen FROM employes INNER JOIN departements ON departements.dNo = employes.dNo GROUP BY profession;

-- 7- Donnez le salaire moyen par profession le plus bas
SELECT MIN(salaireMoyen) FROM employes INNER JOIN departements ON departements.dNo = employes.dNo GROUP BY profession HAVING (AVG(salaire)) AS salaireMoyen;


-- 8- Donnez le ou les emplois ayant le salaire moyen le plus bas, ainsi que ce salaire 