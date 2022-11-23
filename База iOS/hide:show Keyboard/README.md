# Hide/Show Keyboard

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyBoard()
    }
}

extension ViewController {
    private func setupKeyBoard() {
        addKeyboardObserver(
            willShow: #selector(keyboardWillShow),
            willHide: #selector(keyboardWillHide)
        )
        hideKeyboardWhenTappedAround()
    }
    // MARK: - Helpers
        @objc private func keyboardWillShow(notification:NSNotification){
            if let userInfo = notification.userInfo {
                view.layoutIfNeeded()
                let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
                UIView.animate(withDuration: 0.2, animations: { [weak self] in
                    guard let self = self else { return }
                    self.view.frame.origin.y = -(keyboardFrame.size.height - self.view.safeAreaBottom)
                    self.view.layoutIfNeeded()
                }, completion: { finish in
                    guard finish else {
                        return
                    }
                })
            }
        }

        @objc private func keyboardWillHide(notification:NSNotification){
            view.layoutIfNeeded()
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let self = self else { return }
                self.view.frame.origin.y = .zero
                self.view.layoutIfNeeded()
            }
        }
}

```



