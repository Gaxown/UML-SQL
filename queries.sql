CREATE TABLE Utilisateurs(
	id_utilisateur INT AUTO_INCREMENT,
	nom_utilisateur VARCHAR(50),
	mot_de_pass VARCHAR(50),
	email VARCHAR(50),
	PRIMARY KEY(id_utilisateur)
);


SELECT * FROM  Utilisateurs


INSERT INTO Utilisateurs (nom_utilisateur, mot_de_pass, email) VALUES (
	'Gaxown',
	'azerty@123',
	'test@outlook.com'
);

INSERT INTO Utilisateurs (nom_utilisateur, mot_de_pass, email) VALUES (
	'Gigi',
	'qwerty',
	'gigi@gmail.com'
);
INSERT INTO Utilisateurs (nom_utilisateur, mot_de_pass, email) VALUES (
	'Ninja	',
	'azerty@$$$',
	'minja@outlook.com'
);


CREATE TABLE Categories(
	id_categorie INT AUTO_INCREMENT,
	nom_categorie VARCHAR(50),
	PRIMARY KEY(id_categorie)
);

SELECT * FROM Categories


CREATE TABLE Temoignage(
	id_temoignage INT AUTO_INCREMENT,
	commentaire VARCHAR(50),
	id_utilisateur INT,
	PRIMARY KEY(id_temoignage),
	FOREIGN KEY(id_utilisateur) REFERENCES utilisateurs(id_utilisateur)
);

SELECT * FROM Temoignage


CREATE TABLE Projets(
	id_projet INT AUTO_INCREMENT,
	titre_projet VARCHAR(50),
	description VARCHAR(500),
	id_categorie INT,
	id_sous_categorie INT,
	id_utilisateur INT,
	PRIMARY KEY(id_projet),
	FOREIGN KEY (id_categorie) REFERENCES Categories(id_categorie),
	FOREIGN KEY (id_sous_categorie) REFERENCES Sous_Categories(id_sous_categorie),
	FOREIGN KEY (id_utilisateur) REFERENCES Utilisateurs(id_utilisateur)
);

CREATE TABLE Sous_Categories(
	id_sous_categorie INT AUTO_INCREMENT,
	nom_sous_categorie VARCHAR(50),
	id_categorie INT,
	PRIMARY KEY(id_sous_categorie),
	FOREIGN KEY(id_categorie) REFERENCES Categories(id_categorie)
);


SELECT * FROM Projets

CREATE TABLE Freelances(
	id_freelance INT AUTO_INCREMENT,
	nom_freelance VARCHAR(50),
	competences VARCHAR(50),
	id_utilisateur INT, 
	PRIMARY KEY(id_freelance),
	FOREIGN KEY(id_utilisateur) REFERENCES Utilisateurs(id_utilisateur)
);

SELECT * FROM Freelances


CREATE TABLE Offres(
	id_offre INT AUTO_INCREMENT,
	montant DECIMAL(5, 5),
	delai DATE,
	id_freelance INT, 
	id_projet INT,
	PRIMARY KEY(id_offre),
	FOREIGN KEY(id_freelance) REFERENCES Freelances(id_freelance),
	FOREIGN KEY(id_projet) REFERENCES Projets(id_projet)
);

SELECT * FROM Offres


ALTER TABLE Projets
ADD COLUMN date_creation TIMESTAMP	DEFAULT CURRENT_TIMESTAMP;

SELECT * FROM Projets


INSERT INTO Offres (montant, delai, id_freelance, id_projet) VALUES (1000.50, '20-10-2019', 1, 1);

DESCRIBE	Offres;

ALTER TABLE Offres 
MODIFY COLUMN montant DECIMAL(7,2);


INSERT INTO Offres (montant, delai, id_freelance, id_projet) VALUES (1000.50, '2019-10-20', 1, 1);
DESCRIBE Freelances

INSERT INTO Freelances(nom_freelance, competences, id_utilisateur) VALUES (1000.50, 'chi7aja', 1);


USE db


SELECT * FROM sous_categories

INSERT INTO categories(nom_categorie) VALUES ('IT')

INSERT INTO sous_categories(nom_sous_categorie, id_categorie) VALUES ('Web Dev', 1)

