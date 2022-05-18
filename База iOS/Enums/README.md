# Enums

## Примеры

```swift
class Tile {
    enum StatusState {
        case loading
        case loaded
        case failed
        case delinquent
    }
    
    var status: StatusState {
        didSet {
            switch status {
            case .loading: loadingState.isHidden = false
            case .loaded: loadedState.isHidden = false
            case .failed: failedState.isHidden = false
            case .delinquent: delinquentState?.isHidden = false
            }
        }
    }
}
```

```swift
enum Character {
    enum Weapon {
        case bow
        case sword
        case dagger
    }

    enum Helmet {
        case wooden
        case iron
        case diamond
    }

    case thief(weapon: Weapon, helmet: Helmet)
    case warrior(weapon: Weapon, helmet: Helmet)

    func getDescription() -> String {
        switch self {
        case let .thief(weapon, helmet):
            return "Thief chosen \(weapon) and \(helmet) helmet"
        case let .warrior(weapon, helmet):
            return "Warrior chosen \(weapon) and \(helmet) helmet"
        }
    }
}

let helmet = Character.Helmet.iron
print(helmet)
//prints "iron"

let character1 = Character.warrior(weapon: .sword, helmet: .diamond)
print(character1.getDescription())
// prints "Warrior chosen sword and diamond helmet"
```

```swift
open class NetworkReachabilityManager {
    public enum NetworkReachabilityStatus {
        case unknown
        case notReachable
        case reachable(ConnectionType)
    }

    public enum ConnectionType {
        case ethernetOrWiFi
        case wwan
    }

    // MARK: - Properties

    open var isReachable: Bool { return isReachableOnWWAN || isReachableOnEthernetOrWiFi }
    open var isReachableOnWWAN: Bool { return networkReachabilityStatus == .reachable(.wwan) }
    open var isReachableOnEthernetOrWiFi: Bool { return networkReachabilityStatus == .reachable(.ethernetOrWiFi) }
    
    open var networkReachabilityStatus: NetworkReachabilityStatus {
        return .unknown
    }
```

## Enums in structs

Здесь решение о том, что сделать перечислением, а что структурой, может быть расплывчатым. Например, мы могли бы определить героя(Character) исключительно как перечисление:

```swift
enum Character {
    enum Weapon {
        case bow
        case sword
        case dagger
    }
    case thief(weapon: Weapon)
    case warrior(weapon: Weapon)

let character1 = Character.warrior(weapon: .sword)
```

Но мы могли бы создать Героя и через struct: 

```swift
struct Character {
    enum CharacterType {
        case thief
        case warrior
    }
    enum Weapon {
        case bow
        case sword
        case dagger
    }
    let type: CharacterType
    let weapon: Weapon
}

let character = Character(type: .warrior, weapon: .sword)
print("\(character.type) chosen \(character.weapon)")
```
Какая разница? В первом случае информация о типе Character захватывается как часть самого перечисления. Поэтому вы определяете это исключительно с точки зрения перечислений:

```swift
let character1 = Character.warrior(weapon: .sword)
```

В случае со структурой, вы определяете одни и те же внутренние перечисления, но перечисление верхнего уровня определяется как struct, в которой хранятся перечисления, которые он использует внутри сохраненные свойства(stored properties).

Какой из них вы используете, зависит от стиля и обстоятельств. Если вам подойдет простое определение всего с точки зрения перечислений, это отличный выбор, поскольку он очень легкий и практически не требует накладных расходов.

Если вы считаете, что вашему Герою нужно больше данных в виде легендарных свойств, или вы хотите начать добавлять больше функций и состояний, структура будет подходящим вариантом. Немного тяжелее. Но все равно очень легкая.

## Enums as Strings

В Swift перечисления не обязательно должны быть целыми числами(Int). Мы также можем представлять перечисления как строки(String).

```swift
enum SegueIdentifier: String {
    case Login
    case Main
    case Options
}

// or

enum EmployeeType: String {
    case Executive
    case SeniorManagement = "Senior Management"
    case Staff
}
```

Прелесть String в том, что вам больше не нужно хардкодить строки, разбросанные по всей вашей библиотеке. Теперь вы можете захватывать их как типы перечислений.

