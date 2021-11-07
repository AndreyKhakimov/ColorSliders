//
//  MainScreenViewController.swift
//  ColorSliders
//
//  Created by Andrey Khakimov on 05.11.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setViewBackgroundColor (for color: UIColor)
}

class MainScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func unwind(segue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.delegate = self
        settingsVC.viewColor = self.view.backgroundColor
    }

}

// MARK: - SettingsViewControllerDelegate
extension MainScreenViewController: SettingsViewControllerDelegate {
    func setViewBackgroundColor(for color: UIColor) {
        self.view.backgroundColor = color
    }
}
