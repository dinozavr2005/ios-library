# Prototype

Прототип – один из самых простых паттернов, который позволяет нам получить точную копию необходимого объекта. Тоесть использовать как прототип для нового объекта.

<img src="https://github.com/dinozavr2005/ios-library/blob/main/%D0%A8%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD%D1%8B%20%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F%20Swift/Prototype/prototype.png"/>

Когда использовать:
1. У нас есть семейство схожих объектов, разница между которыми только в состоянии их полей.
2. Чтобы создать объект вам надо пройти через огонь, воду и медные трубы. Особенно если этот объект состоит из еще одной кучи объектов, многие из которых для заполнения требуют подгрузку даных из базы, веб сервисов и тому подобных источников. Часто, легче скопировать объект и поменять несколько полей
3. Нам не важно как создается объект.
4. Нам страшно лень писать иерархию фабрик (читай дальше), которые будут инкапсулировать всю противную работу создания объекта

Иными словами если для создания объекта нужно затратить много ресурсов или выполнить кучу условий и требований, а объектов нам требуется много, то проще создать один прототип, затем копировать его и заменять значения свойств на необходимые.

И вот тут нужно разобрать понятия «поверхностное копирование» и «глубокое копирование». В переменной, которая содержит экземпляр класса на самом деле содержится указатель на блок памяти в куче, где расположен этот экземпляр. Поверхностное копирование – это просто создание нового указателя на те же самые байты в куче. То есть, в результате мы можем получить два объекта, которые указывают на одно и тоже значение.

## Пример кода:

```swift
import Foundation

class Person: NSObject {
    var name = ""
    var surname = ""
}
```

 А теперь создадим два объекта нашего класса, поменяем значения свойств, выведем лог и посмотрим что же получится:

 ```swift
 let firstPerson = Person()
firstPerson.name = "Pavel"
firstPerson.surname = "Davidoff"
let secondPerson = firstPerson

print("First person name: \(firstPerson.name) and surname: \(firstPerson.surname)")

secondPerson.name = "Alex"
secondPerson.surname = "Black"

print("Second person name: \(secondPerson.name) and surname: \(secondPerson.surname)")
print("First person name: \(firstPerson.name) and surname: \(firstPerson.surname)")
 ```

Вывод лога в консоль:

```swift
First person name: Pavel and surname: Davidoff
Second person name: Alex and surname: Black
First person name: Alex and surname: Black
```

Думаю, понятно, что при создании второго указателя secondPerson, он сослался на тот же экземпляр что и firstPerson, и поэтому изменения свойств через один указатель повлияют и на другой.

Именно для создания копии объектов в памяти следует использовать глубокое копирование, которое в Swift реализовано протоколом NSCopying, и методом этого протокола

```swift
public func copyWithZone(zone: NSZone) -> AnyObject
```

Изменим реализация нашего класса, чтобы он соответствовал протоколу, и добавим инициализатор от объекта собственно типа.

```swift
import Foundation

class Person: NSObject, NSCopying {
    var name = ""
    var surname = ""
    
    // это чтобы реализовать NSCopyng на Swift
    required override init() {
    }
    
    required init(_ person: Person) {
        self.name = person.name
        self.surname = person.surname
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return self.dynamicType.init(self)
    }
}
```

Создаем третий и четвертый объекты, только для создания четвертого используем написанный ранее инициализатор.

```swift
let thirdPerson = Person()
thirdPerson.name = "Pavel"
thirdPerson.surname = "Davidoff"

print("Third person name: \(thirdPerson.name) and surname: \(thirdPerson.surname)")

let fourthPerson = Person(thirdPerson)
fourthPerson.name = "Alex"
fourthPerson.surname = "Black"

print("Fourth person name: \(fourthPerson.name) and surname: \(fourthPerson.surname)")
print("Third person name: \(thirdPerson.name) and surname: \(thirdPerson.surname)")
```
Вполне ожидаемый лог в консоле:
```swift
Third person name: Pavel and surname: Davidoff
Fourth person name: Alex and surname: Black
Third person name: Pavel and surname: Davidoff
```

И последнее, что нужно сказать про NSCopyng. Ведь мы нигде не использовали метод этого протокола. Это потому, что NSZone больше не используется в Swift  да и в Objective-C в течение длительного времени. И передающийся в этот метод аргумент игнорируется. Этот метод существует по историческим причинам.
