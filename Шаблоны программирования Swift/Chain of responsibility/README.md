# Chain of responsibility

Представьте себе очередь людей которые пришли за посылками. Выдающий посылки человек, дает первую посылку первому в очереди человеку, он смотрит на имя-фамилию на корбке, видит что посылка не для него, и передает посылку дальше. Второй человек делает собственно тоже самое, и так пока не найдется получатель.

Цепочка ответственности (chain of responsibility) – позволяет вам передавать объект по цепочке объектов-обработчиков, пока не будет найден необходимый объект обработчик.

Когда использовать этот паттерн:

У вас более чем один объект — обработчик.
У вас есть несколько объектов обработчика, при этом вы не хотите специфицировать который объект должен обрабатывать в даный момент времени.
Как всегда – пример:

Представим что у нас есть конвеер, который обрабатывает различные предметы которые на нем: игрушки, электронику и другие.
Для начала создадим классы объектов которые могут быть обработаны нашими обработчиками:

```swift
class BasicItem {
}

class Toy: BasicItem {
}

class Electronics :BasicItem {
}

class Trash: BasicItem {
}
```
Теперь создадим обработчики:

```swift
protocol BasicHandler {
    var nextHandler: BasicHandler? {get set}
    func handleItem(item: BasicItem)
}
```
Наш базовый обработчик умеет обрабатывать объекты типа BasicItem. И самое важное – он может иметь ссылку на следующий обработчик (как люди в нашей очереди, которые передают посылку).

Давайте создадим код обработчика игрушки:
```swift
class ToysHandler: BasicHandler {
    
    var nextHandler: BasicHandler?
    
    required init(aHandler: BasicHandler) {
        self.nextHandler = aHandler
    }
    
    func handleItem(item: BasicItem) {
        if item is Toy {
            print("Нашли игрушку. Обрабатываем")
        } else {
            print("Это не игрушка, передаем на обработку следующему")
            
            self.nextHandler!.handleItem(item)
        }
    }
}
```
Если обработчик получает объект класса Toy – то он его обрабатывает, если нет – то обработчик передает объект следующему обработчику. По аналогии создадим два следующих обработчика: для электроники, и мусора:
```swift
class ElectronicHandler: BasicHandler {
    
    var nextHandler: BasicHandler?
    
    required init(aHandler: BasicHandler) {
        self.nextHandler = aHandler
    }
    
    func handleItem(item: BasicItem) {
        if item is Electronics {
            print("Нашли электонику. Обрабатываем")
        } else {
            print("Это не электроника, передаем на обработку следующему")
            self.nextHandler!.handleItem(item)
        }
    }
}

class OtherItemsHandler: BasicHandler {
    
    var nextHandler: BasicHandler?
    
    func handleItem(item: BasicItem) {
        print("Нашли неопознанный объект. Уничтожаем его")
    }
}
```
Как видим OtherItemsHandler в случае, когда до него дошло дело – объект уничтожает, и не пробует дергать следующий обработчик (последний человек в очереди не проверяет получателя — его функция просто выбросить посылку, если она попала ему в руки).
Давайте тестировать:
```swift
let otherItemsHandler = OtherItemsHandler()
let electronicItemsHandler = ElectronicHandler(aHandler: otherItemsHandler)
let toysItemsHandler = ToysHandler(aHandler: electronicItemsHandler)

let toy = Toy()
let el = Electronics()
let trash = Trash()

toysItemsHandler.handleItem(toy)
print("- - - - -")
toysItemsHandler.handleItem(el)
print("- - - - -")
toysItemsHandler.handleItem(trash)

//console:
Нашли игрушку. Обрабатываем
- - - - -
Это не игрушка, передаем на обработку следующему
Нашли электонику. Обрабатываем
- - - - -
Это не игрушка, передаем на обработку следующему
Это не электроника, передаем на обработку следующему
Нашли неопознанный объект. Уничтожаем его
```
Мы в начале создаем обработчик мусора, т.к. все предыдущие обработчики инициализируются с ссылкой на предыдущий обработчик. Таким образом все три обработчика скреплены в цепь и ссылаются один на другой, кроме последнего. Его свойство nexhtHandler = nil. Далее создаем объекты и  пытаемся обработать эти различные созданные элементы