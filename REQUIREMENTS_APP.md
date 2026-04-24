# Prompt operativo per l’agente implementativo — App Flutter “Il Nostro Giardino”

## Contesto e missione

Devi progettare e realizzare una **app mobile Android in Flutter** chiamata **“Il Nostro Giardino”**.

Questa app **non** deve sembrare uno strumento di produttività, un diario clinico, una todo app o un tracker emozionale “freddo”.  
Deve apparire come uno **spazio intimo, delicato, rilassante e affettivo**, pensato come regalo personale per la fidanzata del committente.

L’app deve comunicare:

- cura
- pazienza
- vicinanza costante
- presenza affettiva
- calma
- dolcezza
- continuità nel tempo

L’esperienza utente deve essere centrata quasi interamente sul **giardino** e sui **ricordi associati alle emozioni**, con una UI essenziale, pulita e poetica.

---

## Obiettivo generale del prodotto

Trasformare l’atto di annotare uno stato d’animo in un piccolo gesto simbolico di **giardinaggio emotivo**.

L’utente deve poter:

1. entrare in un ambiente visivo vivo e accogliente;
2. toccare il prato per “piantare” un’emozione in un punto preciso;
3. associare a quell’emozione una nota testuale e un timestamp;
4. vedere l’emozione nascere come **bocciolo** e poi **sbocciare** dopo alcune ore;
5. ritrovare nel tempo il proprio giardino come archivio visivo e narrativo dei propri giorni;
6. percepire nel giardino la presenza affettiva del partner tramite elementi discreti ma costanti.

---

## Vincoli di prodotto fondamentali

Questi principi sono **non negoziabili**.

### 1) L’app deve essere semplice
Nessun menu complesso, nessuna navigazione pesante, nessuna struttura da app enterprise, nessun pannello pieno di controlli.

### 2) Il giardino è il centro assoluto
La schermata principale deve essere il fulcro dell’intera esperienza.  
Il giardino deve essere il luogo dove si vive quasi tutto:

- si osserva
- si pianta
- si ricorda
- si celebra il tempo
- si percepisce la presenza dell’altro

### 3) Tono emotivo coerente
Tutto deve risultare:

- cozy
- morbido
- lento
- intimo
- non rumoroso
- non aggressivo
- non eccessivamente infantile
- non kitsch
- non “gamificato” in modo banale

### 4) La persistenza è cruciale
I fiori e gli elementi piantati **non devono sparire** alla chiusura dell’app.  
Il giardino rappresenta il tempo che passa, quindi la continuità è una parte essenziale del significato dell’app.

### 5) L’interazione deve essere fisica e viva
Ogni elemento deve reagire al tocco con feedback visivi e, dove opportuno, tattili.

---

## Stack tecnico richiesto

- **Framework:** Flutter
- **Target iniziale:** Android
- **Architettura:** pulita, modulare, mantenibile
- **Persistenza locale:** obbligatoria
- **Gestione tempo e scheduler locale:** necessaria per la logica di sbocciatura e delle ricorrenze temporali
- **Animazioni:** fluide ma leggere
- **Stato UI:** ben separato dalla logica dominio
- **Coordinate spaziali:** persistite in modo affidabile

L’obiettivo non è soltanto “far funzionare” la demo, ma costruire una base implementativa ordinata, estendibile e chiara.

---

## Visione UX

L’utente deve aprire l’app e percepire immediatamente di essere in un piccolo mondo vivo, non in una schermata piena di componenti.

### Sensazione desiderata all’apertura
L’effetto psicologico desiderato è qualcosa del tipo:

- “questo posto mi aspetta”
- “questo spazio è calmo”
- “le mie emozioni qui hanno un posto”
- “questo regalo è stato pensato per me”
- “qui c’è anche una presenza affettiva, discreta ma costante”

---

## Ambiente visivo: il giardino vivo

### Struttura della scena
La schermata principale deve mostrare un paesaggio semplice ma evocativo composto almeno da:

- **cielo**
- **prato**
- eventuali piccoli dettagli decorativi coerenti ma minimali

### Il cielo
Il cielo deve riflettere l’**ora reale del giorno** per dare la sensazione che l’app sia sincronizzata con il mondo reale dell’utente.

La resa deve essere poetica ma sobria.  
Non serve realismo fotografico. Serve una resa illustrata/cozy.

Indicazioni:

