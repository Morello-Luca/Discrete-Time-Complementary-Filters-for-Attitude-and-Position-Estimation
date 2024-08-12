####################################################################################################################################
#				CONTENUTO CARTELLA
####################################################################################################################################
La seguente cartella contiente i seguenti file:

- init.m : File MATLAB di inizializzazione del modello simulink per la simulazione del filtro proposto
- gain_lambda.m : File MATLAB per il calcolo dei guadagni da utilizzare nel filtro di assetto
- gain_p.m : File MATLAB per il calcolo dei guadagni da utilizzare nel filtro di posizione
- frequency_analysi.m : FILE MATLAB per l'analisi in frequenza del filtro proposto 

- test.slx : File SIMULINK per la simulazione del filtro proposto
- convergenzak.slx : File SIMULINK per il calcolo dei guadagni attraverso la simulazione degli opportuni filtri di Kalman


####################################################################################################################################
#				AVVIO SIMULAZIONI 
####################################################################################################################################
1) scelta della traiettoria da utilizzare
	commentare/scommentare le righe 6 e 7 del file init.m
2) Abilitare/Disabilitare la perdita del segnale GPS
	commentare/scommentare le righe 8 e 9 del file init.m
3.a) Selezionare il guadagno per regolare la stima dei bias
	commentare/scommentare le righe 5 e 6 del file gain_lambda.m
3.b) Selezionare l'errore di stima iniziale dei bias per l'analisi del comportamento della stima di convergenza o di regime 
	commentare/scommentare le righe da 59 a 65 del file init.m
4) Caricare nel workspace i parametri della simulazione
	eseguire il file init.m
5) Avviare la simulazione
	eseguire il file SIMULINK test.slx

6) Visualizzazione dei grafici in frequenza
	una volta caricati i parametri dal file init.m, eseguire il file frequency_analysi.m