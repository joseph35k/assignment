//
//  ViewController.swift
//  MVCCalculator
//
//  Created by ilabadmin on 30/01/2017.
//  Copyright © 2017 strathmore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lbldisplay: UILabel!
      @IBOutlet weak var lbldata: UILabel!
    
    var isUserTyping: Bool = false
    var model: calculatorModel = calculatorModel()
    
    var  displayValue: Double {
    get{
        
    return Double(lbldisplay.text!)!
    }
    set{
    lbldisplay.text = String (newValue)
    }
    }
  
 
    @IBAction func digitTouched(sender: UIButton) {
        
       let  digit = sender.currentTitle!
        
        if  isUserTyping{
            lbldisplay.text = lbldisplay.text!+digit
        }
        else {
            lbldisplay.text = digit
        }
        isUserTyping = true
        }
        
    @IBAction func Performoperation(sender: AnyObject) {
//        model.getOperands(operand : displayValue)
//        if let matSymbol = sender.currentTitle{
//        model.performOperation(symbol : sender.currentTitle!)
//        }
        if isUserTyping{
            
            model.getOperands( displayValue)
           // model.getStringOperands(String(displayValue))
            isUserTyping = false
        }
        if let mathSymbol = sender.currentTitle{
            model.performOperation (mathSymbol!)
        
        }
        
        displayValue = model.result
        if (sender.currentTitle!! == "="){
            lbldata.text=model.sData + sender.currentTitle!!

            
            
        } else{
            lbldata.text=model.sData

       }
           }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}