- mattina: toni chiari e morbidi
- pomeriggio: luce più piena ma sempre pastello
- sera/tramonto: toni caldi e soffusi
- notte: toni scuri ma rassicuranti, non cupi

### Il prato
Il prato è il terreno emotivo. Deve essere:

- verde morbido
- accogliente
- visivamente leggibile
- abbastanza “vuoto” da consentire la collocazione delle emozioni
- abbastanza “vivo” da non sembrare sterile

### Stile estetico
Lo stile generale deve essere:

- cozy
- pastello
- illustrato / morbido
- raffinato nella semplicità
- mai freddo o tecnico

Evitare:

- eccesso di elementi UI
- colori saturi e violenti
- look da app business
- estetica troppo cartoon infantile
- effetti vistosi e rumorosi

---

## Meccanica core: il ciclo delle emozioni

L’interazione principale è la semina di un’emozione nel giardino.

### Azione primaria: piantare un’emozione
Quando l’utente tocca un punto qualsiasi del prato, deve poter avviare il flusso di creazione di una nuova emozione piantata.

Flusso desiderato:

1. l’utente tocca una coordinata del prato;
2. l’app cattura la posizione esatta o normalizzata;
3. si apre una UI leggera e poetica per scegliere il tipo di emozione;
4. l’utente inserisce una nota testuale;
5. il sistema salva:
   - tipo emozione
   - nota
   - timestamp di creazione
   - coordinate sul prato
   - stato di crescita iniziale
6. compare nel punto scelto un **bocciolo**

### Tipologie di emozione da supportare
Supportare esattamente queste quattro emozioni iniziali:

- 🌻 **Girasole = Felicità**
- 🌵 **Cactus = Rabbia**
- 💧 **Goccia = Tristezza**
- 🌹 **Rosa = Amore**

Ogni emozione ha una precisa funzione simbolica:

#### Girasole — Felicità
Celebra i momenti belli, luminosi, pieni.

#### Cactus — Rabbia
Dà confine, spazio sicuro e dignità ai momenti di frustrazione o tensione.

#### Goccia — Tristezza
Accoglie la malinconia come parte fertile dell’esperienza, come nutrimento del prato.

#### Rosa — Amore
Raccoglie i momenti legati al partner, all’affetto, al legame o a ciò che l’utente ama.

---

## Il concetto di bocciolo e sbocciatura

Questa è una meccanica fondamentale e va realizzata bene.

### Stato iniziale
Quando un’emozione viene piantata, **non appare subito nella sua forma finale**.  
Deve comparire come un **bocciolo**.

### Significato
Il bocciolo rappresenta il fatto che l’emozione esiste, ma non è ancora stata completamente elaborata.  
L’app comunica così il valore della pazienza e del tempo interiore.

### Evoluzione temporale
Dopo alcune ore dalla creazione, il bocciolo deve trasformarsi automaticamente nel simbolo finale coerente con l’emozione scelta.

Esempio concettuale:

- appena creato → bocciolo
- trascorso il tempo di maturazione → fiore/simbolo completo

### Requisiti implementativi della crescita
L’agente deve progettare la logica temporale in modo robusto.

Serve almeno:

- una proprietà `createdAt`
- una proprietà `bloomAt` oppure una logica derivata
- una funzione dominio che determini lo stato visivo attuale in base al tempo corrente
- aggiornamento corretto anche dopo riavvio dell’app

### Comportamento atteso al riavvio
Se l’utente chiude l’app e la riapre ore dopo, il sistema deve ricalcolare correttamente lo stato:

- se il bocciolo non ha ancora maturato, resta bocciolo
- se il tempo è trascorso, deve apparire sbocciato

Non usare una logica che dipende soltanto da timer in memoria volatile.

---

## Memoria e note associate

Ogni pianta deve essere associata a un ricordo.

### Dati minimi da salvare per ogni elemento piantato
Per ogni pianta/emozione persistita salvare almeno:

- identificatore univoco
- tipo emozione
- nota testuale
- timestamp di creazione
- coordinate sul prato
- stato implicito o esplicito di crescita
- eventuali metadati utili a rendering/interazione

### Apertura del ricordo
Cliccando su una pianta o sul suo simbolo, deve aprirsi un ricordo associato.

Questo ricordo deve mostrare almeno:

- il tipo di emozione
- la nota testuale
- la data e ora di creazione
- lo stato della pianta

