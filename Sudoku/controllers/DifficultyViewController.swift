//
//  DifficultyViewController.swift
//  Sudoku
//
//  Created by Marcus on 2021-04-12.
//

import Foundation
import UIKit

class DifficultyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var difficulty: String = "Easy"
    let listOfDifficulties = ["Practice", "Very Easy", "Easy", "Medium", "Hard", "Very Hard", "Master", "Insane"]
    
    @IBOutlet weak var difficultyPicker: UIPickerView!
    @IBAction func startButtonPushed(_ sender: UIButton) {
        performSegue(withIdentifier: "difficultyToMain", sender: self)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //add additional setup code after load
        difficultyPicker.delegate = self
        difficultyPicker.dataSource = self
        print(difficultyPicker.frame)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "difficultyToMain"
        {
            let destinationVC = segue.destination as! ViewController
            destinationVC.difficulty = difficulty
        }
    }
    
    //picker funcs
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        listOfDifficulties.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listOfDifficulties[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        difficulty = listOfDifficulties[row]
        //character.setName(NewName: newName)
    }
    
}//end class

