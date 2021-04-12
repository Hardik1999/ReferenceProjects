//
//  BaseVC.swift
//  PracticalTest
//
//  Created by Hardik on 8/1/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func showAlertMessage(title:String, msg:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            // self.onClickDone()
        }))
        self.present(alert, animated: true)
    }
    
    //Todo show alert for messsage only with click
    func showAlertMessageWithClick(title:String, msg:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            alert.dismiss(animated: true, completion: nil)
            self.onClickDone()
        }))
        
        
        self.present(alert, animated: true)
    }
    
    func onClickDone() {
        
    }
    //end
    
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func addKeyboardAccessory(textFields: [UITextField], dismissable: Bool = true, previousNextable: Bool = true) {
        for (index, textField) in textFields.enumerated() {
            let toolbar: UIToolbar = UIToolbar()
            toolbar.sizeToFit()

            var items = [UIBarButtonItem]()
            if previousNextable {
                let previousButton = UIBarButtonItem(image: UIImage(named: "up"), style: .plain, target: nil, action: nil)
                previousButton.width = 20
                if textField == textFields.first {
                    previousButton.isEnabled = false
                } else {
                    previousButton.target = textFields[index - 1]
                    previousButton.action = #selector(UITextField.becomeFirstResponder)
                }

                let nextButton = UIBarButtonItem(image: UIImage(named: "down"), style: .plain, target: nil, action: nil)
                nextButton.width = 20
                if textField == textFields.last {
                    nextButton.isEnabled = false
                } else {
                    nextButton.target = textFields[index + 1]
                    nextButton.action = #selector(UITextField.becomeFirstResponder)
                }
                items.append(contentsOf: [previousButton, nextButton])
            }

            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: view, action: #selector(UIView.endEditing))
            items.append(contentsOf: [spacer, doneButton])


            toolbar.setItems(items, animated: false)
            textField.inputAccessoryView = toolbar
        }
    }
    func doneButtonOnKeyboard(textField: [UITextField]){
        for item in textField{
            let kb = UIToolbar()
            kb.sizeToFit()
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneClickKeyboard))
            kb.items = [flexSpace,doneButton]
            item.inputAccessoryView = kb
        }
    }


    func doneButtonOnKeyboard(textField: UITextField){
        let kb = UIToolbar()
        kb.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneClickKeyboard))
        kb.items = [flexSpace,doneButton]
        textField.inputAccessoryView = kb
    }
    
    func doneButtonOnKeyboard(textField: UITextView){
        let kb = UIToolbar()
        kb.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneClickKeyboard))
        kb.items = [flexSpace,doneButton]
        textField.inputAccessoryView = kb
    }

    @objc func doneClickKeyboard(){
        view.endEditing(true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
