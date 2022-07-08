# Observer

<img src="https://github.com/dinozavr2005/ios-library/blob/main/%D0%A8%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD%D1%8B%20%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F%20Swift/Observer/example-observer.gif"/>

Что такое паттерн **Observer**? Вот вы когда нибудь подписывались на газету? Вы подписываетесь, и каждый раз когда выходит новый номер газеты вы получаете ее к своему дому. Вы никуда не ходите, просто даете информацию про себя, и организация которая выпускает газету сама знает куда и какую газету отнесту. Второе название этого паттерна – Publish – Subscriber.

Как описывает этот паттерн наша любимая GoF книга – Observer определяет одно-ко-многим отношение между объектами, и если изменения происходят в объекте – все подписанные на него объекты тут же узнают про это изменение.

Идея проста, объект который мы называем Subject – дает возможность другим объектам, которые реализуют интерфейс Observer, подписываться и отписываться от изменений происходящик в Subject. Когда изменение происходит – всем заинетерсованным объектам высылается сообщение, что изменение произошло. В нашем случае – Subject – это издатель газеты, Observer это мы с вами – те кто подписывается на газету, ну и собсвтенно изменение – это выход новой газеты, а оповещение – отправка газеты всем кто подписался.

Когда используется паттерн:

Когда Вам необходимо сообщить всем объектам подписанным на изменения, что изменение произошло, при этом вы не знаете типы этих объектов.
Изменения в одном объекте, требуют чтобы состояние изменилось в других объектах, при чем количество объектов может быть разное.
Реализация этого паттерна возможно двумя способами:

## Notification

**Notificaiton** – механизм использования возможностей *NotificationCenter* самой операционной системы. Использование *NSNotificationCenter* позволяет объектам комуницировать, даже не зная друг про друга. Это очень удобно использовать когда у вас в паралельном потоке пришел push-notification, или же обновилась база, и вы хотите дать об этом знать активному на даный момент View.

Чтобы послать такое сообщение стоит использовать конструкцию типа:

```swift
let broadCastMessage = NSNotification(name: "broadCastMessage", object: nil)

let notificationCenter = NSNotificationCenter.defaultCenter()

notificationCenter.addObserver(self, selector: #selector(update), name: "bradCastMessage", object: nil)
```
## Стандартный метод

Стандартный метод, это реализация этого паттерна тогда, когда Subject знает про всех подписчиков, но при этом не знает их типа. Давайте начнем с того, что создадим протоколы для Subject и Observer:
```swift
protocol StandartObserver: class {
    func valueChanged(valueName: String, newValue: String)
}

protocol StandartSubject: class {
    func addObserver(observer: StandartObserver)
    func removeObserver(observer: StandartObserver)
    func notifyObject()
}
```
Теперь, давайте создадим реализацию Subject:
```swift
class StandartSubjectImplementation: StandartSubject {
    private var valueName: String?
    private var newValue: String?
    
    var observerCollection = NSMutableSet()
    
    func addObserver(observer: StandartObserver) {
        self.observerCollection.addObject(observer)
    }
    func removeObserver(observer: StandartObserver) {
        self.observerCollection.removeObject(observer)
    }
    
    func notifyObject() {
        for observer in observerCollection {
            (observer as! StandartObserver).valueChanged(self.valueName!, newValue: self.newValue!)
            
        }
    }
    
    func changeValue(valueName:String, andValue newValue:String) {
        self.newValue = newValue
        self.valueName = valueName
        notifyObject()
    }
}
```
Ну и куда же без обсерверов:
```swift
class SomeSubscriber: StandartObserver {
    func valueChanged(valueName: String, newValue: String) {
        print("Первый обозреватель говорит: Значение \(valueName) поменялось на \(newValue)")
    }
}

class OtherSubscriber: StandartObserver {
    func valueChanged(valueName: String, newValue: String) {
        print("И второй обозреватель говорит: Значение \(valueName) поменялось на \(newValue)")
    }
}
```
Собственно – все:) теперь демо-код:
```swift
let subj = StandartSubjectImplementation()
let oneSub = SomeSubscriber()
let twoSub = OtherSubscriber()

subj.addObserver(oneSub)
subj.addObserver(twoSub)

subj.changeValue("Важное значение", andValue: "09 целых и триста пятьдесять восемь тысячных")

//console:
Первый обозреватель говорит: Значение Важное значение поменялось на 09 целых и триста пятьдесять восемь тысячных
И второй обозреватель говорит: Значение Важное значение поменялось на 09 целых и триста пятьдесять восемь тысячных
```



