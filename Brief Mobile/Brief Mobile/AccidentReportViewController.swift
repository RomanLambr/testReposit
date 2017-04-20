//
//  AccidentReportViewController.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/19/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import UIKit

class AccidentReportViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {

    let picker = UIImagePickerController()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var carRegTextField: UITextField!
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var isAgreeSwitch: UISwitch!
    @IBOutlet weak var conformButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        conformButton.layer.cornerRadius = conformButton.bounds.height / 2
        // Do any additional setup after loading the view.
    }
    
    //MARK: Private Validation
    
    private func isValidTelephone(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let localNumberMaxLengs = 7
        let areaNumberMaxLengs = 3
        let countryNumberMaxLengs = 3
        
        let setValidation = CharacterSet.decimalDigits.inverted
        let array = string.components(separatedBy: setValidation)
        
        if array.count > 1{
            return false
        }
        
        var newText = (textField.text as NSString?)!.replacingCharacters(in: range, with: string)
        let component = newText.components(separatedBy: setValidation)
        newText = component.joined()
        
        guard newText.characters.count <= areaNumberMaxLengs + countryNumberMaxLengs + localNumberMaxLengs else{
            return false
        }
        
        var resultText = ""
        
        /*+XX (XXX) XXX - XX - XX*/
        
        let localNumber = min(localNumberMaxLengs, newText.characters.count)
        
        if localNumber>0{
            let strNumber = newText.substring(from: newText.characters.count - localNumber )
            // let strNumber = newText.substring(from: newText.index(newText.startIndex, offsetBy: newText.characters.count - localNumber ))
            
            resultText = strNumber
            if resultText.characters.count > 3{
                resultText.insert("-", at: resultText.index(resultText.startIndex, offsetBy: 3))
            }
            if resultText.characters.count > 6{
                resultText.insert("-", at: resultText.index(resultText.startIndex, offsetBy: 6))
            }
        }
        
        if newText.characters.count > localNumberMaxLengs{
            let areaLengs = min(areaNumberMaxLengs, newText.characters.count - localNumberMaxLengs )
            
            var arreaStr = newText.substring(from: newText.characters.count - localNumberMaxLengs - areaLengs, length: areaLengs)
            
            arreaStr = "(" + arreaStr + ") "
            
            resultText = arreaStr + resultText
        }
        
        if newText.characters.count > localNumberMaxLengs + areaNumberMaxLengs{
            let countryLengs = min(countryNumberMaxLengs, newText.characters.count - localNumberMaxLengs - areaNumberMaxLengs )
            
            var countryStr = newText.substring(from: newText.characters.count - localNumberMaxLengs - areaNumberMaxLengs - countryLengs , length: countryLengs)
            
            countryStr = "+\(countryStr)"
            
            resultText = countryStr + resultText
        }
        
        textField.text = resultText
        return false
        
        
    }
    
    private func isValidName(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)->Bool{
        
        let lengthName = 20
        let setValid = CharacterSet.letters.inverted
        let array = string.components(separatedBy: setValid)
        if array.count > 1{
            return false
        }
        return (textField.text?.characters.count)! < lengthName
        
    }
    private func isValidRegNumber(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)->Bool{
        let length = 10
        let setValid = CharacterSet.alphanumerics.inverted
        let array = string.components(separatedBy: setValid)
        if array.count > 1{
            return false
        }
        return (textField.text?.characters.count)! < length
        
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField ==  nameTextField {
            self.carRegTextField.becomeFirstResponder()
        }else if textField == carRegTextField{
            self.telTextField.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case nameTextField:
            return isValidName (nameTextField, shouldChangeCharactersIn: range, replacementString: string)
        case carRegTextField:
            return isValidRegNumber(carRegTextField, shouldChangeCharactersIn: range, replacementString: string)
        case telTextField:
            return isValidTelephone(telTextField, shouldChangeCharactersIn: range, replacementString: string)
        default:
            return false
        }
    }
    
    
    @IBAction func checkButtonState(){
        if telTextField.text?.characters.count != 0  && nameTextField.text?.characters.count != 0 && carRegTextField.text?.characters.count != 0 && isAgreeSwitch.isOn {
            self.conformButton.isEnabled = true
            conformButton.alpha = 1
            print("button is enable")
        } else {
            self.conformButton.isEnabled = false
            conformButton.alpha = 0.5
            print("button is disable")
        }
    }
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Set photoImageView to display the selected image.
        photoButton.setImage(selectedImage , for: UIControlState.normal)
        self.imageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Action Button Photo
    @IBAction func getPhotoFromLibrary(_ sender: Any) {
        picker.allowsEditing = false
        picker.modalPresentationStyle = .popover
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
       
    }
    
    @IBAction func shootPhoto(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    
    
}
