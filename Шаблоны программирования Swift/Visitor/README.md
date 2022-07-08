# Visitor

Вот у каждого дома вероятнее всего есть холодильник. В ВАШЕМ доме, ВАШ холодильник. Что будет если холодильник сломается? Некоторые пойдут почитают в интернете как чинить холодильник, какая модель, попробуют поколдовать над ним, и разочаровавшись вызовут мастера по ремонту холодильников. Заметьте – холодильник ваш, но функцию “Чинить Холодильник” выполняет совершенно другой человек, про которого вы ничего не знаете, а попросту – обычный визитер
Паттерн визитер – позволяет вынести из наших объектов логику, которая относится к этим объектам, в отдельный клас, что позволяет нам легко изменять / добавлять алгоритмы, при этом не меняя логику самого класа.
Когда мы захотим использовать этот паттерн:

Когда у нас есть сложный объект, в котором содержится большое количество различных элементов, и вы хотите выполнять различные операции в зависимости от типа этих элиментов.
Вам необходимо выполнять различные операции над классами, и при этом Вы не хотите писать вагон кода внутри реализации этих классов.
В конце–концов, вам нужно добавлять различные операции над элементами, и вы не хотите постоянно обновлять классы этих элементов.
Рассмотрим пример: у нас есть несколько складов, в каждом складе можнт хранится товар. Один визитер будет смотреть склады, другой визитер будет называть цену товара в складе.
Итак, для начала сам товар:
```swift
class WarehouseItem {
  var name:String
  var isBroken: Bool
  var price: Int

  init(aName:String, isBrokenState: Bool, aPrice: Int) {
    self.name = aName
    self.isBroken = isBrokenState
    self.price = aPrice
  }
}
```
И естественно сам склад:
```swift
class Warehouse {
    lazy var itemsArray: [WarehouseItem] = []
    
    func addItem(anItem: WarehouseItem) {
        itemsArray.append(anItem)
    }
    
    func accept(visitor: BasicVisitor) {
        visitor.visit(self)
        
        for item in itemsArray {
            visitor.visit(item)
        }
    }
}
```
Как видим, наш склад умеет хранить и добавлять товар, но также обладает таинственным методом accept который принимает в себя визитор и вызвает его метод visit. Чтобы картинка сложилась, давайте создадим протокол BasicVisitor и различных визиторов:
```swift
protocol BasicVisitor {
    func visit(anObject: AnyObject)
}
```
Как видим, протокол требует реализацию только одного метода. Теперь давайте перейдем к самим визитерам:
```swift
class QualityCheckerVisitor: BasicVisitor {
    func visit(anObject: AnyObject) {
        
        if let obj = anObject as? WarehouseItem {
            if obj.isBroken {
                print("Товар \(obj.name) сломан")
            } else {
                print("Товар \(obj.name) весьма не плох")
            }
        }
        
        if let _ = anObject as? Warehouse {
            print("Отличный склад!")
        }
    }
}
```
Если почитать код, то сразу видно что визитер при вызове своего метода visit определяет тип объекта который ему передался, и выполняет определнные функции в зависимоти от этого типа. Данный объект просто говорит или вещи на складе поломаны, а так же что ему нравится склад:)
```swift
class PriceCheckerVisitor:BasicVisitor {
    func visit(anObject: AnyObject) {
        if let obj = anObject as? WarehouseItem {
            print("Товар \(obj.name) имеет цену: \(obj.price)")
        }
        
        if let _ = anObject as? Warehouse {
            print("Я не знаю сколько стоит склад!")
        }
    }
}
```
В принципе этот визитер делает тоже самое, только в случае склада он признается что растерян, а в случае товара говорит цену товара!

Теперь давайте запустим то что у нас получилось! Код генерации тестовых даных:
```swift
let warehouse = Warehouse()

warehouse.addItem(WarehouseItem(aName: "Товар1", isBrokenState: true, aPrice: 37))
warehouse.addItem(WarehouseItem(aName: "Товар2", isBrokenState: true, aPrice: 45))
warehouse.addItem(WarehouseItem(aName: "Товар3", isBrokenState: false, aPrice: 74))
warehouse.addItem(WarehouseItem(aName: "Товар4", isBrokenState: false, aPrice: 34))
warehouse.addItem(WarehouseItem(aName: "Товар5", isBrokenState: true, aPrice: 15))
warehouse.addItem(WarehouseItem(aName: "Товар6", isBrokenState: true, aPrice: 84))
warehouse.addItem(WarehouseItem(aName: "Товар7", isBrokenState: false, aPrice: 91))
warehouse.addItem(WarehouseItem(aName: "Товар8", isBrokenState: false, aPrice: 50))
warehouse.addItem(WarehouseItem(aName: "Товар9", isBrokenState: true, aPrice: 11))


let priceVisitor = PriceCheckerVisitor()
let qualityVisitor = QualityCheckerVisitor()

warehouse.accept(priceVisitor)
print("- - - - - - - - - - - - - - - - - - - - ")
warehouse.accept(qualityVisitor)

//console:
Я не знаю сколько стоит склад!
Товар Товар1 имеет цену: 37
Товар Товар2 имеет цену: 45
Товар Товар3 имеет цену: 74
Товар Товар4 имеет цену: 34
Товар Товар5 имеет цену: 15
Товар Товар6 имеет цену: 84
Товар Товар7 имеет цену: 91
Товар Товар8 имеет цену: 50
Товар Товар9 имеет цену: 11
- - - - - - - - - - - - - - - - - - - - 
Отличный склад!
Товар Товар1 сломан
Товар Товар2 сломан
Товар Товар3 весьма не плох
Товар Товар4 весьма не плох
Товар Товар5 сломан
Товар Товар6 сломан
Товар Товар7 весьма не плох
Товар Товар8 весьма не плох
Товар Товар9 сломан
```