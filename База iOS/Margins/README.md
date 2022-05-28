# Margins

## No Margins

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Margins/images/no-margins.png" alt="drawing" width="400"/>

```swift


import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello"
        label.backgroundColor = .green

        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(label)

        view.addSubview(stack)

	// constraints
        stack.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo:view.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo:view.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }

}
```
## safeAreaLayoutGuide



```swift
        let margins = view.safeAreaLayoutGuide
        stack.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Margins/images/safe.png" alt="drawing" width="400"/>

```swift

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello"
        label.backgroundColor = .green

        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(label)

        view.addSubview(stack)

        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 100, leading: 8, bottom: 100, trailing: 8) // iOS 11

        let margins = view.safeAreaLayoutGuide

        stack.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }

}
```

Я полагаю, что Apple сейчас рекомендует делать все через `view.directionalLayoutMargins`. Так что даже не используйте `view.layoutMargins` и не ссылайтесь на них. Просто установите и работайте с отступами по направлению в вашем view.

## Layout & Directional margins

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Margins/images/directional-margin.png" alt="drawing" width="400"/>

Свойство layoutMargins устарело в iOS 11 и заменено на directionalLayoutMargins, чтобы учесть текущее направление языка. Мы по-прежнему используем `layoutMarginsGuide` при стилизации, но мы устанавливаем его через `directionalLayoutMargins`, который переводит `CGFloats` в правильные якоря под капотом.

```swift

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello"
        label.backgroundColor = .green

        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(label)

        view.addSubview(stack)

        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 100, leading: 8, bottom: 100, trailing: 8) // iOS 11

        let margins = view.layoutMarginsGuide

        stack.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }

}

```

## Summary

Так что делайте все через `topAnchor`, `leadingAnchor`, `trailingAnchor`, `bottomAnchor`. Просто измените используемое руководство по макету (`layoutMarginsGuide` или `safeAreaLayoutGuide` и настройте его с помощью `directionalLayoutMargins`.

```swift

        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 100, leading: 8, bottom: 100, trailing: 8) // iOS 11
	
	let margins = view.safeAreaLayoutGuide
        let margins = view.layoutMarginsGuide

        stack.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
```

Также не забудьте защитить себя от версий, отличных от iOS 11.

```swift
	if #available(iOS 11, *) {
	    imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
	} else {
	    imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
	}
```

### Links that help

* [Apple layout margins](https://developer.apple.com/documentation/uikit/uiview/1622566-layoutmargins)
* [Apple directionalLayoutMargins](https://developer.apple.com/documentation/uikit/uiview/2865930-directionallayoutmargins)
* [Apple safe area](https://developer.apple.com/documentation/uikit/uiview/positioning_content_relative_to_the_safe_area?language=objc)
* [Use your load safe area guide](https://useyourloaf.com/blog/safe-area-layout-guide/)







