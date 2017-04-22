//
//  AccidentReportViewController.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/19/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import UIKit

fileprivate struct Def {
    static let collectionCellIdent = "ImageCollectionCell"
    static let addPhotoCollectionCellIdent = "addPhotoCell"
    static let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
    static let itemsPerRow: CGFloat = 3
}

fileprivate enum Section: Int {
    case addPhoto = 0
    case photos = 1
}

class AccidentReportViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var carRegTextField: UITextField!
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var isAgreeSwitch: UISwitch!
    @IBOutlet weak var conformButton: UIButton!
    
    //MARK: - Properties
    var width : CGFloat?
    let picker = UIImagePickerController()
    var imageArray = [UIImage]()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        picker.delegate = self
        conformButton.layer.cornerRadius = conformButton.bounds.height / 2
    }
    override func viewDidAppear(_ animated: Bool) {
        width = collectionView.frame.width
    }
    
    //MARK: - Private Validation
    fileprivate func isValidTelephone(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let localNumberMaxLengs = 7
        let areaNumberMaxLengs = 3
        let countryNumberMaxLengs = 3
        
        let setValidation = CharacterSet.decimalDigits.inverted
        let array = string.components(separatedBy: setValidation)
        
        if array.count > 1 {
            return false
        }
        
        var newText = (textField.text as NSString?)!.replacingCharacters(in: range, with: string)
        let component = newText.components(separatedBy: setValidation)
        newText = component.joined()
        
        guard newText.characters.count <= areaNumberMaxLengs + countryNumberMaxLengs + localNumberMaxLengs else{
            return false
        }
        
        var resultText = ""
        
        
        let localNumber = min(localNumberMaxLengs, newText.characters.count)
        
        if localNumber > 0 {
            let strNumber = newText.substring(from: newText.characters.count - localNumber )
            
            resultText = strNumber
            if resultText.characters.count > 3 {
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
    
    fileprivate func isValidName(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)->Bool{
        
        let lengthName = 20
        var setValid = CharacterSet.letters
        setValid.formUnion(CharacterSet.init(charactersIn: " "))
        setValid.invert()
        let array = string.components(separatedBy: setValid)
        if array.count > 1 {
            return false
        }
        return (textField.text?.characters.count)! < lengthName
        
    }
    fileprivate func isValidRegNumber(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)->Bool{
        let length = 10
        let setValid = CharacterSet.alphanumerics.inverted
        let array = string.components(separatedBy: setValid)
        if array.count > 1 {
            return false
        }
        return (textField.text?.characters.count)! < length
        
    }
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        self.imageArray.append(selectedImage)
        self.collectionView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Action Photo
    
    @IBAction func deletePhoto(_ sender: UIButton) {
        self.imageArray.remove(at: sender.tag)
        collectionView.reloadData()
    }
    
    func getPhotoFromLibrary() {
         picker.allowsEditing = false
         picker.modalPresentationStyle = .popover
         picker.sourceType = .photoLibrary
         picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
         present(picker, animated: true, completion: nil)
    }
    
    func shootPhoto() {
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
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera",preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func showAlertCameraOrGalery(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "GALLERY", style: .default, handler: { (result : UIAlertAction) -> Void in
            self.getPhotoFromLibrary()
        }))
        
        alert.addAction(UIAlertAction(title: "CAMERA", style: .default, handler: { (result : UIAlertAction) -> Void in
            self.shootPhoto()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                     numberOfItemsInSection section: Int) -> Int {
        if section == Section.addPhoto.rawValue {
            return 1
        } else {
            return self.imageArray.count
        }
    }
        
    func collectionView(_ collectionView: UICollectionView,
                                     cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == Section.addPhoto.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Def.addPhotoCollectionCellIdent , for: indexPath)
            
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Def.collectionCellIdent,
                                                          for: indexPath) as? ImageCollectionCell
            cell?.image.image = imageArray[indexPath.row]
            cell?.removeButton.tag =  indexPath.row
            return cell ?? UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if indexPath.section == 0 {
                self.showAlertCameraOrGalery()
            }
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = Def.sectionInsets.left * (Def.itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / Def.itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == Section.addPhoto.rawValue{
            return UIEdgeInsets.zero
        }else{
            var inset = Def.sectionInsets
            inset.right = 0.0
            return inset
        }
        
    }
   
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Def.sectionInsets.left
    }

}

//MARK: - UITextFieldDelegate
extension AccidentReportViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField ==  nameTextField {
            self.carRegTextField.becomeFirstResponder()
        } else if textField == carRegTextField{
            self.telTextField.becomeFirstResponder()
        } else {
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
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.underlined()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //FIXE TO
        textField.deunderlined()
        return true
    }
    
    @IBAction func checkButtonState() {
        let isValid = telTextField.text?.characters.count != 0  && nameTextField.text?.characters.count != 0 && carRegTextField.text?.characters.count != 0 && isAgreeSwitch.isOn
        conformButton.alpha = isValid ? 1.0 : 0.5
        conformButton.isEnabled = isValid
    }
}
