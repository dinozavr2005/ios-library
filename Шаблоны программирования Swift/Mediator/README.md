# Mediator
<img src="https://github.com/dinozavr2005/ios-library/blob/main/%D0%A8%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD%D1%8B%20%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F%20Swift/Mediator/Mediator.png"/>
Медиатор – паттерн который определяет внутри себя объект, в котором реализуется взаимодействие между некоторым количеством объектов. При этом эти объекты, могут даже не знать про существования друг друга, потому взаимодействий реализованых в медиаторе может быть огромное количество.

Когда стоит использовать:

Когда у вас есть некоторое количество объектов, и очень тяжело реализовать взаимодействие между ними. Яркий пример – умный дом. Онозначно есть несколько датчиков, и несколько устройств. К примеру, датчик температуры следит за тем какая на даный момент температура, а кондционер умеет охлаждать воздух. При чем кондиционер, не обязательно знает про существование датчика температуры. Есть центральный компьютер, который получает сигналы от каждого из устройств и понимает, что делать в том или ином случает.
Тяжело переиспользовать объект, так как он взаимодействует и коммуницирует с огромным количеством других объектов.
Логика взаимодействия должна легко настраиваться и расширяться.
Собственно, пример медиатора даже писать безсмысленно, потому как это любой контроллер который мы используем во время нашей разработки. Посудите сами – на view есть очень много контролов, и все правила взаимодействия мы прописываем в контроллере. Элементарно.

И все же пример не будет лишним Давайте все же создадим пример который показывает создание аля умного дома.

Пускай у нас есть оборудование которое может взаимодействоать с нашим умным домом:
```swift
class SmartHousePart {
    private weak var processor: CentralProcessor
    
    init(withCore processor: CentralProcessor) {
        self .processor = processor
    }
    
    func numberChanged() {
        processor.valueChanged(self)
    }
}
```
Теперь, создадим сердце нашего умного дома:
```swift
class CentralProcessor {
    var thermometer:  Thermometer?
    var condSystem: ConditioningSystem?
    
    func valueChanged(aPart: SmartHousePart) {
        print("значение изменилось! нужно что-то сделать")
        
        // Определяем, что изменилась именно темперетура
        if aPart is Thermometer {
            print("Да - изменилась именно температура, включим кондер...")
            condSystem?.startCondition()
        }
        
    }
}
```
В классе `CentrallProcessor` в методе `valueChanged` мы определяем с какой деталью и что произошло, чтобы адекватно среагировать. В нашем примере – изменение температуры приводт к тому что мы включаем кондиционер.

А вот, и код термометра и кондиционера:
```swift
class Thermometer: SmartHousePart {
    var temperature: Int?
    
    func temperatureChanged(temperature: Int) {
        self.temperature = temperature
        self.numberChanged()
    }
}

class ConditioningSystem: SmartHousePart {
    func startCondition() {
        print("Охлаждаю")
    }
}
```
Как видим в результате у нас есть два объекта, которые друг про друга не в курсе, и все таки они взаимодействуют друг с другом посредством нашего медиатора `CentrallProcessor`. Запустим тестирование.
```swift
let processor = CentralProcessor()

let therm = Thermometer(withCore: processor)
let cond = ConditioningSystem(withCore: processor)

processor.condSystem = cond
processor.thermometer = therm

therm.temperatureChanged(45)

//console:
значение изменилось! нужно что-то сделать
Да - изменилась именно температура, включим кондер...
Охлаждаю
```


