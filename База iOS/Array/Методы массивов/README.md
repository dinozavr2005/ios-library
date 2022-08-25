# Array

Handy convenience methods

## Contains
проверяет наличие элемента в массиве
```swift
let hasHitron = self.orderItems.contains { $0.activationModemType == .Hitron }
```

## forEach
перебо(обход) массива, в отличии от map ничего не возвращает
```swift
["Taylor", "Paul", "Adele"].forEach { print($0) }
```
## map
позволяет применить переданное в него замыкание для каждого элемента коллекции
```swift
let fruits = ["Apple", "Cherry", "Orange", "Pineapple"]
let upperFruits = fruits.map { $0.uppercased() }
```

## flatMap
сначала применяет функцию к каждому элементу, а затем преобразует полученный результат в плоскую структуру и помещает в новый массив.
```swift
let arr1 = ["it's Sunny in", "", "California"];

let words = arr1.map{ ($0.split(separator: " ")) }
print(words) // [["it\'s", "Sunny", "in"], [], ["California"]]

let flatWords = arr1.flatMap{ ($0.split(separator: " ")) }
print(flatWords)// ["it's","Sunny","in", "", "California"]
```
## compactMap
делает тоже что и `map()`, но дополнительно «разворачивает» полученные на выходе Optional значения и  удаляет из коллекции значения равные `nil`. 
```swift
let possibleNumbers = ["1", "2", "three", "///4///", "5"]
let compactMapped = possibleNumbers.compactMap(Int.init)
print (compactMapped) // [1, 2, 5]
```
## sort
сортирует данные в массиве
```swift
let scoresString = ["100", "95", "85", "90", "100"]
let sortedString1 = scoresString.sorted()
print(sortedString1) // ["100", "100", "85", "90", "95"]
```
> такой результат получился потому что копилятор считает что первая цифра 1 меньше 8 или 9

### reversed
сортирует элементы в обратном порядке
```swift
let names = ["Taylor", "Paul", "Adele", "Justin"]

let sorted = names.sorted()
print(sorted) // ["Adele", "Justin", "Paul", "Taylor"]

let reversedSorted = names.sorted().reversed()
print(reversedSorted) // ReversedCollection<Array<String>>(_base: ["Adele", "Justin", "Paul", "Taylor"])
```
> `ReversedCollection` это _lazy_ массив, поскольку массивы это Value типы, то на самом деле Swift не работал с массивом(не сортировал в обратном порядке), поэтому данный метод очень быстрый **O(1)**
Если нужен настоящий отсортированный массив, используйте следущий пример кода:
```swift
let sortedArray = Array(names.sorted().reversed())
print(sortedArray) // ["Taylor", "Paul", "Justin", "Adele"]
```

## filter
используется, когда требуется отфильтровать элементы коллекции по определенному правилу
```swift
let fibonacciNumbers = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
let evenFibonacci = fibonacciNumbers.filter { $0 % 2 == 0 }
print(evenFibonacci) // [2, 8, 34]
```

## reduce
позволяет обьединить все элементы коллекции в одно значение в соответсвтвии с переданным замыканием
```swift
let names = ["Taylor", "Paul", "Adele"]
let count = names.reduce(0) { $0 + $1.count }
print(count) // 15
 ```

## joined
сложение массивов
```swift
let numbers = [[1, 2], [3, 4], [5, 6]]
let joined = Array(numbers.joined())
// [1, 2, 3, 4, 5, 6]
```
> при сложении массивов убирается один уровень вложенности
## split
разделить массив
```swift
let multilineString = """
Есть свойства, бестелесные явленья,
С двойною жизнью; тип их с давних лет, —
Та двойственность, что поражает зренье:
То — тень и сущность, вещество и свет.

Есть два молчанья, берега и море,
Душа и тело. Властвует одно
В тиши. Спокойно нежное, оно
Воспоминаний и познанья горе

"""

let words = multilineString.lowercased()
           .split(separator: "\n")
           .map{$0.split(separator: " ")}
/* 
[["есть", "свойства,", "бестелесные", "явленья,"], 
 ["с", "двойною", "жизнью;", "тип", "их", "с", "давних", "лет,", "—"],
 ["та", "двойственность,", "что", "поражает", "зренье:"], 
 ["то", "—", "тень", "и", "сущность,", "вещество", "и", "свет."], 
 ["есть", "два", "молчанья,", "берега", "и", "море,"],
 ["душа", "и", "тело.", "властвует", "одно"],
 ["в", "тиши.", "спокойно", "нежное,", "оно"],
 ["воспоминаний", "и", "познанья", "горе"]
 */
```
## first(where)
Получение первого элемента, который удовлетворяет определенным условиям
```swift
let numbers = [3, 7, 4, -2, 9, -6, 10, 1]
let firstNegative = numbers.first(where: { $0 < 0 }) // Optional(-2)
```
### last(where)
Получение последнего элемента, который удовлетворяет определенным условиям

## isEmpty
проверка массива на наличие данных
```swift
let numbers = []
numbers.isEmpty // true
```

## Полезные сслыки
- [Немного практики функционального программирования в Swift для начинающих](https://habr.com/ru/post/440722/)