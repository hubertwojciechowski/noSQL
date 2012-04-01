#! /bin/bash

# Eksport danych z mongoDB do MySQL

# Funkcja pokazuje sposob uzycia skrypt
function helpme() {
  echo "";
  echo "Uzycie:"
  echo "[nazwaBazyMONGO] [nazwa kolekcji MONGO] [port MONGO]"
  echo "Przyklad: "
  echo "music hypem 27017"
  echo "";
  echo "UWAGA ! W pliku php nalezy skonfigurowac polaczenie z baza danych"
  exit 1
}

# sprawdzanie ilosci parametrow
if [ $# -ne 3 ]; then
	helpme;
fi

# pobieranie zmiennych
outputFile="./exportedDataTMP.json";
dbName=$1
collectionName=$2
port=$3


#/root/nosql/bin/mongodb/mongoexport -d $dbName -c $collectionName -o $outputFile --port $port
mongoexport -d $dbName -c $collectionName -o $outputFile --port $port

# skrypt php odpowiedzialny za odczyt pliku z eksportu i zapis 
# do bazy MySQL - niezbedna konfiguracja bazy danych w pliku
php readMongo.php $dbName $collectionName $outputFile