```swift
override func prepareForSegue(...) {
    if let identifier = segue.identifier ... {
        switch segueIdentifier {
        case .Login:
            ...
        case .Main:
            ...
        case .Options:
            ...
        }
    }
    
    SequeIdentifer.Main.rawValue // returns the `String representation`
}
```

## Enums and associated values

Перечисления — это гораздо больше в Swift, потому что, когда вы думали, что они не могут быть лучше, вы узнаете, что также можете связывать значения или параметры с перечислениями.

```swift
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
```

Это перечисление выше может принимать кортеж значений или связанных с ним типов. На самом деле мне не нравится эта форма перечисления, потому что она не говорит мне, что представляют собой связанные значения. Я думаю, что что-то вроде этого намного лучше.

```swift
public class StandardEntryView: UIView {
    
    public enum Kind {
        case email(showHeaderView: Bool)
        case listSelection(showHeaderView: Bool, pickerTitle: String, list: [(String, Any)])
    }

    public let kind: Kind

    public init(kind: Kind = Kind.email(showHeaderView: false)) {
        self.kind = kind
        super.init(frame: .zero)
        commonInit()
    }
```


Здесь у нас есть UIView, который может находиться в одном из двух состояний: email и listSelection. Но вместе с каждым из этих состояний мы можем передавать дополнительную информацию или связанные значения.

Это означает, что наши перечисления не могут иметь состояния! Это определенно стирает границы между традиционными перечислениями как простыми типами, представляющими целые числа, и этим новым перечислением в Swift. Потому что теперь в Swift мы можем создавать эти перечисления, ассоциировать с этими дополнительными типами объектов, а затем использовать эту информацию, когда мы включим их позже.

```swift
func commonInit() {

        let showHeader: Bool

        switch kind {
        case .email(let showHeaderView): // unwrapping the associated value
            showHeader = showHeaderView
        case .listSelection(let showHeaderView, _, _):
            showHeader = showHeaderView
        }

    }
```

Эта возможность передавать информацию с помощью перечисления действительно крута, и Swift поддерживает это. И если вас не волнуют переданные связанные значения, вы можете полностью их игнорировать.

```swift
switch kind {
        case .email:
            textField = UITextField()
        case .listSelection:
            textField = NoCaratNoTypingTextField()
        }
```

Или выборочно

```swift
switch kind {
        case .email:
            break
        case .listSelection(_, let pickerTitle, let listItems):
            break
        }
```

Перечисления с методами

```swift
enum WeekDay :String {
    case Monday
    case Tuesday
    func day() ->String { return self.rawValue }
}
print(WeekDay.Monday.day()) // prints Monday
```

Теперь это действительно выводит перечисления на совершенно новый уровень. Теперь у вас есть возможность добавлять методы к перечислениям. Это определенно размытие классов, объектов и структур перечислениями. Но перечисления настолько дешевы, что являются хорошей альтернативой. Опять же, для вещей, которые естественным образом представляют состояние.


## Enums with Computed Properties

```swift
enum Device {
  case iPad
  case iPhone

  var year: Int {
    switch self {
      case .iPhone: 
        return 2007
      case .iPad: 
        return 2010
    }
  }
}

let device = Device.iPhone
print(device.year)
```

Обратите внимание, что перечисления не могут иметь сохраненных свойств. Другими способами вы не можете этого сделать.

```swift
enum Device {
  case iPad
  case iPhone

  var year: Int // BOOM!
}
```

## Enums with mutating methods

Перечисления сами по себе не имеют состояния. Но вы можете моделировать или переключать состояние enums, заставляя его мутировать. Создавая изменяющую функцию, которая может устанавливать неявный параметр self, использование может изменить состояние самого перечисления, на которое ссылаются.

```swift
enum TriStateSwitch {
    case off
    case low
    case high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var ovenLight = TriStateSwitch.off
ovenLight.next() // ovenLight is now equal to .low
ovenLight.next() // ovenLight is now equal to .high
ovenLight.next() // ovenLight is now equal to .off again
```

Это действительно круто, потому что это как конечный автомат внутри себя.

## Enums with static methods

```swift
enum Device {
    case iPhone
    case iPad

    static func getDevice(name: String) -> Device? {
        switch name {
        case "iPhone":
            return .iPhone
        case "iPad":
            return .iPad
        default:
            return nil
        }
    }
}

if let device = Device.getDevice(name: "iPhone") {
    print(device)
    //prints iPhone
}
```

