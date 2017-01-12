//
//  NewItemViewController.swift
//  first-project
//
//  Created by Luiz Eduardo Cartolano on 12/01/17.
//  Copyright © 2017 Luiz Eduardo Cartolano. All rights reserved.
//

import UIKit

class NewItemViewController: UIViewController {
    
    var delegate:AddAnItemDelegate?
    
    init(delegate: AddAnItemDelegate){
        super.init(nibName: "NewItemViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBOutlet var nameField:UITextField?
    @IBOutlet var caloriesField:UITextField?
    
    @IBAction func addNewItem() {
        
        let name = nameField!.text
        let calories = Double(caloriesField!.text!)
        
        if ((name == nil) || (calories == nil)){
            return
        } else{
            // adiciona um novo item a lista
            let item = Item(name: name!, calories: calories!)
            if(delegate != nil){
                delegate!.add(item)
            }
            
            if let navigation =  navigationController {
                // desempilha a tela na qual se adicion um novo item
                navigation.popViewController(animated: true)
            }
        }
    }
}
