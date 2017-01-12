//
//  Item.swift
//  first-project
//
//  Created by Luiz Eduardo Cartolano on 10/01/17.
//  Copyright © 2017 Luiz Eduardo Cartolano. All rights reserved.
//

import Foundation

class Item: Equatable {
    let name:String
    let calories:Double
    
    init(name:String,calories:Double) {
        self.name = name
        self.calories = calories
    }
    
}

//funcao que compara o nome/calorias de dois itens e retorna "true" se ambos forem iguais
func == (first: Item, second: Item) -> Bool {
    return (first.name == second.name) && (first.calories == second.calories)
}
