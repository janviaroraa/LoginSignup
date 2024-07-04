//
//  LoginTableViewController.swift
//  LoginSignup
//
//  Created by Janvi Arora on 03/07/24.
//

import UIKit

class LoginTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

//    /// To make the entire content int he center (especially for iPad)
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        let tableViewHeight = self.tableView.frame.height
//        let contentHeight = self.tableView.contentSize.height
//
//        let centeringInset = (tableViewHeight - contentHeight) / 2.0
//        let topInset = max(centeringInset, 0.0)
//
//        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
//    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.height
    }

}
