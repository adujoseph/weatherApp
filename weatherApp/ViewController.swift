//
//  ViewController.swift
//  weatherApp
//
//  Created by MAC on 13/12/2018.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func submitButton(_ sender: Any) {
        
       if let url = URL(string: "https://www.weather-forecast.com/locations/" + cityTextField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest"){
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            
            var message = ""
            
            if let error = error {
                print(error)
            } else {
                if let unwrappedData = data {
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    var stringSeparator = " "
                    if let contentArray = dataString?.components(separatedBy: stringSeparator){
                        if contentArray.count > 1 {
                            stringSeparator = " "
                            
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                            if newContentArray.count > 1 {
                                message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                print(newContentArray[0])
                            }
                            
                        }
                    }
                    
                }
            }
            
            if message == ""{
                message = " Please try again later... "
            }
            
            DispatchQueue.main.sync(execute: {
                self.resultLabel.text = message
            })
            
        }
        task.resume()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }


}

