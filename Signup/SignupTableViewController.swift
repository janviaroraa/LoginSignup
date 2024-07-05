//
//  SignupTableViewController.swift
//  LoginSignup
//
//  Created by Janvi Arora on 04/07/24.
//

import UIKit

class SignupTableViewController: UITableViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        addImage()
    }

    @IBAction func loginTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func signupTapped(_ sender: Any) {
        validateAvatar()
        validateTextFields()
    }

    private func addImage() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(tapGestureRecognizer:)))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(gesture)
    }

    @objc
    private func imageViewTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        openGallery()
    }
}

extension SignupTableViewController {
    fileprivate func validateAvatar() {
        let defaultImage = UIImage(systemName: "person.crop.circle.badge.plus")
        if avatarImageView.image?.pngData() == defaultImage?.pngData() {
            openAlert(
                title: "Alert ⚠️",
                message: "Please select a profile image before proceeding",
                alertStyle: .alert,
                actionTitles: ["Okay"],
                actionStyles: [.default],
                actions: [{ _ in
                print("Alert for empty avatar image!")
            }])
        }
    }

    fileprivate func validateTextFields() {
        if let username = usernameTextField.text,
           let email = emailTextField.text,
           let password = passwordTextField.text,
           let confirmPassword = confirmPasswordTextField.text {
            if username.isEmpty {
                openAlert(
                    title: "Alert ⚠️",
                    message: "Username can't be left empty.",
                    alertStyle: .alert,
                    actionTitles: ["Okay"],
                    actionStyles: [.default],
                    actions: [{ _ in
                    print("Alert for empty username!")
                }])
            } else if email.isEmpty {
                openAlert(
                    title: "Alert ⚠️",
                    message: "Email address field can't be empty.",
                    alertStyle: .alert,
                    actionTitles: ["Okay"],
                    actionStyles: [.default],
                    actions: [{ _ in
                    print("Alert for email address!")
                }])
            } else if !email.isEmpty && !email.validateEmailId() {
                openAlert(
                    title: "Alert ⚠️",
                    message: "Email address not found.",
                    alertStyle: .alert,
                    actionTitles: ["Okay"],
                    actionStyles: [.default],
                    actions: [{ _ in
                    print("Alert for email address!")
                }])
            } else if password.isEmpty {
                openAlert(
                    title: "Alert ⚠️",
                    message: "Password field can't be empty.",
                    alertStyle: .alert,
                    actionTitles: ["Okay"],
                    actionStyles: [.default],
                    actions: [{ _ in
                    print("Alert for email address!")
                }])
            } else if !password.isEmpty && !password.validatePassword() {
                openAlert(
                    title: "Alert ⚠️",
                    message: """
                    Please enter valid password.
                    To make it a valid password:
                    1. Make sure to include minimum 8 characters.
                    2. Only letters and numbers are allowed.
                    3. No special characters can be used for your password.
                    """,
                    alertStyle: .alert,
                    actionTitles: ["Okay"],
                    actionStyles: [.default],
                    actions: [{ _ in
                    print("Alert for password!")
                }])
            } else if password != confirmPassword {
                openAlert(
                    title: "Alert ⚠️",
                    message: "Passwords don't match.",
                    alertStyle: .alert,
                    actionTitles: ["Okay"],
                    actionStyles: [.default],
                    actions: [{ _ in
                    print("Alert for non-matching passwords.")
                }])
            } else {
                // Navigation - Home Screen
                print("Successful Login!")
            }
        }
    }
}

extension SignupTableViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    fileprivate func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .savedPhotosAlbum
            present(picker, animated: true)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            avatarImageView.image = selectedImage
        }
        dismiss(animated: true)
    }
}
