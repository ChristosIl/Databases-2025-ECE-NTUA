ReadMe




<h1 align="center">Festival Management RDBMS.</h1>

<p align="center">
  <!-- Node.js badge -->
  <a><img src="https://img.shields.io/badge/Node.js-v22.15.0-brightgreen" alt="Node.js">
  </a>   
  <!-- npm badge -->
  <a><img src="https://img.shields.io/badge/npm-v10.9.2-blue" alt="npm">
  </a>
  <!-- MariaDB badge -->
  <a><img src="https://img.shields.io/badge/Database-MariaDB-lightblue" alt="MariaDB">
  </a>
  <!-- Express.js badge -->
  <a><img src="https://img.shields.io/badge/Framework-Express-black" alt="Express.js">
  </a>
  <!-- Docker badge -->
  <a><img src="https://img.shields.io/badge/Container-Docker-blue" alt="Docker">
  </a>
  <!-- EJS badge -->
  <a><img src="https://img.shields.io/badge/Template-EJS-yellow" alt="EJS">
  </a>  
</p>

<p align="center">
  <a href="#Description">Description</a> •
  <a href="#technologies">Technologies</a> •
  <a href="#how-to-use">How To Use</a> •
  <a href="#ΠΑΡΑΔΟΧΕΣ">Παραδοχές</a> •
</p>


## Description

Η παρούσα εργασία αφορά την υλοποίηση ενός σχεσιακού συστήματος βάσης δεδομένων (RDBMS) για τη διαχείριση μουσικών φεστιβάλ. Κάθε φεστιβάλ περιλαμβάνει διάφορα events, τα οποία με τη σειρά τους αποτελούνται από performances solo καλλιτεχνών ή συγκροτημάτων. Οι επισκέπτες (visitors) για να συμμετάσχουν πρέπει να αγοράσουν εισιτήριο, με δυνατότητα μεταπώλησης σε περιπτώσεις που το event είναι sold out, μέσω του συστήματος "Resale Queue".

## Technologies
* MariaDB: Για την υλοποίηση της βάσης δεδομένων, μέσω Docker container.

* Node.js & Express: Για την κατασκευή του backend που διαχειρίζεται τα queries και παρουσιάζει τα αποτελέσματα.

* EJS (Embedded JavaScript): Για την απόδοση δυναμικών σελίδων στον client και την προβολή των αποτελεσμάτων SQL σε φιλική μορφή.

* Docker: Για την ανάπτυξη του περιβάλλοντος της βάσης δεδομένων με συνέπεια και ευκολία.

## How To Use
Για να κάνετε clone και να εκτελέσετε με επιτυχία την εφαρμογή θα πρέπει:

Να έχετε εγκατεστημένα τα:

* Docker και Docker compose 


```bash
# Clone this repository
$ git clone https://github.com/ChristosIl/Databases-2025.git

# Go into the project folder 

# Compose docker file
$ docker compose build

# Start containers
$ docker compose up -d



```

* Μεταβείτε στο http://localhost:8080 για να εξερευνήσετε τη βάση δεδομένων μέσω Adminer (το port 8080 έχει ορισθεί για το Adminer στο compose.yaml)

* Μεταβείτε στο http://localhost:4000 για να δείτε το frontend με τα αποτελέσματα των SQL ερωτημάτων



## ΠΑΡΑΔΟΧΕΣ 

----
* Στο πλαίσιο του σχεδιασμού του συστήματος, θεωρήθηκε ότι το Pulse University Festival μπορεί να διοργανώνει πολλαπλα φεστιβάλ, κάθε ένα με το δικό του έτος, τοποθεσία και χαρακτηριστικά.
Για το λόγο αυτό και δεδομένου ότι θεωρούμε την έναρξη της εφαρμογής από το 2025, τα φεστιβάλ του Pulse University αρχίζουν από το έτος 2025. Επομένως θα θεωρήσουμε ως συμμετοχές, αυτές για το έτος του 2025 θεωρώντας ότι θα είναι αυτό που τελείωσε μετά το πέρας του χρόνου.

----
* Θεωρούμε ότι ένας staff member δεν μπορεί να δουλέψει σε άλλο event την ίδια μέρα. Έτσι γίνονται κατάλληλα οι εισαγωγές και αντίστοιχα υπάρχει περιορισμός με κατάλληλο trigger

----
* Για το προσωπικό κρατήσαμε τους περιορισμούς που ζητούνται, ενώ για το τεχνικό προσωπικό δεν ορίσαμε κάποιο κατώτατο όριο. Για τον λόγο αυτό σε αντίστοιχο query ή κάποια μοργή παρουσίασης μπορεί να εμφανιστεί ότι μία σκηνή έχει 0 τεχνικό προσωπικό (δεν χρειάζεται)

----
* Για οποιδήποτε query που ζητούσε παρουσίαση δεδομένων για καλλιτέχνες, οι απαντήσεις υλοποιήθηκαν να παρουσιάζουν δεδομένα για τους artist. Σε περίπτωση που ζητούνταν και band ο τρόπος υλοποίησης είναι παρόμοιος αν όχι ίδιος

----
* Καλύφθηκαν όλες οι απαιτήσεις της εκφώνησης είτε από περιορισμούς είτε από triggers


