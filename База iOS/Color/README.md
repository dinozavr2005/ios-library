# Color

## System Colors

iOS имеет ряд системных цветов, которые автоматически адаптируются к яркости и изменениям в настройках специальных возможностей, таких как «Увеличить контрастность» и «Уменьшить прозрачность». Системные цвета отлично смотрятся по отдельности и в сочетании, как на светлом, так и на темном фоне, как в подобном, так и в темном режимах.


<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Color/images/system-colors.png" alt="drawing" width="600"/>

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Color/images/system-grays.png" alt="drawing" width="600"/>


## Dynamic System Colors

Apple также имеет семантически определенные системные цвета для использования в фоновых областях, содержимом переднего плана и собственных элементах управления, таких как метки, разделители и заливка. Они автоматически адаптируются как к темным, так и к темным режимам пользовательского интерфейса.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Color/images/dynamic-colors.png" alt="drawing" width="600"/>

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Color/images/dynamic-system-color-both.png" alt="drawing" width="800"/>

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Color/images/dynamic-stystem-background-example.png" alt="drawing" width="800"/>

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Color/images/dynamic-system-grouped-background-example.png" alt="drawing" width="800"/>

## Programatic Color

```swift
extension UIColor {
    static let darkBlue = UIColor(red: 10/255, green: 132/255, blue: 255/255, alpha: 1)
}
```

Но также дайте цвету имя похожее на то, что он из себя представляет

```swift
public extension UIColor {
    static var downloadColor: UIColor {
        return .shawSkyBlue
    }

    static var uploadColor: UIColor {
        return .shawTertiaryYellow
    }
}
```

### Полезные ссылки

- [HIG Color](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/)
- [Apple UI Element Colors](https://developer.apple.com/documentation/uikit/uicolor/ui_element_colors)
- [Apple Design Resources](https://developer.apple.com/design/resources/)
- [WWDC What's new in iOS](https://developer.apple.com/videos/play/wwdc2019/808/)