La presentazione deve essere intima e pulita, non tecnica.

---

## Feature relazione: il timer del “Noi”

In alto, sempre visibile ma integrato bene nella scena, deve esserci un contatore che mostra il tempo trascorso dal:

**4 Ottobre 2025**

### Obiettivo emotivo
Celebrare la continuità della storia di coppia a ogni apertura dell’app.

### Requisiti implementativi
Il timer deve essere calcolato dinamicamente sulla base della data corrente e della data iniziale.

Decidere una rappresentazione elegante, per esempio in termini di:

- giorni
- oppure mesi + giorni
- oppure una formulazione ancora più poetica ma comunque chiara

Importante:

- deve essere sempre leggibile
- non deve rubare la scena al giardino
- deve sembrare parte del luogo, non un widget tecnico incollato sopra

---

## Feature relazione: il 4 del mese / mesiversario

Ogni giorno **4 del mese**, il giardino deve celebrare il mesiversario.

### Comportamento richiesto
In quella data deve comparire nel giardino un elemento unico e speciale:

- un **Fiore Magico**
- diverso dagli altri elementi normali
- disponibile solo quel giorno

### Obiettivo emotivo
Creare sorpresa, ritualità e un senso di celebrazione ricorrente.

### Requisiti implementativi
Serve una logica che:

- controlli la data corrente
- rilevi se il giorno del mese è 4
- mostri l’elemento speciale solo in quel giorno
- lo rimuova dagli stati visivi speciali negli altri giorni

Decidere se questo elemento sia:

- solo decorativo
- oppure interattivo

Ma in ogni caso deve essere percepito come evento speciale.

---

## Feature relazione: l’ape messaggera

Un piccolo elemento dinamico, un’ape, deve attraversare lo schermo in modo casuale.

### Obiettivo emotivo
Essere una presenza discreta, leggera e affettuosa.  
Un modo per dire “ci sono” senza invadenza.

### Comportamento richiesto
L’ape:

- appare ogni tanto
- attraversa o sorvola il giardino con movimenti morbidi
- non deve disturbare la lettura della scena
- deve sembrare viva e spontanea

### Interazione
Se l’utente la tocca, deve comparire un breve messaggio di supporto o complimento pre-caricato dal committente.

### Requisiti di contenuto
Prevedere una struttura dati locale per una lista di messaggi predefiniti.  
L’agente deve implementare il sistema in modo che questi messaggi siano facilmente modificabili/configurabili.

### Requisiti di UX
Il messaggio deve apparire in modo delicato, per esempio come:

- piccolo fumetto leggero
- card morbida
- overlay poetico e breve

No popup aggressivi, no finestre invasive.

---

## Requisito di continuità e persistenza assoluta

Il giardino deve essere persistente.

### Cosa significa operativamente
Se l’utente ha piantato un’emozione:

- il fiore non deve sparire chiudendo l’app
- la posizione deve rimanere identica
- il ricordo associato deve restare accessibile
- lo stato di crescita deve essere ricostruito correttamente

### Coordinate spaziali
Le coordinate devono essere memorizzate in modo robusto.

Idealmente:

- usare coordinate normalizzate rispetto all’area del prato
- evitare dipendenza fragile da risoluzioni assolute
- garantire il posizionamento coerente su device diversi, per quanto possibile

---

## Requisito di interazione fisica / feedback

Ogni fiore deve rispondere al tocco in modo coerente con la sua natura simbolica.

Esempi attesi dal brief:

- cactus → vibrazione o feedback più “secco”
- rosa → piccoli cuoricini o feedback delicato
- altri elementi → micro-animazioni coerenti

L’agente deve implementare un sistema di feedback differenziato ma elegante, senza eccessi.

### Regole UX
I feedback devono essere:

- brevi
- fluidi
- coerenti
- non fastidiosi
- non ripetitivi in modo stucchevole

---

## Cancellazione degli elementi

Deve essere possibile rimuovere un fiore piantato per errore.

### Comportamento richiesto
La cancellazione può avvenire tramite:

- pressione prolungata sul fiore
- conferma delicata
- rimozione dal giardino e dallo storage persistente

### Obiettivo
Consentire ordine e controllo senza rompere la poesia dell’interfaccia.

### Requisito UX
La conferma di eliminazione deve essere semplice, leggera, non aggressiva.  
No dialog tecnici brutti. Sì a una conferma morbida e coerente con lo stile.