## Enums with initializers

```swift
enum IntCategory {
    case small
    case medium
    case big
    case weird

    init(number: Int) {
        switch number {
        case 0..<1000 :
            self = .small
        case 1000..<100000:
            self = .medium
        case 100000..<1000000:
            self = .big
        default:
            self = .weird
        }
    }
}

let intCategory = IntCategory(number: 34645)
print(intCategory)
```

## Enums and Protocols

Опять же, стирая грань между перечислением и структурой, но если вы хотите, чтобы перечисление подтверждало протокол, вы можете сделать это так.

```swift
protocol LifeSpan {
    var numberOfHearts: Int { get }
    mutating func getAttacked() // heart -1
    mutating func increaseHeart() // heart +1
}

enum Player: LifeSpan {
    case dead
    case alive(currentHeart: Int)

    var numberOfHearts: Int {
        switch self {
        case .dead: return 0
        case let .alive(numberOfHearts): return numberOfHearts
        }
    }

    mutating func increaseHeart() {
        switch self {
        case .dead:
            self = .alive(currentHeart: 1)
        case let .alive(numberOfHearts):
            self = .alive(currentHeart: numberOfHearts + 1)
        }
    }

    mutating func getAttacked() {
        switch self {
        case .alive(let numberOfHearts):
            if numberOfHearts == 1 {
                self = .dead
            } else {
                self = .alive(currentHeart: numberOfHearts - 1)
            }
        case .dead:
            break
        }
    }
}

var player = Player.dead // .dead

player.increaseHeart()  // .alive(currentHeart: 1)
print(player.numberOfHearts) //prints 1

player.increaseHeart()  // .alive(currentHeart: 2)
print(player.numberOfHearts) //prints 2

player.getAttacked()  // .alive(currentHeart: 1)
print(player.numberOfHearts) //prints 1

player.getAttacked() // .dead
print(player.numberOfHearts) // prints 0
```

## Enums and Extensions

Перечисления могут иметь расширения, и это удобно, когда вы хотите отделить свои структуры данных от своих методов.

Обратите внимание на ключевое слово mutating. Каждый раз, когда вы хотите изменить состояние перечисления, необходимо определение изменяющего метода.

```swift
enum Entities {
    case soldier(x: Int, y: Int)
    case tank(x: Int, y: Int)
    case player(x: Int, y: Int)
}

extension Entities {
    mutating func attack() {}
    mutating func move(distance: Float) {}
}

extension Entities: CustomStringConvertible {
    var description: String {
        switch self {
        case let .soldier(x, y): return "Soldier position is (\(x), \(y))"
        case let .tank(x, y): return "Tank position is (\(x), \(y))"
        case let .player(x, y): return "Player position is (\(x), \(y))"
        }
    }
}
```

## Enums as generics

Да, вы даже можете генерировать перечисления.

```swift
enum Information<T1, T2> {
    case name(T1)
    case website(T1)
    case age(T2)
}
```

Здесь компилятор может распознать T1 как «Bob», но T2 еще не определен. Следовательно, мы должны явно определить и T1, и T2, как показано ниже.

```swift
let info = Information.name("Bob") // Error

let info =Information<String, Int>.age(20)
print(info) //prints age(20)
```

## Other misc things

### Enums as guards

Еще один пример того, как перечисления можно использовать с операторами защиты.

```swift
enum ChatType {
    case authenticated
    case unauthenticated
}

class NewChatViewController: UIViewController {

    let chatType: ChatType

    public init(chatType: ChatType) { ... }

    guard chatType == .authenticated else {
        return
    }
```

### Iterating over enums

```swift
enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count

for beverage in Beverage.allCases {
    print(beverage)
}
```

### Enums as Errors

