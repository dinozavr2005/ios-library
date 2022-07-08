# Adapter

<img src="https://github.com/dinozavr2005/ios-library/blob/main/%D0%A8%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD%D1%8B%20%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F%20Swift/Adapter/adapter.jpeg"/>

Представьте, что Вы едете в коммандировку в США. У Вас есть, допустим, ноутбук купленный в Европе – следовательно вилка на проводе от блока питания имеет круглые окончания. Что делать? Покупать зарядку для американского типа розетки? А когда вы вернетесь домой – она будет лежать у Вас мертвым грузом?

Потому, вероятнее всего, Вы приобретете один из адаптеров, которые надеваются на вилку, и которая позволяет Вам использовать старую зарядку и заряжаться от совершенно другой розетки.

Примечание автора: суть вышеизложенной проблемы отображает заглавная картинка к данной статье, однако стоит иметь ввиду что картинка рисовалась явно не российским художником. Т.к. то что художник назвал стандартной вилкой — явно введет в ступор российского пользователя. Но это все лишь формальности…

Так и с Адаптером – он конвертит интерфейс класса – на такой, который ожидается.

Сам паттерн состоит из трех частей: Цели (target), Адаптера (adapter), и адаптируемого (adaptee).

В нашей с вами проблеме:

Target – ноутбук со старой зарядкой
Adapter – переходник.
Adaptee – розетка с квадртаными дырками.

Имплементация паттерна Адаптер на Swift может быть 2.

## Простая имплементация Adapter

Итак, первая – это простенькая имплементация. Пускай у нас есть объект Bird, который реализует протокол BirdProtocol:

```Swift
protocol BirdProtocol {
    func sing()
    func fly()
}

class Bird: BirdProtocol {
    func sing() {
        print("Ку-ка-ре-ку")
    }
    
    func fly() {
        print("Я лечу-у-у-у!")
    }
}
```
И пускай у нас есть объект Raven, у которого есть свой интерфейс:
```Swift
class Raven {
    func flySearchAndDestroy() {
        print("Цель обнаружена! Захожу справа от люсты!")
    }
    
    func vioce() {
        print("Кар-кар!")
    }
}
```

Чтобы использовать ворону в методах которые ждут птицу стоит создать адаптер:

```Swift
class RavenAdapter: BirdProtocol {
    private let raven: Raven
    
    init(adaptee: Raven) {
        self.raven = adaptee
    }
    
    func sing() {
        raven.vioce()
    }
    
    func fly() {
        raven.flySearchAndDestroy()
    }
}
```

А тестом работоспособности у нас будет функция, которая в качестве параметра принимает объекты, удовлетворяющие протоколу BirdProtocol

```Swift
func  makeTheBerdTest(aBird: BirdProtocol) {
    aBird.fly()
    aBird.sing()
}
```

Теперь можно запускать тест:

```Swift
let simpleBird = Bird()
let simpleRaven = Raven()

let ravenAdapter = RavenAdapter(adaptee: simpleRaven)

makeTheBerdTest(simpleBird)
print(" ---- ")
makeTheBerdTest(ravenAdapter)

// console
Я лечу-у-у-у!
Ку-ка-ре-ку
 ---- 
Цель обнаружена! Захожу справа от люсты!
Кар-кар!
```

## Adapter через делегирование

Теперь более сложная реализация, которая все еще зависит от протоколов, но уже использует делегацию. Вернемся к нашему несчастному ноутбуку и зарядке: Допустим у нас есть базовый класс Charger:

```Swift
class Charger {
    func charge() {
        print("Я заряжаю!")
    }
}
```
И есть протокол для европейской зарядки:
```Swift
protocol EuropeanNotebookChargerDelegate: class {
    func cargeNotebookRoundHoles(charger: Charger)
}
```
Если сделать просто реализацию – то получится тоже самое, что и в прошлом примере. Потому мы добавим делегат:
```Swift
class EuropeanNotebookCharger: Charger, EuropeanNotebookChargerDelegate {
   
    weak var delegate: EuropeanNotebookChargerDelegate?
    
    override init() {
        super.init()
        delegate = self
    }
    
    override func charge() {
        delegate?.cargeNotebookRoundHoles(self)
        super.charge()
    }
    
    func cargeNotebookRoundHoles(charger: Charger) {
        print("Заряжаю 220 вольт и розеткой с круглыми дырочками")
    }
}
```
Как видим, у нашего класса есть свойство которое реализует тип *EuropeanNotebookChargerDelegate*. Так как, наш класс этот протокол реализует, он может свойству присвоить себя.

Теперь, давайте глянем что ж за зверь такой – американская зарядка:

```Swift
class USANotebookCharger {
    func chargeNotebookRectHoles(charger: Charger) {
        print("Заряжаю розеткой с ПРЯМОУГОЛЬНЫМИ дырочками ")
    }
}
```
Как видим, в американской зарядке совсем другой метод и мировозрение.

Давайте, создадим адаптер для зарядки

```Swift
class USANottebookEuropeanAdapter: Charger, EuropeanNotebookChargerDelegate {
    
    let usaCharger: USANotebookCharger
    
    init(withUSANotebookCharger charger: USANotebookCharger) {
        self.usaCharger = charger
        super.init()
    }
    
    override func charge() {
        let euroCharge = EuropeanNotebookCharger()
        euroCharge.delegate = self
        euroCharge.charge()
    }
    
    func cargeNotebookRoundHoles(charger: Charger) {
        usaCharger.chargeNotebookRectHoles(charger)
    }
}
```
**Адптер** реализует интерфейс *EuropeanNotebookChargerDelegate* и его метод chargetNotebookRoundHoles. Потому, когда вызывается метод _charge_ – на самом деле создается тип европейской зарядки, ей присвается наш адаптер как делегат, и вызывается ее метод charge. Так как делегатом присвоен наш адаптер, при вызове метода *chargetNotebookRoundHoles*, будет вызыван этот метод нашего адаптера, который в свою очередь вызывает метод зарядки США.
Давайте посмотрим тест код и вывод лога:
```Swift
func makeTheNotebookCharge(aCharger: Charger) {
    aCharger.charge()
}

let euroCharger = EuropeanNotebookCharger()
makeTheNotebookCharge(euroCharger)
let usaChager = USANotebookCharger()
let adapter = USANottebookEuropeanAdapter(withUSANotebookCharger: usaChager)
makeTheNotebookCharge(adapter)

//console
Заряжаю 220 вольт и розеткой с круглыми дырочками
Я заряжаю!
Заряжаю розеткой с ПРЯМОУГОЛЬНЫМИ дырочками 
Я заряжаю!
```
