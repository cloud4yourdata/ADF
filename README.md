# Azure Data Factory
#### Inkrementalne ładowanie danych 

W wersji V1 usługi Azure Data Factory mamy mechanizm nazwany Data Slice, który umożliwiał pobieranie danych w "kawałkach", określonych poprzez okna czasowe.

```mssql
"source": {
  "type": "SqlSource",
  "sqlReaderQuery":$$Text.Format('select * from Order where orderDate >= \\'{0:yyyyMMdd}\\' AND orderDate < \\'{1:yyyyMMdd}\\'', WindowStart, WindowEnd)"
}
```

Mechanizm ten umożliwiał przyrostowe pobieranie danych w oparciu o kolumnę, będącą znacznikiem czasowym.  Dla każdego DataSet'a w naszym pipeline musieliśmy zdefiniować "Data slice" i na tej podstawia ADF generował scheduler.

 ![ADFDataSlice](docs\img\DataSlice.png)

W wersji V2 usługi Azure Data Factory pojawił się mechanizm triggerów ( w tym triggerów czasowych), definiowanych dla całego pipeline. W związku z takim podejściem (w V2 nie ma mechanizmu Dataslice), nie mamy z pudełka dostępnego inkrementalnego mechanizmu  ładowania danych. Aby ładować dane z relacyjnych źródeł danych w sposób przyrostowych musimy sami zaimplementować taki mechanizm.Aby uprościć proces pobierania danych powstał framework, który rozwiązuje ten problem.

#### Framework 

Mechanizm inkrementalnego pobierania danych opiera się o mechanizm znaczników. W przypadku relacyjnych źródeł danych znacznik może być oparty o:

1. Klucz główny (PK)
2. Unikalną datę

Podejście opartę o klucz główny (założenie, że klucze są rosnące), składa się kilku kroków:

1. Pobranie informacji o maksymalnym identyfikatorze klucza, który może zostać pobrany
2. Pobranie informacaji o ostatnio pobranym identyfikatorze klucza
3. Przygotowanie zapytania, które w warunku będzie uwzględniało warunek na zakres kluczy do pobrania

