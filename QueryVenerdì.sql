/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++  Creazione tabelle +++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */



CREATE TABLE Anagrafica (
id_Anagrafica INT PRIMARY KEY NOT NULL IDENTITY,
Cognome NVARCHAR(50) NOT NULL,
Nome NVARCHAR(50) NOT NULL,
Indirizzo NVARCHAR(100) NOT NULL,
Citta NVARCHAR(50) NOT NULL,
CAP CHAR(5) NOT NULL,
Cod_Fisc CHAR(16) NOT NULL UNIQUE
)

CREATE TABLE Violazione (
id_Violazione INT PRIMARY KEY NOT NULL IDENTITY,
Descrizione NVARCHAR(100) NOT NULL
)

CREATE TABLE Verbali (
id_Verbale INT PRIMARY KEY NOT NULL IDENTITY,
Data_Violazione DATE NOT NULL,
Indirizzo_Violazione NVARCHAR(100) NOT NULL,
-- Nominativo Agente 100 perchè contiene sia nome che cognome
Nominativo_Agente NVARCHAR(100) NOT NULL,
Data_Trascrizione_Verbale DATE NOT NULL,
Importo MONEY NOT NULL,
Decurtamento_Punti SMALLINT NOT NULL,
id_Violazione INT,
id_Anagrafica INT,

	CONSTRAINT FK_Verbale_Violazione FOREIGN KEY (id_Violazione) REFERENCES Violazione (id_Violazione),
	CONSTRAINT FK_Verbale_Anagrafica FOREIGN KEY (id_Anagrafica) REFERENCES Anagrafica (id_Anagrafica)
)


/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++  Popolamento delle tabelle create poco sopra +++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

/*

INSERT INTO Anagrafica 
VALUES 
('Lobbia', 'Francesco', 'Corso Abbiate 124', 'Vercelli', '13100', 'LBBFNC12345L789Y'),
('Monkey D', 'Luffy', 'Corso Foosha', 'Goa', '13100', 'MNKLFF12345L789Y'),
('Uzumaki', 'Naruto', 'Corso della foglia', 'Milano', '27100', 'ABCDEF12345L789Y'),
('Son', 'Goku', 'Via dei Sayan', 'Città dell Ovest', '10500', 'GKUSJJ12345L789Y')


INSERT INTO Violazione 
VALUES 
('Crimine informatico'),
('Eccesso di velocita'),
('furto'),
('appropriazione indebita')



*/

