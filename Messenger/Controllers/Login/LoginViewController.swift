//
//  LoginViewController.swift
//  Messenger
//
//  Created by mathues barbosa on 03/08/22.
//

import UIKit

class LoginViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.clipsToBounds = true
        return view
    }()

    private let logoImg: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.init(named: "logo")
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let emailField: UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.backgroundColor = .white
        field.placeholder = "Email Address..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        return field
    }()

    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.backgroundColor = .white
        field.placeholder = "Password..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        return field
    }()

    private lazy var loginBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log In"
        view.backgroundColor = .white

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))

        emailField.delegate = self
        passwordField.delegate = self

        self.setupViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds

        let size = scrollView.width / 3
        logoImg.frame = CGRect(x: (scrollView.width - size) / 2,
                               y: 20,
                               width: size,
                               height: size)

        emailField.frame = CGRect(x: 30,
                                  y: logoImg.bottom + 10,
                                  width: scrollView.width-60,
                                  height: 52)

        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width-60,
                                     height: 52)

        loginBtn.frame = CGRect(x: 30,
                                y: passwordField.bottom + 10,
                                width: scrollView.width-60,
                                height: 52)
    }

    func setupViews() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(logoImg)
        self.scrollView.addSubview(emailField)
        self.scrollView.addSubview(passwordField)
        self.scrollView.addSubview(loginBtn)
    }

    @objc private func loginButtonTapped() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()

        guard let email = emailField.text, let password = passwordField.text,
              !email.isEmpty, !password.isEmpty, password.count >= 6 else {
                alertLoginError()
                return
        }

        // Firebase Log In

    }

    func alertLoginError() {
        let alert = UIAlertController(title: "Woops",
                                      message: "Please enter all information to log in.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel, handler: nil))

        present(alert, animated: true)
    }

    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            loginButtonTapped()
        }

        return true
    }

}