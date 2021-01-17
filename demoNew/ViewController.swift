//
//  ViewController.swift
//  demoNew
//
//  Created by Дмитрий on 16.01.2021.
//

import UIKit

class ViewController: UIViewController {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    let containerView: UIView = {
        let containerView = UIView()
        containerView.toAutoLayout()
        return containerView
    }()
    
    let login: UITextField = {
        let login = UITextField()
        login.textColor = .black
        //login.toAutoLayout()
        login.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        login.autocapitalizationType = .none
        login.tintColor = .blue
        login.layer.borderWidth = 0.5
        login.addInternalPaddings(left: 10, right: 10)
        login.placeholder = "Email or phone"
        return login
    }()
    
    let password: UITextField = {
        let password = UITextField()
        password.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        password.autocapitalizationType = .none
        password.tintColor = .blue
        password.textColor = .black
        //password.isSecureTextEntry = true
        //password.toAutoLayout()
        password.addInternalPaddings(left: 10, right: 10)
        password.placeholder = "Password"
        return password
    }()
    
    let logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.clipsToBounds = true
        logo.backgroundColor = .white
        logo.toAutoLayout()
        return logo
    }()
    
    let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        //button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel")?.alpha(0.99), for: .selected)
        button.setBackgroundImage(UIImage(named: "blue_pixel")?.alpha(0.99), for: .highlighted)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.darkGray, for: .selected)
        button.setTitleColor(.darkGray, for: .highlighted)
        button.layer.masksToBounds = true
        button.toAutoLayout()
        //button.addTarget(self, action: #selector(buyButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var stackLogPas: UIStackView = {
        let stackLogPas = UIStackView()
        stackLogPas.addArrangedSubview(login)
        stackLogPas.addArrangedSubview(password)
        stackLogPas.alignment = .fill
        stackLogPas.distribution = .fillEqually
        stackLogPas.axis = .vertical
        stackLogPas.spacing = 10
        stackLogPas.layer.cornerRadius = 10
        stackLogPas.layer.borderWidth = 0.5
        stackLogPas.layer.masksToBounds = true
        stackLogPas.backgroundColor = .systemGray6
        stackLogPas.spacing = 0
        stackLogPas.toAutoLayout()
        return stackLogPas
    }()

   lazy var constraints = [
    scrollView.topAnchor.constraint(equalTo: view.topAnchor),
    scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    
    containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
    containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
    containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
    containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
    containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
    
    logo.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 120),
    logo.widthAnchor.constraint(equalToConstant: 100),
    logo.heightAnchor.constraint(equalToConstant: 100),
    logo.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

    stackLogPas.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 120),
    stackLogPas.heightAnchor.constraint(equalToConstant: 100),
    stackLogPas.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
    stackLogPas.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
    
    logInButton.topAnchor.constraint(equalTo: stackLogPas.bottomAnchor, constant: 16),
    logInButton.heightAnchor.constraint(equalToConstant: 50),
    logInButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
    logInButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
   ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(scrollView)
        scrollView.addSubviews(containerView)
        containerView.addSubviews(logo, stackLogPas, logInButton)
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: Keyboard observers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: Keyboard actions
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
}

extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}

extension UITextField {
    func addInternalPaddings(left: CGFloat, right: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: left, height: self.frame.height))
        self.rightView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: right, height: self.frame.height))
        self.leftViewMode = .always
        self.rightViewMode = .always
    }
}

extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

//extension ViewController: UITextFieldDelegate {
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        //Check if there is any other text-field in the view whose tag is +1 greater than the current text-field on which the return key was pressed. If yes → then move the cursor to that next text-field. If No → Dismiss the keyboard
//        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
//            nextField.becomeFirstResponder()
//        } else {
//            textField.resignFirstResponder()
//        }
//        return false
//    }
//}