```swift
public enum AFError: Error {

    case invalidURL(url: URLConvertible)
    case parameterEncodingFailed(reason: ParameterEncodingFailureReason)
    case multipartEncodingFailed(reason: MultipartEncodingFailureReason)
    case responseValidationFailed(reason: ResponseValidationFailureReason)
    case responseSerializationFailed(reason: ResponseSerializationFailureReason)

    public enum ParameterEncodingFailureReason {
        case missingURL
        case jsonEncodingFailed(error: Error)
        case propertyListEncodingFailed(error: Error)
    }

    public var underlyingError: Error? {
        switch self {
        case .parameterEncodingFailed(let reason):
            return reason.underlyingError
        case .multipartEncodingFailed(let reason):
            return reason.underlyingError
        case .responseSerializationFailed(let reason):
            return reason.underlyingError
        default:
            return nil
        }
    }

}

extension AFError {
    /// Returns whether the AFError is an invalid URL error.
    public var isInvalidURLError: Bool {
        if case .invalidURL = self { return true }
        return false
    }
}
```

## Enums and versions

Скажем, у вас есть серверная служба, в которой тип представлен как перечисление, и вы хотите проверить его в будущем, когда появятся новые типы. Создайте `Unknown` версии и установите их как тип перечисления, если вы не можете декодировать их из JSON.

```swift
enum AccountSubType: String, Codable {
    case Chequing
    case Saving
    case Unknown
}

extension AccountSubType {
    init(from decoder: Decoder) throws {
        self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? Self.Unknown
    }
}
```

## Есть ли что-то, что перечисления не могут сделать?

Да. Перечисления не поддерживают хранимые свойства.

Другими словами, вы не можете этого сделать

```swift
enum Device {
  case iPad
  case iPhone

  var year: Int
}
```
### Как добавить перечисление в существующий Struct

Допустим, вы хотите, чтобы структура возвращала перечисление на основе внутреннего типа.

```swift
enum ActivationModemType: String {
    case hayes
    case usRobotics
    case unknown
}

struct OrderItem {
    let modemType: String
}

extension OrderItem {
    // computed getter
    public var activationModemType: ActivationModemType {
        guard let modemType = modemType, let returnValue = ActivationModemType(rawValue: modemType) else {
            return ActivationModemType.unknown
        }
        return returnValue
    }
```

Вы используете внутреннюю переменную (`modemType`) для динамического определения перечисления в вычисляемом геттере, а затем возвращаете это значение перечисления.

### Enums can be used as types

Перечисления нужно использовать не только для операторов switch. Они вместе со связанными с ними значениями могут быть более похожими на сами объекты и структуры. Например, вот пример того, как структура, где один из ее типов является Enum.

```swift

import Foundation

struct ActivationResourcePackage {
    let headerImageName: String
    let list: [ListType]
}

enum ListType {
    case checkmark(header: String, subheader: String)
    case url(title: String, url: URL)
    case appDownload(title: String, subheader: String, buttonTitle: String, appUrl: URL)
}

extension ActivationResourcePackage {
    static var usRoboticsPackage = ActivationResourcePackage(headerImageName: "robot-pink", list: [
        ListType.checkmark(header: "Pat your head", subheader: "This helps the intertubes do their magic."),
        ])

    static var hayesPackage = ActivationResourcePackage(headerImageName: "robot-pink", list: [
        ListType.checkmark(header: "Rub your belly", subheader: "Getting hungry for that internet goodness!"),
        ListType.checkmark(header: "That's it!", subheader: "Don't forget to have a good day."),
        ])
}
```

Здесь вы сигнализируете, что я хочу, чтобы вы создали для меня объект на основе этого перечисления и всех связанных с ним данных. Это компактный способ отправки большого количества информации о состоянии и типе в одном пакете.

```swift
private func createPackage(for orderItem: OrderItem) -> ActivationResourcePackage {

    switch orderItem.activationModemType {
    case .usRobotics:
        return ActivationResourcePackage.usRoboticsPackage
    case .hayes:
        return ActivationResourcePackage.hayesPackage
    case .unknown:
        return ActivationResourcePackage.unKnowPackage
    }

}
```

Здесь мы создаем типобезопасный пакет, представляющий нашу конфигурацию на основе типа enum.

### Как преобразовать строку в перечисление

```swift
enum ActivationModemType: String {
    case hayes
    case usRobotics
    case unknown
}
let modem = ActivationModemType(rawValue: "usRobotics")
```

## Полезные ссылки

- [Apple Swift Docs](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html)
- [More Enum Examples](https://developerinsider.co/advanced-enum-enumerations-by-example-swift-programming-language/)


