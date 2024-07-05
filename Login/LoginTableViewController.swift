//
//  LoginTableViewController.swift
//  LoginSignup
//
//  Created by Janvi Arora on 03/07/24.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class LoginTableViewController: UITableViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var facebookButton: FBLoginButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        facebookLogin()
        googleLogin()
    }

    @IBAction func loginTapped(_ sender: Any) {
        validateTextFields()
    }

    @IBAction func googleButtonTapped(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self)
    }

    @IBAction func signupTapped(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupTableViewController") as? SignupTableViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    private func facebookLogin() {
        if let token = AccessToken.current,
           !token.isExpired {
            let request = FBSDKLoginKit.GraphRequest(
                graphPath: "me",
                parameters: ["fields": "email, name"],
                tokenString: token.tokenString,
                version: nil,
                httpMethod: .get
            )

            request.start { connection, result, error in
                if let result {
                    print(result)
                }
            }
        } else {
            facebookButton.permissions = ["public_profile", "email"]
            facebookButton.delegate = self
        }
    }

    private func googleLogin() {
//        GIDSignIn.sharedInstance.presentingViewController = self
//        GIDSignIn.sharedInstance.delegate = self

        if GIDSignIn.sharedInstance.hasPreviousSignIn(){
            GIDSignIn.sharedInstance.restorePreviousSignIn()
            print("Already Login")
        }
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

extension LoginTableViewController: LoginButtonDelegate {

    func loginButton(_ loginButton: FBSDKLoginKit.FBLoginButton, didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?, error: (any Error)?) {
        if let token = result?.token?.tokenString {
            let request = FBSDKLoginKit.GraphRequest(
                graphPath: "me",
                parameters: ["fields": "email, name"],
                tokenString: token,
                version: nil,
                httpMethod: .get
            )

            request.start { connection, result, error in
                if let result {
                    print(result)
                }
            }
        } else {
            facebookButton.permissions = ["public_profile", "email"]
            facebookButton.delegate = self
        }


    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        print("Logged out!")
    }
}

extension LoginTableViewController {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("\(user.profile?.email ?? "No Email")")
    }
}
