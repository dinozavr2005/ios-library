# Decorator

<img src="https://github.com/dinozavr2005/ios-library/blob/main/%D0%A8%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD%D1%8B%20%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F%20Swift/Decorator/decorator_design.gif"/>
Класный пример декоратора – различные чехлы для новых телефонов.  Для начала у нас есть телефон. Но так как телефон дорогой, мы будем очень счастливы если он не разобьется при любом падении – потому мы покупаем чехол для него. То есть, к уже существующему предмету мы добавили функционал защиты от падения. Ну еще мы взяли стильный чехол – теперь наш телефон еще и выглядит отлично. А потом мы докупили съемный объектив, с помощью которого можно делать фотографии с эффектом “рыбьего глаза”. Декорировали наш телефон дополнительным функционалом:)

Вот, приблизительно так выглядит реально описание паттерна декоратор. Теперь описание GoF:
Декоратор добавляет некий функционал уже существующему объекту.

Когда использовать этот паттерн:

1. Вы хотите добавить определенному объекту дополнительные возможности, при этом не задевая и не меняя других объектов

2. Дополнительные возможности класса – опциональны

Радость Swift в данном случае – это использование расширений extension. Я не буду детально описывать расширения в этой статье, но в двух словах все же расскажу: Расширения – это возможность расширить любой объект дополнительным функционалом без использования механизма наследования. Давайте возьмем супер простой пример – декорирование Cocoa классов. К примеру добавим новый метод для объекта NSDate:
```Swift
extension NSDate {
    func convertDateToString() -> String  {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd-0M-yyyy"
        return formatter.stringFromDate(self)
    }
}
```
Как видим наше расширение определяет только один метод “convertDateToString”, который дату форматирует в текстовый формат

Собственно, это все.
```Swift
let dateNow = NSDate()
print("Сейчас: \(dateNow.convertDateToString())")

//console:
Сейчас: 25-07-2016
```


