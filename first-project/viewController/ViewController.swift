//
//  ViewController.swift
//  first-project
//
//  Created by Luiz Eduardo Cartolano on 10/01/17.
//  Copyright © 2017 Luiz Eduardo Cartolano. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddAnItemDelegate {
    
    @IBOutlet var nameField: UITextField?
    @IBOutlet var happinessField: UITextField?
    //o uso do nome "delegate" eh fruto de um padrao da API swift
    var delegate: addAMealDelegate?
    
    var items = [Item(name:"Eggplant", calories:10),
                 Item(name:"Cookies", calories:30),
                 Item(name:"Brownie", calories:70),
                 Item(name:"Salad", calories:30),
                 Item(name:"Cake", calories:60)
                ]
    //array vazia com os itens que queremos selecionar
    var selected =  Array<Item>()
    @IBOutlet var tableView : UITableView?
    
    func add(_ item: Item) {
        items.append(item)
        tableView?.reloadData()
    }
    
    //criando um novo item para a barra (programaticamente)
    override func viewDidLoad() {
        let newItemButton = UIBarButtonItem(title: "New Item", style: UIBarButtonItemStyle.plain, target: self, action: #selector(showNewItem))
        // o botao do lado direito sera igual ao botao criado
        navigationItem.rightBarButtonItem = newItemButton
    }
    
    func showNewItem(){
        let newItem = NewItemViewController(delegate: self)
        if let navigation = navigationController {
            navigation.pushViewController(newItem, animated: true)
        }
    }
    
    //funcao para selecionar uma celula
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            if(cell.accessoryType == UITableViewCellAccessoryType.none){
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
                //adiciona o item marcado ao array "selected"
                let item = items[indexPath.row]
                selected.append(item)
            } else{
                cell.accessoryType = UITableViewCellAccessoryType.none
                let item = items[indexPath.row]
                //verifica se o item existe e, se sim, a funcao "index" retorna a posicao desse item no array
                if let position = selected.index(of: item){
                    //removemos a o elemento do vetor "selected" que ocupa a posicao position
                    selected.remove(at: position)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let item = items[row]
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel!.text = item.name
        return cell
    }
    
    
    
    @IBAction func add(){
        if(nameField == nil || happinessField == nil){
            return
        }
        
        let name:String = nameField!.text!
        
        if let happiness = Int(happinessField!.text!){
            let meal = Meal(name: name, happiness: happiness, items: selected)
            
            print("eaten \(meal.name) with happiness \(meal.happiness) with \(meal.items)")
            
            if (delegate == nil){
                return
            }
            else{
                delegate!.add(meal)
            }
            if let navigation = navigationController{
                navigation.popViewController(animated: true)
            }
            
        }
    
    }
}

