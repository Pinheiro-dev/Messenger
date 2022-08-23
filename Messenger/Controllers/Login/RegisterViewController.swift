//
//  RegisterViewController.swift
//  Messenger
//
//  Created by mathues barbosa on 03/08/22.
//

import UIKit

class RegisterViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.clipsToBounds = true
        return view
    }()

    private lazy var photoImg: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person")
        image.tintColor = .gray
        image.contentMode = .scaleAspectFit
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.lightGray.cgColor
        image.layer.masksToBounds = true
        return image
    }()

    private lazy var firstNameField: UITextField = {
        let field = UITextField()
        field.keyboardType = .default
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.backgroundColor = .white
        field.textColor = .darkGray
        field.attributedPlaceholder = NSAttributedString(string: "First Name...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.7)])
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        return field
    }()

    private lazy var lastNameField: UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.backgroundColor = .white
        field.textColor = .darkGray
        field.attributedPlaceholder = NSAttributedString(string: "Last Name...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.7)])
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        return field
    }()

    private lazy var emailField: UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.backgroundColor = .white
        field.textColor = .darkGray
        field.attributedPlaceholder = NSAttributedString(string: "Email Address...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.7)])
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        return field
    }()


    private lazy var passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.backgroundColor = .white
        field.textColor = .darkGray
        field.attributedPlaceholder = NSAttributedString(string: "Password...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.7)])
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        return field
    }()

    private lazy var registerBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        view.backgroundColor = .white

//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
//                                                            style: .done,
//                                                            target: self,
//                                                            action: #selector(didTapRegister))

        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self

        photoImg.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
        photoImg.addGestureRecognizer(gesture)

        self.setupViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds

        let size = scrollView.width / 3
        photoImg.frame = CGRect(x: (scrollView.width - size) / 2,
                               y: 20,
                               width: size,
                               height: size)

        photoImg.layer.cornerRadius = photoImg.width / 2.0

        firstNameField.frame = CGRect(x: 30,
                                      y: photoImg.bottom + 10,
                                      width: scrollView.width-60,
                                      height: 52)

        lastNameField.frame = CGRect(x: 30,
                                     y: firstNameField.bottom + 10,
                                     width: scrollView.width-60,
                                     height: 52)

        emailField.frame = CGRect(x: 30,
                                  y: lastNameField.bottom + 10,
                                  width: scrollView.width-60,
                                  height: 52)

        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width-60,
                                     height: 52)

        registerBtn.frame = CGRect(x: 30,
                                y: passwordField.bottom + 10,
                                width: scrollView.width-60,
                                height: 52)
    }

    func setupViews() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(photoImg)
        self.scrollView.addSubview(firstNameField)
        self.scrollView.addSubview(lastNameField)
        self.scrollView.addSubview(emailField)
        self.scrollView.addSubview(passwordField)
        self.scrollView.addSubview(registerBtn)
    }

    @objc private func didTapChangeProfilePic() {
        presentPhotoActionSheet()
    }

    @objc private func loginButtonTapped() {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()

        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !firstName.isEmpty,
              !lastName.isEmpty,
              !email.isEmpty,
              !password.isEmpty, password.count >= 6 else {
            alertRegisterError()
            return
        }

        // Firebase Log In

    }

    func alertRegisterError() {
        let alert = UIAlertController(title: "Woops",
                                      message: "Please enter all information to create a new account.", preferredStyle: .alert)

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

extension RegisterViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameField {
            lastNameField.becomeFirstResponder()
        } else if textField ==  lastNameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            loginButtonTapped()
        }

        return true
    }

}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func presentPhotoActionSheet() {
        let actionSheet  = UIAlertController(title: "Profile Picutre",
                                             message: "How would you like to select a picture.",
                                             preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))

        present(actionSheet, animated: true)
    }

    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc,animated: true)
    }

    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc,animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }

        self.photoImg.image = selectedImage
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
