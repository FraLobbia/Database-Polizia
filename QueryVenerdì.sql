/*Un corpo di Polizia Municipale intende creare un database per la gestione delle contravvenzioni ed i relativi pagamenti.
Il database dovrà gestire un’anagrafica clienti, una entità per contenere i tipi di violazioni contestate ed un’altra per annotare ed archiviare il verbale.
In virtù di quanto sopra creare le seguenti entità. 

ANAGRAFICA (idanagrafica, Cognome, Nome, Indirizzo, Città, CAP, Cod_Fisc);
TIPO VIOLAZIONE (idviolazione, descrizione);
VERBALE (idverbale, DataViolazione, IndirizzoViolazione, Nominativo_Agente, DataTrascrizioneVerbale, Importo, DecurtamentoPunti);

1. Inserire in modo appropriato i campi per effettuare le relative relazioni
2. Gestire in modo appropriato i tipi di campi, chiavi primarie, chiavi esterne per ogni campo di ogni tabella
3. Creare le corrette relazioni alle tabelle
4. Popolare le tabelle manualmente con dati a piacimento. 
*/

--CREAZIONE TABELLE  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

		
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
			)
		

--POPOLAMENTO TABELLE ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

		
			INSERT INTO Anagrafica 
			VALUES 
			('Lobbia', 'Francesco', 'Corso Abbiate 124', 'Vercelli', '13100', 'LBBFNC12345L789Y'),
			('Monkey D', 'Luffy', 'Corso Foosha', 'Goa', '13100', 'MNKLFF12345L789Y'),
			('Uzumaki', 'Naruto', 'Corso della foglia', 'Palermo', '27100', 'ABCDEF12345L789Y'),
			('Son', 'Goku', 'Via dei Sayan', 'Città dell Ovest', '10500', 'GKUSJJ12345L789Y')
			INSERT INTO Violazione 
			VALUES 
			('Crimine informatico'),
			('Eccesso di velocita'),
			('furto'),
			('appropriazione indebita')



			INSERT INTO Verbali 
			VALUES 
			('2009-02-06', 'viale rimembranza', 'Pluto_Minni', '2009-02-09', '200', 4,1,1),
			('2024-02-06', 'viale pippo', 'Pluto_Minni', '2024-02-12', '200', 2,1,3),
			('2024-02-06', 'viale libertà', 'Pluto_Minni', '2024-02-23', '200', 2,3,1),
			('2009-02-06', 'viale dei giardini', 'Pluto_Minni', '2009-04-04', '200', 7,1,2),
			('2024-02-06', 'viale della felicità', 'Pluto_Minni', '2024-02-12', '200', 2,8,1),
			('2024-02-06', 'viale dei pini', 'Pluto_Minni', '2024-02-11', '200', 3,4,4),
			('2009-02-06', 'viale dei franchi', 'Pluto_Minni', '2024-02-12', '200', 2,1,3),
			('2024-02-06', 'viale di franco', 'Pluto_Minni', '2024-02-10', '200', 7,7,4)

