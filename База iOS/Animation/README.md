# Анимация

## Property Animations

![](images/old-new.gif)

_UIView.animate_ еще работает, но Свифт советует новый метод -  Property animators.

**Старый вид**

```swift
UIView.animate(withDuration: 0.75) { [unowned self] in
    self.heightConstraint?.constant = 270
    self.layoutIfNeeded()
}

UIView.animate(withDuration: 0.25, delay: 0.5, options: [], animations: {
    self.starRewardsView.isHidden = false
    self.starRewardsView.alpha = 1
}) { (finished) in

}
```

**Новый**

```swift
let animator1 = UIViewPropertyAnimator(duration: 0.75, curve: .easeInOut) {
    self.heightConstraint?.constant = 270
    self.layoutIfNeeded()
}
animator1.startAnimation()

let animator2 = UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut) {
    self.starRewardsView.isHidden = false
    self.starRewardsView.alpha = 1
}
animator2.startAnimation(afterDelay: 0.5)
```

## Анимация высоты

Чтобы анимировать вещи, вам нужно изменить константу констрейнта. В этом примере мы можем настроить высоту. Обратите внимание, что нам нужно вызвать `layoutIfNeeded()`, тогда как в _Stack View_, мы этого не делаем.

![](images/height.gif)

```swift
import UIKit

class ViewController: UIViewController {

    let redView = UIView()
    let blueView = UIView()
    let button = UIButton()
    
    var heightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    func layout() {
    	...
        heightConstraint = redView.heightAnchor.constraint(equalToConstant: 100)
        ...
    }
    
    @objc func toggleTapped() {
        if heightConstraint?.constant == 0 {
            UIView.animate(withDuration: 0.75) { [unowned self] in
                self.heightConstraint?.constant = 100
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.75) { [unowned self] in
                self.heightConstraint?.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
}
```


## Анимация внутри Stack View

StackView анимирует ваше содержимое, когда вы меняете его видимость и alpha.

![](images/stackView.gif)

```swift
func layout() {
    stackView.addArrangedSubview(label)
    
    view.addSubview(stackView)
    view.addSubview(button)
    
    ...
}
    
@objc func toggleTapped() {
    UIView.animate(withDuration: 0.75) { [unowned self] in
        self.label.isHidden = !self.label.isHidden
        self.label.alpha = self.label.isHidden ? 0 : 1
    }
}
```

Если вы хотите сцепить или расположить анимацию в шахматном порядке, вы также можете сделать это следующим образом:

```swift
private func toggleHiddenElements() {
    let duration1 = 0.4
    let duration2 = 0.2

    let animatables = [bullet6Label, bullet7Label, bullet8Label, bullet9Label]
    _ = animatables.map { $0?.alpha = 0 }

    let animatation1 = UIViewPropertyAnimator(duration: duration1, curve: .easeInOut) { [self] in
        _ = animatables.map { $0?.isHidden = !showAll }
    }

    animatation1.addCompletion { position in
        if position == .end {
            let animatation2 = UIViewPropertyAnimator(duration: duration2, curve: .easeInOut) {
                _ = animatables.map { $0?.alpha = 1 }
            }
            animatation2.startAnimation()
        }
    }
    animatation1.startAnimation()
}
```



## Анимируем с помощью alpha

Вот два способа анимировать некоторые элементы управления, когда пользователь касается строки `UITableView`.

![](images/games-demo.gif)

```swift
UIView.animate(withDuration: 3) {
    self.profileImage.image = UIImage(named: game.imageName)
    self.titleLabel.text = game.name
    self.bodyLabel.text = game.description

    self.profileImage.alpha = 1
    self.titleLabel.alpha = 1
    self.bodyLabel.alpha = 1

    self.view.layoutIfNeeded()
}

UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 3, delay: 0, options: [], animations: {
    self.profileImage.image = UIImage(named: game.imageName)
    self.titleLabel.text = game.name
    self.bodyLabel.text = game.description

    self.profileImage.alpha = 1
    self.titleLabel.alpha = 1
    self.bodyLabel.alpha = 1
})
```

### Полезные ссылки

- [Quick Guide To Property Animators](https://useyourloaf.com/blog/quick-guide-to-property-animators/)
