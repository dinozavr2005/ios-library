# Singleton

<img src="https://github.com/dinozavr2005/ios-library/blob/main/%D0%A8%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD%D1%8B%20%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F%20Swift/Prototype/prototype.png"/>

Singleton — это такой объект, который существует в системе только в единственном экземпляре. Очень часто используется для хранения каких — то глобальных переменных, например настроек приложения. Написание кода для создания подобного объекта следующее:

```swift
class SingletonObject {
    
    var someProperty: String = ""
    
    class var singleton: SingletonObject {
        struct ForStatic {
           static var onceToken: dispatch_once_t = 0
           static var singletonObject: SingletonObject? = nil
        }
        dispatch_once(&ForStatic.onceToken) {
            ForStatic.singletonObject = SingletonObject()
        }
        
        return ForStatic.singletonObject!
    }

}
```

Собственно вот и все:)  iOS сам за нас позаботится о том, чтобы создан был только один экземпляр нашего объекта. Тут стоит сделать шаг назад и описать проблему, которая является головной болью любого кто более — менее близко работал с потоками:

Представьте что есть 2 потока. И тут каждый, одновременно создает singleton. Вроде бы и должен создаться только один объект, но потому что все происходит в один момент –бывают случаи когда создается два объекта. Или еще более сложная ситуация: объекта singleton не существует. Два потока хотят его создать одновременно: Поток 1 делает проверку на существование объекта. Видит что его нет, и проходит этап проверки. 2.Поток 2 делает проверку на существование объекта, и хоть и поток 1 проверку УЖЕ прошел, но объект ЕЩЕ не существует. Для решения таких проблем dispatch_once делает блокирование кода, для других потоков, пока он исполняется в каком–либо потоке.  Потому, ни один поток не может зайти в этот код, пока он занят.

Проверка:
```swift
let oneST = SingletonObject.singleton
oneST.someProperty = "First instance"

let twoST = SingletonObject.singleton
twoST.someProperty = "Second instance"

print("First: \(oneST.someProperty) and second: \(twoST.someProperty)")

//console:
First: Second instance and second: Second instance
```
Думаю, понятно, что при создании второго указателя twoST, он сослался на тот же экземпляр что и oneST, и поэтому изменения свойств через один указатель повлияют и на другой.

Итак, шаблон Singleton гарантирует, что только один объект определенного класса будет когда-либо создан. Все последующие ссылки на объекты этого класса указывают на тот же экзеvпляр.

```swift
class DeathStarSuperlaser {
    static let sharedInstance = DeathStarSuperlaser()

    private init() {

    }
}


let laser = DeathStarSuperlaser.sharedInstance
```
Инициализатор private используется, чтобы невозможно было создать еще один объект.

А теперь давайте вспомним, где Вы уже применяли это шаблон программирования.

```swift
NSUserDefaults.standardUserDefaults()
    // только одно хранилище 
UIApplication.sharedApplication()
    // только одно приложение
UIScreen.mainScreen()
    // только один внутренний экран у устройства
NSNotificationCenter.defaultCenter()
    // только один центр уведомлений
```