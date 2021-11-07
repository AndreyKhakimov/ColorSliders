//
//  ViewController.swift
//  ColorSliders
//
//  Created by Andrey Khakimov on 23.10.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var blueColorLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redColorTextField: UITextField!
    @IBOutlet var greenColorTextField: UITextField!
    @IBOutlet var blueColorTextField: UITextField!
    
    var delegate: SettingsViewControllerDelegate!
    var viewColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redColorTextField.delegate = self
        greenColorTextField.delegate = self
        blueColorTextField.delegate = self

        redColorTextField.keyboardType = UIKeyboardType.decimalPad
        greenColorTextField.keyboardType = UIKeyboardType.decimalPad
        blueColorTextField.keyboardType = UIKeyboardType.decimalPad
        
        redColorTextField.addDoneButtonOnKeyboard()
        greenColorTextField.addDoneButtonOnKeyboard()
        blueColorTextField.addDoneButtonOnKeyboard()
        
        colorView.layer.cornerRadius = 10
        
        setValue(for: redColorLabel, greenColorLabel, blueColorLabel)
        setValue(for: redColorTextField, greenColorTextField, blueColorTextField )
        
        colorView.backgroundColor = viewColor
        
        redSlider.value = Float(viewColor.rgba.red)
        greenSlider.value = Float(viewColor.rgba.green)
        blueSlider.value = Float(viewColor.rgba.blue)
        
        redColorLabel.text = String(format: "%.2f", viewColor.rgba.red)
        greenColorLabel.text = String(format: "%.2f", viewColor.rgba.green)
        blueColorLabel.text = String(format: "%.2f", viewColor.rgba.blue)
        
        redColorTextField.text = string(from: redSlider)
        greenColorTextField.text = string(from: greenSlider)
        blueColorTextField.text = string(from: blueSlider)
    }
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        changeViewColor()
        
        switch sender {
        case redSlider:
            redColorLabel.text = string(from: sender)
            redColorTextField.text = string(from: sender)
        case greenSlider:
            greenColorLabel.text = string(from: sender)
            greenColorTextField.text = string(from: sender)
        default:
            blueColorLabel.text = string(from: sender)
            blueColorTextField.text = string(from: sender)
        }
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setViewBackgroundColor(for: UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value), alpha: 1))
    }
    
    func changeViewColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value), alpha: 1)
    }
    
    func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redColorLabel:
                redColorLabel.text = string(from: redSlider)
            case greenColorLabel:
                greenColorLabel.text = string(from: greenSlider)
            default:
                blueColorLabel.text = string(from: blueSlider)
            }
        }
    }
    
    func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redColorTextField:
                redColorTextField.text = string(from: redSlider)
            case greenColorTextField:
                greenColorTextField.text = string(from: greenSlider)
            default:
                blueColorTextField.text = string(from: blueSlider)
            }
        }
    }
        
    func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let colorNewValue = textField.text else { return }
        guard let floatColorNewValue = Float(colorNewValue) else { return }
        
        switch textField {
        case redColorTextField:
            if floatColorNewValue > 1 || floatColorNewValue < 0 {
                showAlert(title: "Incorrect color value", message: "Color should be set between 0 and 1")
            } else {
                redSlider.value = floatColorNewValue
            }
        case greenColorTextField:
            if floatColorNewValue > 1 || floatColorNewValue < 0 {
                showAlert(title: "Incorrect color value", message: "Color should be set between 0 and 1")
            } else {
                greenSlider.value = floatColorNewValue
            }
        default:
            if floatColorNewValue > 1 || floatColorNewValue < 0 {
                showAlert(title: "Incorrect color value", message: "Color should be set between 0 and 1")
            } else {
                blueSlider.value = floatColorNewValue
            }
        }
        
        setValue(for: redColorLabel, greenColorLabel, blueColorLabel)
        changeViewColor()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}

extension SettingsViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension UITextField {
   func addDoneButtonOnKeyboard() {
       let keyboardToolbar = UIToolbar()
       keyboardToolbar.sizeToFit()
       let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
           target: nil, action: nil)
       let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
           target: self, action: #selector(resignFirstResponder))
       keyboardToolbar.items = [flexibleSpace, doneButton]
       self.inputAccessoryView = keyboardToolbar
   }
}

