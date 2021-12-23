//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Birkan Pusa on 23.12.2021.
//

import UIKit

class ViewController: UIViewController {

    //tanımlamalar
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func getRatesClicked(_ sender: Any) {
        
        //Request & session
        //Response & data
        //Parsing & Json Serializition
        
        //1
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=85e7e4342057a8d71ce5f8f0acbc3c07&format=1")
        
        let session = URLSession.shared
        
        
        
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                //2
                if data != nil {
                    do {
                        
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        //ASYNC
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD : \(cad)"
                                }
                                
                                if let turkLira = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY : \(turkLira)"
                                }
                                
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD : \(usd)"
                                }
                                
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY : \(jpy)"
                                }
                                
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF : \(chf)"
                                }
                                
                            }
                        }
                        
                    } catch {
                        print("error")
                    }
                    
                }
            }
        }
        
        task.resume()
    }
    
}

