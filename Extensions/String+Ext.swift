//
//  String+Ext.swift
//  LoginSignup
//
//  Created by Janvi Arora on 04/07/24.
//

import Foundation

extension String {

    func validateEmailId() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return applyPredicateOnRegex(regexStr: emailRegEx)
    }

    func validatePassword(mini: Int = 8, max: Int = 8) -> Bool {
        //Minimum 8 characters at least 1 Alphabet and 1 Number:
        var passRegEx = ""
        if mini >= max {
            passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(mini),}$"
        } else {
            passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(mini),\(max)}$"
        }
        return applyPredicateOnRegex(regexStr: passRegEx)
    }

    func applyPredicateOnRegex(regexStr: String) -> Bool{
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", regexStr)
        let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
        return isValidateOtherString
    }
}