-- QUERY ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--1. Conteggio dei verbali trascritti, 

			select Count(*) as Totale_Verbali from verbali 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--2. Conteggio dei verbali trascritti raggruppati per anagrafe, 

			SELECT Cognome, Nome, COUNT(*) AS Totale_Verbali 
			FROM Anagrafica AS A
			INNER JOIN Verbali AS V
			ON A.id_Anagrafica = V.id_Anagrafica
			GROUP BY A.id_Anagrafica, A.Cognome, A.Nome
			
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--3. Conteggio dei verbali trascritti raggruppati per tipo di violazione, 

			
			SELECT Descrizione, COUNT(*) AS verbali_per_violazione
			FROM Violazione AS Viol
			INNER JOIN Verbali AS Verb 
			ON Viol.id_Violazione = Verb.id_Violazione
			GROUP BY Viol.Descrizione
			
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--4. Totale dei punti decurtati per ogni anagrafe, 
	
			
			SELECT A.id_Anagrafica, Nome, Cognome, SUM(Decurtamento_Punti) AS punti_decurtati
			FROM Anagrafica AS A
			INNER JOIN Verbali AS V
			ON A.id_Anagrafica = V.id_Anagrafica
			GROUP BY A.id_Anagrafica, A.Nome, A.Cognome
			
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--5. Cognome, Nome, Data violazione, Indirizzo violazione, importo e punti decurtati per tutti gli anagrafici residenti a Palermo, 

			
			SELECT cognome, nome, Data_violazione, Indirizzo_Violazione, Importo, Decurtamento_punti 
			FROM Verbali AS V
			INNER JOIN Anagrafica AS A
			ON A.id_Anagrafica = V.id_Anagrafica
			WHERE A.citta = 'Palermo'
			
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--6. Cognome, Nome, Indirizzo, Data violazione, importo e punti decurtati per le violazioni fatte tra il febbraio 2009 e luglio 2009, 

			
			SELECT cognome, nome, Indirizzo_Violazione , Data_Violazione, Importo, Decurtamento_punti 
			FROM Verbali AS V
			INNER JOIN Anagrafica AS A
			ON A.id_Anagrafica = V.id_Anagrafica
			WHERE V.Data_Violazione BETWEEN '2009-02-01' AND '2009-07-31'
			
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--7. Totale degli importi per ogni anagrafico, 

			
			SELECT A.cognome, A.Nome, SUM(V.Importo) as TotaleDovuto
			from Anagrafica as A
			INNER JOIN
			Verbali as V
			ON A.id_Anagrafica = V.id_Anagrafica
			group by A.cognome, A.Nome
			
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--8. Visualizzazione di tutti gli anagrafici residenti a Palermo, 

			
			select cognome, nome 
			from anagrafica 
			where citta = 'palermo'
			
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--9. Query parametrica che visualizzi Data violazione, Importo e decurta mento punti relativi ad una certa data, 

			
			select Data_violazione, Importo, Decurtamento_Punti
			from Verbali
			where Data_Violazione = '2024-02-06'
			
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--10. Conteggio delle violazioni contestate raggruppate per Nominativo dell’agente di Polizia, 

			
			select Nominativo_Agente, COUNT(*) as TotaleViolazioni
			from Verbali
			group by Nominativo_Agente
			
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--11. Cognome, Nome, Indirizzo, Data violazione, Importo e punti decurtati per tutte le violazioni che superino il decurtamento di 5 punti, 

			
			select Cognome, Nome, Indirizzo, Data_Violazione, Importo, Decurtamento_punti
			from Verbali as V
			INNER JOIN
			Anagrafica as A
			on v.id_anagrafica = A.id_anagrafica 
			where Decurtamento_Punti > 5
			
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--12. Cognome, Nome, Indirizzo, Data violazione, Importo e punti decurtati per tutte le violazioni che superino l’importo di 400 euro. 

			
			select Cognome, Nome, Indirizzo, Data_violazione, importo, decurtamento_punti
			from Verbali as V
			INNER JOIN
			Anagrafica as A
			on v.id_anagrafica = A.id_anagrafica 
			where importo > 400
		
-- STORE PROCEDURE ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--1) Una SP parametrica che, ricevendo in input un anno, visualizzi l’elenco delle contravvenzioni effettuate in un quel determinato anno

			
				CREATE PROCEDURE ViolazioniPerAnno
				@Anno INT
				AS
				BEGIN
					SELECT *
					FROM Verbali
					WHERE YEAR(Data_Violazione) = @Anno;
				END;
				GO
			


			EXEC ViolazioniPerAnno @Anno = 2009;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--2) Una SP parametrica che, ricevendo in input una data, visualizzi il totale dei punti decurtati in quella determinata data 

			
				CREATE PROCEDURE TotalePuntiInData
				@data NVARCHAR(10)
				AS
				BEGIN
					select sum(Decurtamento_Punti) as TotalePunti
					from Verbali
					where Data_Trascrizione_Verbale = @data
				END;
				GO
				
				
			EXEC TotalePuntiInData @data = '2024-02-04'

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--3) Una SP che consenta di eliminare un determinato verbale identificandolo con il proprio identificativo. 

			
				CREATE PROCEDURE DeleteVerbale
				@idVerbale INT
				AS
				BEGIN
					DELETE FROM Verbali
					WHERE id_Verbale = @idVerbale;
				END;
				GO
			

			EXEC DeleteVerbale @idVerbale = 6
