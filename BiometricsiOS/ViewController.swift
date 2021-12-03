import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizeButton()
    }
    
    func authorizeButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 110, height: 50))
        view.addSubview(button)
        button.center = view.center
        button.setTitle("Authenticate", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate using touch id"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] (success, error) in
                guard success, error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    let vc = UIViewController()
                    vc.title = "Welcome"
                    vc.view.backgroundColor = .blue
                    self?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
                }
            }
        } else {
            let alert = UIAlertController(title: "Failed to authenticate", message: "Canot use this feature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
}

