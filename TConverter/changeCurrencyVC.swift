//
//  changeCurrencyVC.swift
//  TConverter
//
//  Created by Vladislav Tuleiko on 17.02.22.
//

import UIKit


var typeGlobal: Int = 0 // sorry

//MARK: - ChangeCurrencyVC
class ChangeCurrencyVC: UIViewController{
    
    @IBAction func bynEurButton(_ sender: Any) {
      typeGlobal = 1
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func eurBynButton(_ sender: Any) {
        typeGlobal = 2
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rubEurButton(_ sender: Any) {
        typeGlobal = 3
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func eurRubButton(_ sender: Any) {
        typeGlobal = 4
        self.dismiss(animated: true, completion: nil)
    }
    
    

    //MARK: - VDL
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