UPDATE sous_categories SET nom_sous_categorie = 'Cyber Sec' WHERE nom_sous_categorie = 'IT'

INSERT INTO Projets(titre_projet, DESCRIPTION, id_categorie, id_sous_categorie, id_utilisateur, date_creation) VALUES ('Fil Rouge', 'chi7aja dyal description', 1, 1, 1, '2014-10-25');



SELECT * FROM projets


UPDATE projets SET DESCRIPTION = 'ma9do fil zadoh fila' WHERE titre_projet = 'Fil Rouge'


SELECT * FROM projets


SELECT * FROM temoignage


INSERT INTO temoignage(commentaire, id_utilisateur) VALUES ('ah chefto bi3ayni', 1)

INSERT INTO temoignage(commentaire, id_utilisateur) VALUES ('a llaa', 1)

SELECT * FROM temoignage


DELETE FROM temoignage WHERE commentaire = 'a llaa'


SELECT * FROM projets

INSERT INTO categories(nom_categorie) VALUES ('other')


INSERT INTO Projets(titre_projet, DESCRIPTION, id_categorie, id_sous_categorie, id_utilisateur, date_creation) VALUES ('Fil Rouge', 'chi7aja dyal description', 2, 1, 1, '2020-01-17');
INSERT INTO Projets(titre_projet, DESCRIPTION, id_categorie, id_sous_categorie, id_utilisateur, date_creation) VALUES ('projet akhor', 'description akhra', 1, 1, 1, '2020-01-17');



SELECT projets.id_projet, projets.titre_projet, projets.DESCRIPTION, projets.id_categorie, categories.nom_categorie, projets.id_sous_categorie, projets.id_utilisateur, projets.date_creation FROM projets 
JOIN categories 
ON projets.id_categorie = categories.id_categorie
WHERE categories.nom_categorie = 'IT'

SELECT Projets.*, categories.id_categorie, categories.nom_categorie FROM projets JOIN categories ON projets.id_categorie = categories.id_categorie

-- Indexes


CREATE INDEX 
 ON categories(nom_categorie)

CREATE INDEX idx_id_utilisateur_temoignage ON Temoignage(id_utilisateur)

CREATE INDEX idx_projet_titre_categorie ON Projets(titre_projet, id_categorie)

CREATE INDEX idx_id_freelance ON Offres(id_freelance)

CREATE INDEX idx_id_projet ON Offres(id_projet)


-- Constraints

ALTER TABLE utilisateurs MODIFY COLUMN nom_utilisateur VARCHAR(50) NOT NULL

ALTER TABLE utilisateurs MODIFY COLUMN email VARCHAR(50) NOT NULL

ALTER TABLE utilisateurs ADD CONSTRAINT check_email_format CHECK (email LIKE '%@%')

ALTER TABLE Offres ADD CONSTRAINT check_montant_positive CHECK (montant > 0)

ALTER TABLE Categories ADD CONSTRAINT unique_nom_categorie UNIQUE (nom_categorie)


-- Stored Procedure Creation
DELIMITER $$

CREATE PROCEDURE addProject (
    IN arg_titre_projet VARCHAR(50),
    IN arg_description VARCHAR(50),
    IN arg_id_categorie INT,
    IN arg_id_sous_categorie INT,
    IN arg_id_utilisateur INT
)
BEGIN 

    IF NOT EXISTS (SELECT 1 FROM Categories WHERE id_categorie = arg_id_categorie) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Category Not Found !!!';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Utilisateurs WHERE id_utilisateur = arg_id_utilisateur) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User Not Found !!!';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Sous_Categories WHERE id_sous_categorie = arg_id_sous_categorie) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sub Category Not Found !!!';
    END IF;

    INSERT INTO Projets (titre_projet, description, id_categorie, id_sous_categorie, id_utilisateur)
    VALUES (arg_titre_projet, arg_description, arg_id_categorie, arg_id_sous_categorie, arg_id_utilisateur);

END $$

DELIMITER ;



-- Procedure Call
CALL addProject('test project creation', 'test description', 1, 1, 1)

SELECT * FROM Projets


EXPLAIN SELECT projets.id_projet, projets.titre_projet, categories.nom_categorie
FROM projets
JOIN categories ON projets.id_categorie = categories.id_categorie
WHERE categories.nom_categorie = 'IT';

