#! /bin/bash

# Eksport danych z mongoDB do MySQL

# Funkcja pokazuje sposob uzycia skrypt
function helpme() {
  echo "";
  echo "Uzycie:"
  echo "[nazwaBazyMONGO] [nazwa kolekcji MONGO] [port MONGO] [bazaCouch] [host:port Couch]"
  echo "Przyklad: "
  echo "music hypem 27017"
  echo "";

  exit 1
}

# sprawdzanie ilosci parametrow
if [ $# -ne 5 ]; then
	helpme;
fi

# pobieranie zmiennych
outputFile="./exportedDataTMP.json";
dbName=$1
collectionName=$2
port=$3

#informacje dla Couch Db
couchDb=$4
couchHost=$5

# export z mongoDB
#/root/nosql/bin/mongodb/mongoexport -d $dbName -c $collectionName -o $outputFile --port $port
mongoexport -d $dbName -c $collectionName -o $outputFile --port $port

#export do CouchDB


#tworzymy baze w Couch DB
curl -X PUT $couchHost/$couchDb

# Otwieramy plik tymaczasowy czytaja linia po linii
while read line 
do
	a=$(echo $line | cut -c52-)
	a="{${a}"
	curl -d "$a" -X POST -H "Content-Type: application/json" $couchHost/$couchDb
done < $outputFile;

rm $outputFile;

