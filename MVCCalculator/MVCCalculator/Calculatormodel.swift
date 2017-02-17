//
//  calculatorModel.swift
//  sCalc
//
//  Created by joseph simiyu on 2/14/17.
//  Copyright © 2017 Strathmore. All rights reserved.
//

import Foundation

class calculatorModel {
    
    private var accumulator=0.0
    private var valueOperand=""
    
    private enum Operation{
        case Constants(Double)
        case UnaryOperations((Double)->Double)
        case BinaryOperations((Double,Double)->Double,(String,String)->String)
        case Result
        case Clear
    }
    
    private struct PendingBinaryOp{
        var binaryFunc:(Double,Double)->Double
        var firstOperand:Double
        var stringFunc:(String,String)->String
        var stringOperand:String
        
    }
    
    private var pending:PendingBinaryOp?
    
    func getOperands(operand:Double){
        
        accumulator=operand
        valueOperand=String(operand)
        
    }
   
        
    
    func executeOp(){
        
        if pending != nil{
            accumulator=pending!.binaryFunc(pending!.firstOperand,accumulator)
                valueOperand=pending!.stringFunc(pending!.stringOperand,valueOperand)
            pending=nil
            
        }
    }
    
    private var operations:Dictionary<String,Operation>=[
        "π" : Operation.Constants(M_PI), //M_PI,
        "√" : Operation.UnaryOperations(sqrt),
        "÷" : Operation.BinaryOperations(/,{"("+$0+"/"+$1+")"}),
        // "×" : Operation.BinaryOperations({(op1:Double,op2:Double)->Double
        //     in
        //     return op1*op2
        //      }  //using closure
        //),
        "×" :Operation.BinaryOperations(*,{"("+$0+"*"+$1+")"}),//closure
        // "+" : Operation.BinaryOperations(Addition),
        "+" : Operation.BinaryOperations(+,{"("+$0+"+"+$1+")"}),
        "-" : Operation.BinaryOperations(-,{"("+$0+"-"+$1+")"}),
        "Sin" : Operation.UnaryOperations({sin($0)}),
        "Cos" : Operation.UnaryOperations({cos($0)}),
        "Tan" : Operation.UnaryOperations({tan($0)}),
        "℮" : Operation.Constants(M_E),
        "%" : Operation.UnaryOperations({$0/100}),
        "±" : Operation.UnaryOperations({-1*$0}),
        "=" : Operation.Result,
        "AC": Operation.Clear
    ]
    
    private func clear(){
        accumulator=0
        pending=nil
        valueOperand=""
        
        
    }
    func performOperation(symbol:String){
        
        if let opertion = operations[symbol]{
            
            switch opertion {
            case .Constants(let value):
                accumulator = value
            case .UnaryOperations(let function):
                accumulator=function(accumulator)
            case .BinaryOperations(let function,let functionString):
                executeOp()
                pending=PendingBinaryOp(binaryFunc: function, firstOperand: accumulator,stringFunc: functionString,stringOperand: valueOperand)
                
            case .Result:
                executeOp()
                
            case .Clear:
                clear()
               
            }
        }
        
       
        
        
    }
    
    var result:Double{
        get{
            // return 0.0
            return accumulator
        }
    }
    
    var sData:String{
        get {
        
           return valueOperand
        }
    
    }
    
}
