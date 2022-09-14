# # MobDev-Manuel-Tanzi-Android

#### Sviluppare un’applicazione per mantenere una lista di promemoria 
Un utente può salvare un promemoria caratterizzato da: 
- Data e ora 
- Luogo 
- Titolo 
- Descrizione 
- I promemoria possono essere segnati come “attivi”, “scaduto” o “completati” (dall’utente).
- I promemoria ancora attivi vanno visualizzati in una lista ordinata per data ed in una mappa. 
- Devono essere mostrati i promemoria ancora attivi.
- Quando l’utente entra nella regione (geofence) di un promemoria attivo l’app genera una notifica locale.

# Salvataggio dati
**@MainActor  protocol  UIApplicationDelegate**
L'oggetto delegato dell'app gestisce i comportamenti condivisi dell'app. Il delegato dell'app è effettivamente l'oggetto radice della tua app e funziona insieme a *UIApplication* per gestire alcune interazioni con il sistema. Come l'oggetto *UIApplication*, *UIKit* crea l'oggetto delegato dell'app all'inizio del ciclo di avvio dell'app in modo che sia sempre presente.
Usa l'oggetto delegato dell'app per gestire le attività seguenti:
- Inizializzazione delle strutture dati centrali della tua app
- Configurazione delle scene della tua app

Si utilizza anche **CoreData**, una tabella contente la struttura di salvataggio dei dati costituita da nome e tipo, necessari per poi accedere al *dizionario* dei dati salvati. 

# Notifiche
**class  UNUserNotificationCenter : [`NSObject`]**
Usa l'oggetto UNUserNotificationCenter condiviso per gestire tutti i comportamenti relativi alle notifiche nell'app o nell'estensione dell'app. In particolare, utilizzare questo oggetto per eseguire le seguenti operazioni:
- Richiedi l'autorizzazione per interagire con l'utente tramite avvisi, suoni e badge con icone. Vedere Richiesta di autorizzazione per utilizzare le notifiche.
- Dichiara i tipi di notifica supportati dalla tua app e le azioni personalizzate che l'utente può eseguire quando il sistema invia tali notifiche. Vedere Dichiarazione dei tipi di notifica utilizzabili.
- Pianifica la consegna delle notifiche dalla tua app. Consulta Pianificazione di una notifica in locale dalla tua app.
- Gestisci le notifiche già consegnate che il sistema mostra nel Centro notifiche. Vedere Gestione delle notifiche consegnate.
- Gestisci le azioni selezionate dall'utente associate ai tipi di notifica personalizzati. Vedere Gestione delle notifiche e azioni relative alle notifiche.

#### Come ho gestito le notifiche?
Quando viene creato un task con data futura ad oggi allora viene creata anche una **notifica temporale** che agirà in quella determinata data e ora.
Ogni task possiede anche una posizione geografica per cui viene utilizzata anche quella posizione per lanciare una **notifica geologica** quando si entrerà in una zona circolare attorno al punto prefissato per il task con un margine di distanza di *2000* punti.



# Grafica
La grafica viene ottimizzata per diversi dispositivi con l'uso dei **"constraints"** che rendono modificabile il layout in base al dispositivo in maniera tale che si possano mantenere le distanze dagli oggetti anche utilizzando diversi dispositivi con uno schermo da diversi pollici.
La grafica viene costruita sulla base di un **iPhone 11** e si consiglia l'utilizzo di quest'ultimo per una massima esperienza.
#### Cosa si ha nella grafica?
Come schermata principale si trova una tabella contenente tutti i task ancora viabili sia temporalmente che quelli  non completati.
In alto a sinistra si hanno due pulsanti:
 - Mappale (*Si accede ad una mappa in cui compaiono tutti i task ancora viabili).
 - Booking (*Si visualizzano tutti i task completati e scaduti).
 
 In alto a destra si accede:
 - Aggiungi task

#### Features
Nella schermata principale è possibile effettuare uno swipe verso sinistra su ogni task per accedere ad alcuni impostazioni rapide come il **Completa** ed **Elimina**.
Mentre invece quando vengono visualizzati tutti i task si possono notare colori di sfondo differenti che corrispondo a "task scaduto", "task completato", "task viabile".




# Permessi
Tutte le richieste di permesso di *notifica* e *geolocalizzazione* vengono richiesti all'utente al primo avvio.
>NSLocationWhenInUseUsageDescription
>UIRequiredDeviceCapabilities : *location-services*
>Notifiche


# NOTE PERSONALI
La consegna *“**attivi**”, “**scaduto**” o “**completati**”* viene da me interpreta, ovvero che nella schermata di aggiunta non compare nessuno tipo di bottone per selezionare questa scelta ma il concetto di **scaduto** viene assegnato al task nel caso in cui si decidesse di selezionare una data antecedente al giorno attuale *(viene comunque segnalato con un alert)*.
Il concetto di **attivo** viene assegnato ad ogni task con data posteriore all'attuale.
**Completato** assegnato in caso di swipe sul task.
>**Tips:** Un task con attributo attivo si porta in automatico nella posizione di scaduto.
