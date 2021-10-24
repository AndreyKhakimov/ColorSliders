//
//  ViewController.swift
//  ColorSliders
//
//  Created by Andrey Khakimov on 23.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var mainViewOutlet: UIView!
    @IBOutlet var redColorLabelOutlet: UILabel!
    @IBOutlet var greenColorLabelOutlet: UILabel!
    @IBOutlet var blueColorLabelOutlet: UILabel!
    @IBOutlet var redSliderOutlet: UISlider!
    @IBOutlet var greenSliderOutlet: UISlider!
    @IBOutlet var blueSliderOutlet: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewOutlet.layer.cornerRadius = 10
        mainViewOutlet.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        redSliderOutlet.value = 0
        redSliderOutlet.minimumValue = 0
        redSliderOutlet.maximumValue = 1
        redSliderOutlet.tintColor = .red
        greenSliderOutlet.value = 0
        greenSliderOutlet.minimumValue = 0
        greenSliderOutlet.maximumValue = 1
        greenSliderOutlet.tintColor = .green
        blueSliderOutlet.value = 0
        blueSliderOutlet.minimumValue = 0
        blueSliderOutlet.maximumValue = 1
        blueColorLabelOutlet.tintColor = .blue
        blueColorLabelOutlet.text = "Blue: 0.00"
    }

    @IBAction func redSliderChange() {
        changeViewColor()
        redColorLabelOutlet.text = "Red: \(String((redSliderOutlet.value * 100).rounded() / 100))"
    }
    @IBAction func greenSliderChange() {
        changeViewColor()
        greenColorLabelOutlet.text = "Green: \(String((greenSliderOutlet.value * 100).rounded() / 100))"

    }
    @IBAction func blueSliderChange() {
        changeViewColor()
        blueColorLabelOutlet.text = "Blue: \(String((blueSliderOutlet.value * 100).rounded() / 100))"

    }
    func changeViewColor() {
        mainViewOutlet.backgroundColor = UIColor(red: CGFloat(redSliderOutlet.value), green: CGFloat(greenSliderOutlet.value), blue: CGFloat(blueSliderOutlet.value), alpha: 1)
    }
    
}

