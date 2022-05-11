# Dynamic Font

С помощью Dynamic Font(`UIFontTextStyle`) Apple обеспечивает хороший внешний вид своих шрифтов (даже когда люди изменяют размер своих устройств для доступности)

Просто испоользуйте предпочитаемый шрифт, и установите `adjustsFontForContentSizeCategory = true`, и вам никогда не придется переживать о размере шрифта, iOS сделает это за вас.

```swift
label.font = UIFont.preferredFont(forTextStyle: .body)
label.adjustsFontForContentSizeCategory = true
```


<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/DynamicFont/images/preferred-font-sizes.png" alt="drawing" width="400"/>

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/DynamicFont/images/sizes.png" alt="drawing" width="800"/>


Пока вы придерживаетесь `UIFontTextStyle`, ваше приложение будет соответствующим образом изменять размер своих шрифтов. Преимущества здесь не просто аскетичны. Они  также служат общепринятым языком дизайнеров. Поэтому, когда вы ставите «Title1», все поймут, что вы имеете в виду, и вам больше не придется жестко задавать размеры шрифта.

## Source

```swift
import UIKit

class ViewController: UIViewController {

    func makeLabel(_ title: String, _ font: UIFont) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.font = font

        return label
    }

    func makeStackView() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .center

        return stack
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let stackView = makeStackView()

        view.addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200).isActive = true

        let largeTitle = makeLabel("Large Title", UIFont.preferredFont(forTextStyle: .largeTitle))
        let title1 = makeLabel("Title1", UIFont.preferredFont(forTextStyle: .title1))
        let title2 = makeLabel("Title2", UIFont.preferredFont(forTextStyle: .title2))
        let title3 = makeLabel("Title3", UIFont.preferredFont(forTextStyle: .title3))
        let headline = makeLabel("Headline", UIFont.preferredFont(forTextStyle: .headline))
        let subheadline = makeLabel("Subheadline", UIFont.preferredFont(forTextStyle: .subheadline))
        let body = makeLabel("Body", UIFont.preferredFont(forTextStyle: .body))
        let callout = makeLabel("Callout", UIFont.preferredFont(forTextStyle: .callout))
        let footnote = makeLabel("Footnote", UIFont.preferredFont(forTextStyle: .footnote))
        let caption1 = makeLabel("Caption1", UIFont.preferredFont(forTextStyle: .caption1))
        let caption2 = makeLabel("Caption2", UIFont.preferredFont(forTextStyle: .caption2))

        stackView.addArrangedSubview(largeTitle)
        stackView.addArrangedSubview(title1)
        stackView.addArrangedSubview(title2)
        stackView.addArrangedSubview(title3)
        stackView.addArrangedSubview(headline)
        stackView.addArrangedSubview(subheadline)
        stackView.addArrangedSubview(body)
        stackView.addArrangedSubview(callout)
        stackView.addArrangedSubview(footnote)
        stackView.addArrangedSubview(caption1)
        stackView.addArrangedSubview(caption2)
    }

}
```

## Accessibility

Для того чтобы увидеть в действии, измените парметры device/simulator accessibility на что-нибудь побольше.

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/DynamicFont/images/demo.gif)

Затем вы можете увидеть, как ваше приложение будет выглядеть до и после.

#### Before

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/DynamicFont/images/before.png" alt="drawing" width="400"/>

#### After

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/DynamicFont/images/after.png" alt="drawing" width="400"/>

## Styling Preferred Fonts

вы можете стилизовать шрифт с помощью `UIFontDescriptor.SymbolicTraits`.

### Как сделать шрифт жирным

```swift

extension UIFont {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
}

let boldFont = UIFont.preferredFont(forTextStyle: .footnote).withTraits(traits: [.traitBold])
percentOfDataLimitReachedLabel.font = boldFont
percentOfDataLimitReachedLabel.adjustsFontForContentSizeCategory = true
```

### Другие парметры

```swift
public static var traitItalic: UIFontDescriptor.SymbolicTraits { get }
public static var traitBold: UIFontDescriptor.SymbolicTraits { get }
public static var traitExpanded: UIFontDescriptor.SymbolicTraits { get }
public static var traitCondensed: UIFontDescriptor.SymbolicTraits { get }
public static var traitMonoSpace: UIFontDescriptor.SymbolicTraits { get }
public static var traitVertical: UIFontDescriptor.SymbolicTraits { get }
public static var traitUIOptimized: UIFontDescriptor.SymbolicTraits { get }
public static var traitTightLeading: UIFontDescriptor.SymbolicTraits { get }
public static var traitLooseLeading: UIFontDescriptor.SymbolicTraits { get }
 ```
 
 ### Как изменить размер пользовательского шрифта с помощью **UIFontMetrics**
 
 ```swift
if let font = UIFont(name: "Helvetica", size: 72) {
    let fontMetrics = UIFontMetrics(forTextStyle: .headline)
    label.font = fontMetrics.scaledFont(for: font)
}
 ```

### Полезные ссылки

- [Apple UIFontTextStyle](https://developer.apple.com/documentation/uikit/uifonttextstyle)
- [Bold preferredFont](https://spin.atomicobject.com/2018/02/02/swift-scaled-font-bold-italic/)
- [Paul Hudson Scaled Font](https://www.hackingwithswift.com/example-code/uikit/how-to-resize-a-custom-font-using-uifontmetrics)
