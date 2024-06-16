import UIKit

class LoginController: UIViewController {
    
    // 학번 입력 필드 설정
    let studentIDTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "학번"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // 학교 입력 필드 설정
    let schoolTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "학교"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // 비밀번호 입력 필드 설정
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // 로그인 버튼 설정
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // UI 요소들 추가 및 레이아웃 설정
        let stackView = UIStackView(arrangedSubviews: [schoolTextField, studentIDTextField, passwordTextField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        // 제약조건 설정
        NSLayoutConstraint.activate([
            schoolTextField.heightAnchor.constraint(equalToConstant: 40),
            studentIDTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    @objc func handleLogin() {
        // 로그인 버튼 액션 메서드
        print("로그인 버튼이 눌렸습니다")
        
        // 로그인 성공 메시지 표시
        let alert = UIAlertController(title: "로그인 성공", message: "로그인에 성공하셨습니다!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
