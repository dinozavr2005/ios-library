#  Abstract Factory

**Абстрактная фабрика** – еще один очень популярный паттерн, который как и в названии так и в реализации слегка похож на фабричный метод.

Итак, что же делает абстрактная фабрика: Абстрактная фабрика дает простой интерфейс для создания объектов которые принадлежат к тому или иному сеймейству объектов.

Отличия от фабричного метода:

Фабричный метод порождает объекты одного и того же типа, Абстрактная фабрика же может создавать независимые объекты
Чтобы добавить новый тип объекта–надо поменять интерфейс фабрики, в фабричном же методе легко просто поменять внутренности метода, который ответственный за порождение объектов.
Давайте представим ситуацию: у нас есть две фабрики по производству iPhone и iPad. Одна оригинальная, компании Apple, другая – хижина дядюшки Хуа. И вот, мы хотим производить эти товары: если в страны 3-го мира – то товар от дядюшки, в другие страны – товар любезно предоставлен компанией Apple.

Итак, пускай у нас есть фабрика, которая умеет производить и айпады и айфоны:

```swift
class IPhoneFactory {
}
```
Естественно, нам необходимо реализовать продукты, которые фабрика будет производить:
```swift
class GenericIPad {
    var osName: String?
    var productName: String?
    var screenSize: Float?
}

class GenericIPhone {
    var osName: String?
    var productName: String?
}
```
Но, продукты немного отличаются. Пускай у нас есть два типа продуктов, оригинальные Apple и продукты которые произведены трудолюбивым дядюшкой Сяо-Ляо:
```swift
class AppleIPhone: GenericIPhone {
    override init() {
        super.init()
        self.productName = "iPhone"
        self.osName = "iOS"
    }
}
class AppleIPad: GenericIPad {
    override init() {
        super.init()
        self.productName = "iPad"
        self.osName = "iOS"
        self.screenSize = 7.7
    }
}


class ChinaPhone: GenericIPhone {
    override init() {
        super.init()
        self.productName = "Ляо-Фон"
        self.osName = "Ведроид"
    }
}
class ChinaPad: GenericIPad {
    override init() {
        super.init()
        self.productName = "Сяо-Пад"
        self.osName = "Окна-ЦЕ"
        self.screenSize = 12.1
    }
}
```
Разные телефоны, конечно же, производятся на различных фабриках, потому мы просто обязанны их создать! Приблизительно так должны выглядеть фабрика Apple:
```swift
class AppleFactory: IPhoneFactory {
    
    func getIPhone() -> GenericIPhone {
        let iPhone = AppleIPhone()
        return iPhone
    }
    
    func getIPad() -> GenericIPad {
        let iPad = AppleIPad()
        return iPad
    }
    
}
```
Конечно же у нашего китайского дядюшки тоже есть своя фабрика:
```swift
class ChinaFactory: IPhoneFactory {
    
    func getIPhone() -> GenericIPhone {
        let phone = ChinaPhone()
        return phone
    }
    
    func getIPad() -> GenericIPad {
        let pad = ChinaPad()
        return pad
    }
    
}
```
Как видим, фабрики одинаковые, а вот девайсы у них получаются разные.

Ну вот собственно и все, мы приготовили все что надо для демонстрации! Теперь, давайте напишем небольшой метод который будет возвращать нам фабрику которую мы хотим (кстати, тут фабричный метод таки будет):
```swift
var isThirdWorld: Bool = true

func getFactory() -> IPhoneFactory {
    if (isThirdWorld) {
        return ChinaFactory()
    }
    return AppleFactory()
}
```
Теперь меняя значение переменной **isThirdWorld** можно получать те или иные девайсы.
```swift
let fac = getFactory()
var iPhone = GenericIPhone()
var iPad = GenericIPad()

if let factory = fac as? ChinaFactory {
    iPhone = factory.getIPhone()
    iPad = factory.getIPad()
}
if let factory = fac as? AppleFactory {
    iPhone = factory.getIPhone()
    iPad = factory.getIPad()
}

print("iPad: \(iPad.productName!), os name: \(iPad.osName!), screensize: \(iPad.screenSize!)")

print("iPhone: \(iPhone.productName!), os name: \(iPhone.osName!)")
```
Ну и проверим что мы там понаписали…
```swift
let fac = getFactory()
var iPhone = GenericIPhone()
var iPad = GenericIPad()

if let factory = fac as? ChinaFactory {
    iPhone = factory.getIPhone()
    iPad = factory.getIPad()
}
if let factory = fac as? AppleFactory {
    iPhone = factory.getIPhone()
    iPad = factory.getIPad()
}

print("iPad: \(iPad.productName!), os name: \(iPad.osName!), screensize: \(iPad.screenSize!)")

print("iPhone: \(iPhone.productName!), os name: \(iPhone.osName!)")

isThirdWorld = false

let fac1 = getFactory()

if let factory = fac1 as? ChinaFactory {
    iPhone = factory.getIPhone()
    iPad = factory.getIPad()
}
if let factory = fac1 as? AppleFactory {
    iPhone = factory.getIPhone()
    iPad = factory.getIPad()
}

print("iPad: \(iPad.productName!), os name: \(iPad.osName!), screensize: \(iPad.screenSize!)")
```

### Итак:

Паттерн Абстрактная фабрика используется для обеспечения клиента набором родственных или зависимых объектов. «Семья» объектов, созданных на заводе-изготовителе определяются во время выполнения.