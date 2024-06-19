import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate{
    
    var essentialFieldList = [UITextField] () // 필수입력항목 설정
    
    @IBOutlet weak var SignUpEmailText: UITextField!
    @IBOutlet weak var SignUpNickNameText: UITextField!
    @IBOutlet weak var SignUpPasswordText: UITextField!
    @IBOutlet weak var pwdLabel: UILabel!
    @IBOutlet weak var SignUpProfileSwitch: UISwitch!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var SignUpPasswordCheckText: UITextField!
    
    private var toggleVaild: Bool = false
    private var isValidId: Bool = false
    private var isValidPwd: Bool = false
    
    private var isValid: Bool {
        return isValidId && isValidPwd
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        essentialFieldList = [SignUpEmailText, SignUpNickNameText, SignUpPasswordText, SignUpPasswordCheckText] // 필수입력 리스트
        
        setupUI()
        setupGesture()
        
        SignUpPasswordText.delegate = self
    }
    
    private func validationPwd(pwd: String) -> Bool{
        return pwd.count >= 8
    }
    
    private func setupUI() {
        SignUpEmailText.attributedPlaceholder = NSAttributedString(
            string: "형식에 맞게 작성해주세요",
            attributes:[.foregroundColor: UIColor.lightGray,
                        .font: UIFont.systemFont(ofSize: 12)])
        
        
        SignUpNickNameText.attributedPlaceholder = NSAttributedString(
            string: "4~10자 영어, 숫자로 입력해 주세요",
            attributes:[.foregroundColor: UIColor.lightGray,
                        .font: UIFont.systemFont(ofSize: 12)])
        
        SignUpPasswordText.attributedPlaceholder = NSAttributedString(
            string: "영어, 숫자, 특수문자 포함 8~20자",
            attributes:[.foregroundColor: UIColor.lightGray,
                        .font: UIFont.systemFont(ofSize: 12)])
        
        SignUpPasswordCheckText.attributedPlaceholder = NSAttributedString(
            string: "비밀번호 확인",
            attributes:[.foregroundColor: UIColor.lightGray,
                        .font: UIFont.systemFont(ofSize: 12)])
        
        SignUpPasswordText.isSecureTextEntry = true
        SignUpPasswordCheckText.isSecureTextEntry = true
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = NSString(string: textField.text ?? "")
        let finalText = currentText.replacingCharacters(in: range, with: string)
        switch textField {
        case SignUpPasswordText:
            isValidPwd = validationPwd(pwd: finalText)
            if isValidPwd {
                pwdLabel.text = ""
                SignUpPasswordText.textColor = UIColor.black
            }else{
                pwdLabel.text = Text.pwdError
                pwdLabel.textColor = Colors.error
            }
            
            default: break        }
        return true
    }
    
    struct Text {
        static let pwdError = "비밀번호는 8자 이상이어야 합니다."
    }
    
    struct Colors {
        static let error = UIColor.red
    }
    
    
    //dismissKeyboard 재스처 추가
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func switchValue(_ sender: UISwitch) {
        if sender.isOn{
            toggleVaild = true
        } else {
            toggleVaild = false
        }
    }
    
    @IBAction func SignUpButton(_ sender: Any) {
        var isAllfieldsFilled = true
        
        for field in essentialFieldList {
            if !isFilled(field){
                signUpAlert(field)
                isAllfieldsFilled = false
                break
            }
        }
        
        guard isAllfieldsFilled else {
            return
        }
        
        guard let password = SignUpPasswordText.text,
              let passwordCheck = SignUpPasswordCheckText.text,
                password == passwordCheck else {
            passwordAlert(title: "비밀번호가 일치하지 않습니다.")
            return
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    func signUpAlert(_ field: UITextField) {
        DispatchQueue.main.async {
            var title = ""
            switch field {
            case self.SignUpEmailText:
                title = "이메일을 입력해주세요."
            case self.SignUpPasswordText:
                title = "비밀번호를 입력해주세요."
            case self.SignUpPasswordCheckText:
                title = "비밀번호를 확인해주세요."
            case self.SignUpNickNameText:
                title = "닉네임을 입력해주세요."
            default:
                title = "Error"
            }
            let controller = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "닫기", style: .cancel) { (action) in
                
            }
            
            controller.addAction(cancelAction)
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func passwordAlert(title: String) {
        DispatchQueue.main.async {
            let controller = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "닫기", style: .cancel) { (action) in
            }
            
            controller.addAction(cancelAction)
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func isFilled(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            return false
        }
        return true
    }
}
