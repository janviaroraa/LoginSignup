//
//  LoginTableViewController.swift
//  LoginSignup
//
//  Created by Janvi Arora on 03/07/24.
//

import UIKit

class LoginTableViewController: UITableViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }

    @IBAction func loginTapped(_ sender: Any) {
        validateTextFields()
    }

}

extension LoginTableViewController {
    fileprivate func validateTextFields() {
        if let email = emailTextField.text,
            let password = passwordTextField.text {
            if email.isEmpty {
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
            } else {
                // Navigation - Home Screen
                print("Successful Login!")
            }
        }
    }
}

extension LoginTableViewController {
    /// To make the entire content int he center (especially for iPad)
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tableViewHeight = self.tableView.frame.height
        let contentHeight = self.tableView.contentSize.height

        let centeringInset = (tableViewHeight - contentHeight) / 2.0
        let topInset = max(centeringInset, 0.0)

        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.height
    }
}
