//
//  SignupContinuedViewController.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/4/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import UIKit

class SignupContinuedViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var fNameField: UITextField!
    @IBOutlet weak var lNameField: UITextField!
    @IBOutlet weak var sexField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var smokeField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var formBackgroundView: UIView!
    
    var username: String?
    var password: String?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegates()

        
        //end editing when tapping anywhere
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboardFromTap")
        view.addGestureRecognizer(tap)
    }
    
    
    //GESTURE RECOGNIZER METHODS
    func dismissKeyboardFromTap(){
        view.endEditing(true)
    }
    
    
    
    //SET UP METHODS
    func setUpDelegates(){
        fNameField.delegate = self
        lNameField.delegate = self
        sexField.delegate = self
        weightField.delegate = self
        heightField.delegate = self
        dobField.delegate = self
        smokeField.delegate = self
        emailField.delegate = self
    }

    

    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case fNameField:
            break
        case lNameField:
            break
        case sexField:
            //formBackgroundView.frame.origin.y -= 20
            break
        case weightField:
            //formBackgroundView.frame.origin.y -= 20
            break
        case heightField:
            UIView.animate(withDuration: 0.2, animations: {
                self.view.frame.origin.y -= 30
            })
            //formBackgroundView.frame.origin.y -= 20
            break
        case dobField:
            UIView.animate(withDuration: 0.2, animations: {
                self.view.frame.origin.y -= 30
                //self.formBackgroundView.frame.origin.y -= 30
            })
            //formBackgroundView.frame.origin.y -= 20
            break
        case emailField:
            UIView.animate(withDuration: 0.2, animations: {
                self.view.frame.origin.y -= 30
                //self.formBackgroundView.frame.origin.y -= 30
            })
            //formBackgroundView.frame.origin.y -= 20
            break
        case smokeField:
            UIView.animate(withDuration: 0.2, animations: {
                self.view.frame.origin.y -= 30
                //self.formBackgroundView.frame.origin.y -= 30
            })
            //formBackgroundView.frame.origin.y -= 20
            break
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case smokeField:
            smokeField.resignFirstResponder()
            self.view.endEditing(true)
            return false
            break
        case fNameField:
            lNameField.becomeFirstResponder()
            break
        case lNameField:
            sexField.becomeFirstResponder()
            break
        case sexField:
            weightField.becomeFirstResponder()
            break
        case weightField:
            heightField.becomeFirstResponder()
            break
        case heightField:
            dobField.becomeFirstResponder()
            break
        case dobField:
            emailField.becomeFirstResponder()
            break
        case emailField:
            smokeField.becomeFirstResponder()
            break
        default:
            break
        }
        return true
    }
    
    
    @IBAction func didPressBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didPressFinishButton() {
        
        
        
        if let nav = self.navigationController as? LoginNavigationController {
            nav.dataHandler?.createUser(with: fNameField.text!, lname: lNameField.text!, sex: sexField.text!, weight: weightField.text!, height: heightField.text!, dob: dobField.text!, smoke: smokeField.text!, username: username!, password: password!, email: emailField.text!)
            UserDefaults.standard.set(1, forKey: "userStatus")
            nav.dismiss(animated: true, completion: nil)
        }
        
        
        
        //self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