---

## Architettura richiesta

L’agente deve produrre una architettura Flutter **pulita, leggibile e scalabile**.

### Obiettivo architetturale
Separare bene:

- dominio
- stato applicativo
- persistenza
- rendering UI
- animazioni
- logiche temporali

### Linee guida architetturali
Progettare almeno i seguenti livelli o equivalenti:

#### 1) Presentation layer
Contiene:

- schermata principale del giardino
- widget del cielo
- widget del prato
- widget per il timer del “Noi”
- widget per i fiori / boccioli
- widget per l’ape
- modali / bottom sheet / overlay per inserimento nota e visualizzazione ricordo

#### 2) Domain layer
Contiene:

- modello emozione piantata
- enum/tipologia emozioni
- logica di crescita
- logica mesiversario
- logica timer anniversario
- policy di interazione e feedback
- eventuali use case

#### 3) Data layer
Contiene:

- repository
- storage locale
- serializzazione/deserializzazione
- persistenza dei messaggi dell’ape, se necessario
- gestione load/save degli elementi del giardino

### Stato e reattività
Usare una soluzione di state management coerente e pulita.  
Può essere Provider, Riverpod, Bloc o altro approccio ragionevole, ma la scelta deve essere difendibile e mantenere il progetto semplice.

### Priorità
Favorire:

- chiarezza
- mantenibilità
- facilità di evoluzione
- robustezza della persistenza
- leggibilità del codice

---

## Modello dati suggerito

L’agente deve progettare un modello dati esplicito.  
A titolo guida, ogni elemento piantato dovrebbe avere campi simili a:

- `id`
- `emotionType`
- `note`
- `createdAt`
- `x`
- `y`
- `bloomAt`

Opzionali:

- `deletedAt`
- `animationSeed`
- `customMetadata`

### Emozioni
Definire un enum o struttura equivalente per:

- happiness
- anger
- sadness
- love

Ogni tipo dovrebbe poter mappare a:

- simbolo / asset
- comportamento di rendering
- feedback tattile/visivo
- stile del dettaglio

---

## Logiche temporali richieste

L’agente deve realizzare correttamente le seguenti logiche:

### 1) Orario reale del giorno
Il cielo cambia in funzione dell’ora reale.

### 2) Timer anniversario
Calcolo continuo dal 4 ottobre 2025.

### 3) Sbocciatura dei fiori
Lo stato dei boccioli evolve in base al tempo trascorso.

### 4) Ricorrenza del 4 del mese
Comparsa dell’elemento speciale solo in quel giorno.

### Requisito importante
Le logiche temporali devono essere implementate in modo affidabile anche attraverso:

- riapertura app
- cambio giorno
- cambio ora
- ricostruzione da storage locale

---

## Disposizione spaziale sul prato

La disposizione degli elementi nel prato è una parte fondamentale del progetto.

### Requisiti
Quando l’utente tocca il prato:

- la posizione del tap deve essere tradotta in una coordinata affidabile
- l’elemento deve apparire in quel punto
- quella posizione deve essere persistita
- in fase di rendering deve essere ricostruita con coerenza

### Considerazioni implementative
L’agente deve gestire:

- area interattiva del prato
- esclusione delle zone non valide se necessario
- adattamento alle dimensioni schermo
- collisioni visive minime tra elementi, se utili
- leggibilità della scena complessiva

Non trasformare però il sistema in un editor complesso.  
L’interazione deve restare naturale e immediata.

---

## UI e flussi principali da progettare

### Flusso 1 — Apertura app
L’utente vede:

- cielo coerente con l’ora
- prato
- fiori e boccioli già presenti
- timer del “Noi” in alto
- eventuale fiore magico se è il 4 del mese
- eventuale ape in movimento casuale

### Flusso 2 — Piantare emozione
1. tap sul prato  
2. scelta emozione  
3. inserimento nota  
4. conferma  
5. comparsa del bocciolo nel punto selezionato

### Flusso 3 — Aprire ricordo
1. tap su un fiore o bocciolo  
2. apertura dettaglio ricordo  
3. visualizzazione nota + data/ora + emozione

### Flusso 4 — Eliminazione
1. long press sul fiore  
2. conferma leggera  
3. rimozione con piccola animazione coerente  
4. aggiornamento storage

