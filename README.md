## Wykonane zadania 

- znalezienie danych ( lista 80 utworów z serwisu hypem.com ) - plik dane.txt
- import danych do bazy mongoDB -  importToCouchDB.sh
- import danych do bazy couchDB -  importToMongo.sh
- export danych z bazy MongoDB do CouchDB  -   mongoToCouch.sh   
- dodanie map i reduce dla CouchDB - funkcje w pliku mapReduceCouchDB.txt
- dodanie map i reduce dla MongoDB - funkcje w pliku mapReduceMongoDB.txt


## Jak uruchaomić na SIGMIE

### Import danych do bazy mongoDB - importToCouchDB.sh
- Uruchamiamy MongoDB np. 

```
mongod --dbpath=$HOME/.data/var/lib/mongodb --port=27015 
```
- Uruchamiamy skrypt importujący dane

```
./importToMongo.sh [sciezkaDoPlikuZdanymi] [nazwaBazy] [nazwa kolekcji] [port]
```
- Przykładowy komunikat o poprawny dodaniu

```
connected to: 127.0.0.1:27011;
imported 80 objects;
```

### Import danych do bazy couchDB - importToCouchDB.sh
- Uruchamiamy CouchDB np. ( konfigracja serwera według wskazówek ze strony : http://wbzyl.inf.ug.edu.pl/nosql/instalacja

```
cd /home/studinf/hwojciec/noSQL/couchdb/bin;
./couchdb -A ~/.data/etc/couchdb/local.d;
```

- Uruchamiamy skrypt importujący dane

```
./importToCouchDB.sh [sciezkaDoPlikuZdanymi] [nazwaBazy]  [host:port]
```

- Przykładowy komunikat o poprawny dodaniu

```
Tworzenie bazy danych: music
{"ok":true}
Kopiowanie danych : music
{"ok":true,"id":"bf41cc1149de006478594f975f04d8ea","rev":"1-a9653e967873e9e8b7c1b2e17a459ebb"}
{"ok":true,"id":"bf41cc1149de006478594f975f04daae","rev":"1-c8beffae43bec70237dc623ac3a8e44e"}
```


### Export danych z bazy MongoDB do CouchDB  - mongoToCouch.sh  

- Uruchamiamy CouchDB ( sposób uruchomienia podany powyżej )
- Uruchamiamy MongoDB ( sposób uruchomienia podany powyżej )
- Pamiętajmy, aby ustawić aplikacjom różne porty
- Uruchamiamy skrypt eksportujący dane

```
 ./mongoToCouch.sh [nazwaBazyMONGO] [nazwa kolekcji MONGO] [port MONGO] [bazaCouch] [host:port Couch]
```

```
./mongoToCouch.sh music hypem 27011 music http://0.0.0.0:27015/
```


- Przykładowy komunikat o poprawny dodaniu
 
``` 
connected to: 127.0.0.1:27011;
exported 240 records
{"ok":true,"id":"bf41cc1149de006478594f975f0dfb0b","rev":"1-a9653e967873e9e8b7c1b2e17a459ebb"}
{"ok":true,"id":"bf41cc1149de006478594f975f0e01a2","rev":"1-9efdedf70b6204a7e42ad4935adc8861}
{"ok":true,"id":"bf41cc1149de006478594f975f0e0a0f","rev":"1-653cc7d35790502bcc90a7b67263fb0a"}
```

### Map i reduce dla CouchDB
- Uruchamiamy CouchDB ( sposób uruchomienia podany powyżej )
- Uruchamiamy Futon - http://0.0.0.0:27015/_util
- Dodajemy funkcję map i reduce z pliku  mapReduceMongoDB.txt do widoków i uruchamiamy :
- Przykładowe wyniki : 

```
"Adventure Club"	1
"AEONS"	 1
"Aesop Rock"	 1
"Air Tycoon"	1
"Alex Metric"	1
"Atmosphere"	 1
"Birdy"	 1
"Blue Foundation"	 2
"Charli XCX"	1
"Chet Faker"	1
...
```

### Map i reduce dla MongoDB

- Uruchamiamy MongoDB ( sposób uruchomienia podany powyżej )
- Uruchamiamy konsol mongo np.
```
mongo music  --port 27015
```
- W konsolece wpisujemy nastepujace polecenia ( są w pliku mapReduceMongoDB.txt ) zakładając, że nasza baza nazywa się "music" a kolekcja "hypem"

```
DBQuery.shellBatchSize = 100;
m = function() { emit(this.artist,1) };
r = function(k,vals) { var sum = 0;  for(var i=0; i < vals.length; i++) { sum += vals[i]; } return sum;     }
res = db.hypem.mapReduce(m, r, "TopArtists" );
db[res.result].find()
```
- Przykładowe wyniki : 

```
{ "_id" : "AEONS", "value" : 1 }
{ "_id" : "Adventure Club", "value" : 1 }
{ "_id" : "Aesop Rock", "value" : 1 }
{ "_id" : "Air Tycoon", "value" : 1 }
{ "_id" : "Alex Metric", "value" : 1 }
{ "_id" : "Atmosphere", "value" : 1 }
{ "_id" : "Birdy", "value" : 1 }
{ "_id" : "Blue Foundation", "value" : 2 }
{ "_id" : "Charli XCX", "value" : 1 }
{ "_id" : "Chet Faker", "value" : 1 }
{ "_id" : "Chromatics", "value" : 1 }
```


## Dlaczego nie działa na SIGMIE ?
