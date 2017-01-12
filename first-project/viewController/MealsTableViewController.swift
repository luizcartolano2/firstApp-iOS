//
//  MealsTableViewControllers.swift
//  first-project
//
//  Created by Luiz Eduardo Cartolano on 11/01/17.
//  Copyright © 2017 Luiz Eduardo Cartolano. All rights reserved.
//

import UIKit

// ",MyDelegate" significa que a classe em questao implementa esse protocolo
class MealsTableViewController : UITableViewController, addAMealDelegate {
    
    // array de meals
    var meals = [Meal(name: "brownie", happiness: 5),
                 Meal(name: "cookies", happiness: 4)]
    
    // funcao para adicionar um novo elemento a tableView
    // o underline antes do primeiro parametro significa que nao eh preciso colocar seu nome ao chamar uma funcao
    func add(_ meal: Meal){
        meals.append(meal)
        tableView.reloadData()
    }
    
    // funcao que "avisa" o controler que ele eh o proprio ViewControler(quando "saltamos" de uma tela para outra)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // verificando se o identificador do segue eh o identificador que quero usar
        if(segue.identifier == "addMeal"){
            let view = segue.destination as! ViewController
            view.delegate = self
        }
    }
    
    // funcao que retorna o numero de linhas
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    // funcao chamada para cada celula e que retorna a mesma com um conteudo
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        let meal = meals[row]
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel!.text = meal.name
        
        //criando um reconhecedor de gestos
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(showDetails))
        cell.addGestureRecognizer(longPressRecognizer)
        
        return cell
        
    }
    
    // funcao que mostra os detalhes de uma refeicao quando alguem pressiona uma celula
    func showDetails(recognizer: UILongPressGestureRecognizer) {
        
        // se o estado de "long press" tiver acabado de comecar eu realizo o codigo
        if(recognizer.state == UIGestureRecognizerState.began){
            let cell = recognizer.view as! UITableViewCell
            // descobrindo o IndexPath da celulas
            if let indexPath = tableView.indexPath(for: cell){
                // descobrindo o indice do indexPath no vetor e a refeicao correspondente
                let row = indexPath.row
                let meal = meals[row]
                
                // mostrar um alerta na tela do usuario
                let details = UIAlertController(title: meal.name, message: meal.details(), preferredStyle: UIAlertControllerStyle.alert)
                
                // "botao" que aparece no alert para fechar o mesmo
                let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
                details.addAction(ok)
                
                // mostra o controle de uma forma "modal"(sem poder interagir com o que esta atras)
                present(details, animated: true, completion: nil)
            }
        }
    }
    
}