### Flusso 5 — Interazione con ape
1. ape appare e si muove  
2. utente la tocca  
3. appare un messaggio breve e affettuoso

---

## Indicazioni di design dettagliate

### Layout
La UI deve essere minimalista.

Evitare:

- tab bar inutili
- drawer
- schermate secondarie eccessive
- settaggi complessi
- bottoni ovunque

### Componenti UI desiderabili
Usare solo ciò che serve davvero:

- overlay delicati
- bottom sheet morbidi
- card arrotondate
- tipografia dolce e leggibile
- spaziatura ampia
- elementi ben respirati

### Tipografia
La tipografia deve risultare:

- leggibile
- morbida
- elegante
- non troppo formale
- non troppo giocattolosa

### Animazioni
Le animazioni devono dare vita agli elementi, ma sempre con leggerezza.

Applicare animazioni a:

- comparsa del bocciolo
- trasformazione in fiore
- tap sui fiori
- movimento ape
- eventuale comparsa del fiore magico
- microtransizioni UI

No animazioni inutilmente frenetiche.

---

## Requisiti non funzionali

### Performance
L’app deve restare fluida anche con numerosi elementi nel giardino.

### Robustezza
Il sistema deve tollerare:

- chiusura e riapertura app
- aggiornamento del tempo
- persistenza locale senza perdita dati

### Mantenibilità
Il codice deve essere organizzato in modo che un altro sviluppatore possa:

- leggere rapidamente il progetto
- capire i modelli
- modificare i messaggi dell’ape
- regolare il tempo di sbocciatura
- evolvere la UI

### Estendibilità
Anche se la v1 deve essere focalizzata solo sulle feature richieste, l’architettura deve lasciare spazio a future estensioni.

---

## Deliverable attesi dall’agente

L’agente implementativo deve produrre:

### 1) Struttura progetto Flutter
Con cartelle e moduli ordinati.

### 2) Architettura chiara
Con motivazione delle scelte principali.

### 3) Implementazione della schermata giardino
Con cielo, prato, elementi persistiti, timer e layer interattivi.

### 4) Sistema di persistenza locale
Per conservare piante, note, posizioni e tempi.

### 5) Logica temporale robusta
Per boccioli, anniversario e mesiversario.

### 6) Animazioni e feedback base
Coerenti con il tono dell’app.

### 7) Codice leggibile e commentato dove utile
Soprattutto nelle parti di logica temporale e di posizionamento.

---

## Priorità di implementazione

Se serve ordinare il lavoro, dare priorità a questo ordine:

### Priorità 1 — Fondamenta
- architettura progetto
- modello dati
- storage locale
- schermata base giardino
- cielo dinamico
- prato tappabile
- salvataggio coordinate

### Priorità 2 — Core emozioni
- selezione emozione
- inserimento nota
- creazione bocciolo
- rendering bocciolo/fiore
- dettaglio ricordo
- eliminazione elemento

### Priorità 3 — Tempo e relazione
- timer del “Noi”
- logica di sbocciatura
- fiore magico del 4 del mese
- ape messaggera

### Priorità 4 — Finitura
- animazioni raffinate
- feedback aptico/visivo coerente
- pulizia design
- miglioramenti UX

---

## Cose da evitare assolutamente

L’agente **non deve** trasformare il progetto in:

- un mood tracker clinico
- una app di journaling tradizionale
- una dashboard con statistiche
- una app piena di impostazioni
- una esperienza rumorosa o troppo ludica
- un prototipo tecnico senz’anima

Evitare anche:

- terminologia fredda
- componenti material troppo invadenti se stonano
- layout pieni di controlli
- schermate secondarie inutili
- notifiche aggressive
- approccio “feature-first” anziché “atmosfera-first”

---

## Sintesi finale della direzione creativa

Realizza un’app Flutter che sembri un **piccolo rifugio emotivo vivo**, non uno strumento.

L’esperienza deve ruotare attorno a:

- un giardino che vive nel tempo
- emozioni piantate come semi
- boccioli che sbocciano con pazienza
- ricordi accessibili nei fiori
- un contatore del legame di coppia
- una ricorrenza mensile speciale
- un’ape che porta messaggi di presenza affettiva

Tutta l’implementazione deve rispettare questa intenzione di fondo:

**trasformare il passare del tempo, le emozioni e la relazione in un paesaggio delicato, persistente e pieno di cura.**
