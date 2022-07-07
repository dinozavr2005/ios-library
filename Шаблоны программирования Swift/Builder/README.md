# Builder

<img src="https://github.com/dinozavr2005/ios-library/blob/main/%D0%A8%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD%D1%8B%20%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F%20Swift/Singleton/singleton.jpeg"/>

Вот представьте что у нас есть фабрика. Но в отличии от фабрики из предыдущей статьи, она умеет создавать только телефоны на базе андроида, и еще при этом различной конфигурации. Тоесть, есть один объект, но при этом его состояние может быть совершенно разным, а еще представьте если его очень трудно создавать, и во время создания этого объекта еще и создается миллион дочерних объектов. Именно в такие моменты, нам очень помогает такой паттерн как строитель.

Когда использовать:

1. Создание сложного объекта
2. Процесс создания объекта тоже очень не тривиальный – к примеру получение данных из базы и манипуляция ими.

Сам паттерн состоит из двух компонент – Bulilder и Director. Builder занимается именно построением объекта, а Director знает какой Builder использовать чтобы выдать необходимый продукт.

Пускай у нас есть телефон, который обладает следующими свойствами:
```swift
class AndriodPhone {
    var osVersion = ""
    var name = ""
    var cpuCodeName = ""
    var RAMsize = 0
    var osVersionCode = 0
    var launcher = ""
    
    
    func setOSVersion() {
        self.osVersion = ""
    }
    
    func setName() {
        self.name = ""
    }
    
    func setCPUCodeName() {
        self.cpuCodeName = ""
    }
    
    func setRAMsize() {
        self.RAMsize = 0
    }
    
    func setOSVersionCode() {
        self.osVersionCode = 0
    }
    
    func setLauncher() {
        self.osVersion = ""
    }
}
```
Давайте создадим дженерик строителя от которого будут наследоваться конкретные строители:

```swift
class BPAndroidPhoneBuilder {

    let phone = AndriodPhone()
 
    
    func getPhone() -> AndriodPhone  {
        return self.phone
    }
    
}
```

Ну а теперь напишем код для конкретных строителий. К примеру, так бы выглядел строитель для дешевого телефона:

```swift
class LowPricePhoneBuilder: BPAndroidPhoneBuilder {
    func setOSVersion() {
        self.phone.osVersion = "Android 2.3"
    }
    
    func setName() {
        self.phone.name = "Ведрофон"
    }
    
    func setCPUCodeName() {
        self.phone.cpuCodeName = "Some shitty CPU"
    }
    
    func setRAMsize() {
        self.phone.RAMsize = 256
    }
    
    func setOSVersionCode() {
        self.phone.osVersionCode = 3
    }
    
    func setLauncher() {
        self.phone.launcher = "Hia Tsung"
    }
}
```

И конечно же строительство дорогого телефона:

```swift
class HighPricePhoneBuilder: BPAndroidPhoneBuilder {
    func setOSVersion() {
        self.phone.osVersion = "Android 5.0"
    }
    
    func setName() {
        self.phone.name = "Крутой лопатофон"
    }
    
    func setCPUCodeName() {
        self.phone.cpuCodeName = "Some shitty, but expensive CPU"
    }
    
    func setRAMsize() {
        self.phone.RAMsize = 2048
    }
    
    func setOSVersionCode() {
        self.phone.osVersionCode = 5
    }
    
    func setLauncher() {
        self.phone.launcher = "HTC Sence"
    }
}
```
Кто-то же должен использовать строителей, потому давайте создадим объект который будет с помощью строителей создавать дешевые или дорогие телефоны:
```swift
class FactorySalesMan {
    
    var builder = BPAndroidPhoneBuilder()
    
    func setBuilder(aBuilder: BPAndroidPhoneBuilder) {
        self.builder = aBuilder
    }
    
    func getPhone() -> AndriodPhone {
        return self.builder.getPhone()
    }
    

    
    func constuctPhone() {
        if let builder = builder as? LowPricePhoneBuilder {
            builder.setOSVersion()
            builder.setName()
            builder.setCPUCodeName()
            builder.setRAMsize()
            builder.setOSVersionCode()
            builder.setLauncher()
            
        } else if let builder = builder as? HighPricePhoneBuilder {
            builder.setOSVersion()
            builder.setName()
            builder.setCPUCodeName()
            builder.setRAMsize()
            builder.setOSVersionCode()
            builder.setLauncher()
        }
    }
}
```
Ну теперь давайте посмотрим что же у нас получилось:
```swift
let cheapPhoneBuilder = LowPricePhoneBuilder()
let expensivePhoneBuilder = HighPricePhoneBuilder()

let director = FactorySalesMan()
director.setBuilder(cheapPhoneBuilder)
director.constuctPhone()
let phone = director.getPhone()
print("Phone name \(phone.name), phone cpu: \(phone.cpuCodeName)")

director.setBuilder(expensivePhoneBuilder)
director.constuctPhone()
let phone2 = director.getPhone()
print("Phone2 name \(phone2.name), phone cpu: \(phone2.cpuCodeName)")

//print console
Phone name Ведрофон, phone cpu: Some shitty CPU
Phone2 name Крутой лопатофон, phone cpu: Some shitty, but expensive CPU
```