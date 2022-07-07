# Factory Method

Еще один порождающий паттерн, довольно прост и популярен.Паттерн позволяет переложить создание специфических объектов, на наследников родительского класса, потому можно манипулировать объектами на более высоком уровне, не заморачиваясь объект какого класса будет создан. Частенько этот паттерн называют виртуальный конструктор, что по моему мнению более выражает его предназначение.

Когда использовать:

1. Мы не до конца уверены объект какого типа нам необходим.
2. Мы хотим чтобы не родительский объект решал какой тип создавать, а его наследники.

Почему хорошо использовать:

Объекты созданные фабричным методом – схожи, потому как у них один и тот же родительский объект. Потому, если локализировать создание таких объектов, то можно добавлять новые типы, не меняя при это код который использует фабричный метод.

## Пример:

Давайте представим, что мы такой неправильный магазин в котором тип товара оценивается по цене:) На данный момент товар есть 2х типов – Игрушки и Машины.

В чеке мы получаем только цены, и нам надо сохранить объекты которые куплены.

Для начала создадим клас Product. Его реализация нас особо не интересует, хотя он может содержать в себе общие для разных типов товаров методы (сделано для примера, мы их особо не используем)

```swift
class Product {
    let price: Int
    let name: String
    
    init(price: Int, name: String) {
        self.price = price
        self.name = name
    }
    
    func getTotalPrice(sum: Int) -> Int {
        return self.price + sum
    }
    
    func saveObject() {
        print(" Saving product \(self.name) to database")
    }
}
```

Создадим два наследника

```swift
class Toy: Product {
    override func saveObject() {
        print(" Saving product \(self.name) into TOYS database")
    }
}

class Car: Product {
    override func saveObject() {
        print(" Saving product \(self.name) into CARS database")
    }
}
```
Ну теперь мы практически в плотную подошли к нашему паттерну Factory. Собственно, теперь надо создать метод, который будет по цене определять что же за продукт у нас в чеке, и создавать объект необходимого типа.
```swift
class ProductGenerator {
    
    func getProduct(price: Int) -> Product? {
        if price > 0 && price < 100 {
            let product = Toy(price: price, name: "Transformer")
            return product
        }
        if price > 100 {
            let product = Car(price: price, name: "Audi")
            return product
        }
        return nil
    }
}
```
Для проверки работы будем использовать метод, который использует ProductGenerator и выведем в лог продукты, которые создала наша фабрика:
```swift
func saveExpenses(aPrice: Int) {
    let pg = ProductGenerator()
    let expense = pg.getProduct(aPrice)
    
    expense?.saveObject()
}


saveExpenses(50)
saveExpenses(80)
saveExpenses(90)
saveExpenses(150)
saveExpenses(560)
saveExpenses(5)
saveExpenses(105)
```

Лог в консоле:

```swift
 Saving product Transformer into TOYS database
 Saving product Transformer into TOYS database
 Saving product Transformer into TOYS database
 Saving product Audi into CARS database
 Saving product Audi into CARS database
 Saving product Transformer into TOYS database
 Saving product Audi into CARS database
 ```
 Итак, шаблон проектирования Фабрика,  или Factory используется для замены конструктора класса, абстрагируя процесс генерации объекта так, чтобы тип экземпляра мог быть определен во время выполнения программы.


