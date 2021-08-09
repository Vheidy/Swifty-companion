//
//  ErrorHandler.swift
//  42Users
//
//  Created by Полина Салюкова on 06.08.2021.
//

import UIKit

struct ErrorHandler {
    static func showAlert(for error: APIError, on vc: UIViewController) {
        let agreeAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        let message = messageForError(error)
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(agreeAction)
        vc.present(alert, animated: true, completion: nil)
    }

    static func createActionShowAlert(on vc: UIViewController) -> (APIError) -> () {
        return { error in
            let agreeAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            let message = messageForError(error)
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(agreeAction)
            vc.present(alert, animated: true, completion: nil)
        }
    }

    private static func messageForError(_ error: APIError) -> String {
        switch error {
        case .unknownName:
            return "You entered the wrong nickname. Enter short nickname without others symbols"
        default:
            return "Something is wrong. Try again later"
        }
    }
}
