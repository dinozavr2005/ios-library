# Создание iOS приложения без сторибордов
1. Удаляем SceneDelegate
2. Удаляем Main.storyboard
3. Удаляем данные из info.plist, находим строчку**Application Scene Manifest** и удаляем ее
4. В настройках проекта в разделе TASRGETS переходим на вкладку "Build Settings" и в поиске пишем main, в появившемся списке удаляем **UIKit Main Storyboard File Base Name**
5. Редактируем файл **AppDelegate**, удаляем все содержимое и вставляем следующий код:
```swift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = ViewController()
        
        return true
    }
}
```
6. Переходим в файл **ViewController** будаляем все содержимое и вставляем следующий код:
```swift
import UIKit

class ViewController: UIViewController {
    
    let stackView = UIStackView()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension ViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    func layout() {
        stackView.addArrangedSubview(label)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
```

7. Запускаем симулятор и на экране проявляется наш шаблон, теперь мы полностью готовы начать создавать свое приложение