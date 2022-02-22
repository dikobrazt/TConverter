//
//  ViewController.swift
//  TConverter
//
//  Created by Vladislav Tuleiko on 17.02.22.
//
// Tested on iphone 12mini
import UIKit

//MARK: - ViewController
class ViewController: UIViewController {
    
    @IBOutlet weak var getDataBtn: UIButton!

    @IBOutlet weak var firstCurrencyLabel: UILabel!
    
    @IBOutlet weak var secondCurrencyLabel: UILabel!
    
    @IBOutlet weak var firsrIW: UIImageView!
    
    @IBOutlet weak var secondIW: UIImageView!
    
    @IBOutlet weak var firstTField: UITextField!
    
    @IBOutlet weak var secondTField: UITextField!
    
    //MARK: - Making amazing view
    @IBAction func changeCurrencyButton(_ sender: Any) {
        print(firstTField.text)
        if let detailedCardView = changeCurrencyVC.sheetPresentationController{
            detailedCardView.detents = [.medium(), .large()]
            detailedCardView.prefersGrabberVisible = true
            detailedCardView.preferredCornerRadius = 25
        }
        present(changeCurrencyVC, animated: true)
        
    }
    
    private var userDefault = Currency()
    let net = Networking()
    let del = ChangeCurrencyVC()
    var changeCurrencyVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "changeCurrencyVC")
    
    //MARK: - VDL
    override func viewDidLoad() {
        super.viewDidLoad()
        net.networking()
        firstTField.delegate = self
        net.delegateFor = self
        textFieldDidChangeSelection(firstTField)
    }
}

//MARK: - Converter ext
extension ViewController {
    
    func convertCurrency(value: Double, type1: Double, type2: Double, label1: String, label2: String, image1: UIImage, image2: UIImage) {
       
        DispatchQueue.main.async {
            self.firstCurrencyLabel.text = label1
            self.secondCurrencyLabel.text = label2
            self.firsrIW.image = image1
            self.secondIW.image = image2
            let result: Double = value * type2 / type1
            self.secondTField.text = String(format: "%.2f" , result)
        }
    }
}

//MARK: - UITextFieldDelegate ext
extension ViewController: UITextFieldDelegate{

    func textFieldDidChangeSelection(_ textField: UITextField) {
       
        var t = Double(textField.text!)
        
        switch typeGlobal {
        case 1:
            
            convertCurrency(value: t ?? 1, type1: userDefault.rates.BYN, type2: Double(userDefault.rates.EUR), label1: "BYN", label2: "EUR", image1: UIImage(named: "belarus")!, image2: UIImage(named: "european-union")!)
        case 2: 
            
            convertCurrency(value: t ?? 1, type1: Double(userDefault.rates.EUR), type2: userDefault.rates.BYN, label1: "EUR", label2: "BYN", image1: UIImage(named: "european-union")!, image2: UIImage(named: "belarus")!)
            
        case 3:
    
            convertCurrency(value: t ?? 1, type1: userDefault.rates.RUB, type2: Double(userDefault.rates.EUR), label1: "RUB", label2: "EUR", image1: UIImage(named: "russia")!, image2: UIImage(named: "european-union")!)
        case 4:
      
            convertCurrency(value: t ?? 1, type1: Double(userDefault.rates.EUR), type2: userDefault.rates.RUB, label1: "EUR", label2: "RUB", image1: UIImage(named: "european-union")!, image2: UIImage(named: "russia")!)
        default:
            
            convertCurrency(value: t ?? 1, type1: userDefault.rates.BYN, type2: Double(userDefault.rates.EUR), label1: "BYN", label2: "EUR", image1: UIImage(named: "belarus")!, image2: UIImage(named: "european-union")!)
        }
    }
}

//MARK: - Data/AlertDelegate ext
extension ViewController: NetworkingDelegate {
    func alertDelegate(errorDescription: String) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: "Damn problems...", message: errorDescription, preferredStyle: UIAlertController.Style.alert)
            alertVC.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.destructive, handler: nil))
            alertVC.addAction(UIAlertAction(title: "Settings", style:
            UIAlertAction.Style.cancel, handler: { action in
                
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }))
            self.present(alertVC, animated: true, completion: nil)
    }
}
    
    func currencyDelegate(_: Networking, with currencyData: Currency) {
        self.userDefault = currencyData
    }
}


