//
//  ToDoVC.swift
//  ModelsOS
//
//  Created by DA MAC M1 124 on 2023/05/24.
//

import UIKit

class ToDoVC: UIViewController {
    
   var array = [Todo]()
    
    var searchingArray = [Todo]()
    var searching = false

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchApiData(URL: "https://jsonplaceholder.typicode.com/todos"){ result in
            //self.data = result
            self.array = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func fetchApiData(URL url: String, completion: @escaping([Todo]) -> Void){
        
        let url = URL(string: url)
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) {  data, response, error in
            if data != nil && error == nil {
                do {
                    let parsingData = try JSONDecoder().decode([Todo].self , from: data!)
                    completion(parsingData)
                    
                } catch {
                    print("parsing error")
                }
                
            }
        }
            dataTask.resume()
        }
    }
        
    
    


//MARK: - TableView Methods

extension ToDoVC: UITableViewDataSource , UITableViewDelegate , UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching {
            return searchingArray.count
        } else {
            return array.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"ToDoTableViewCell" ,for: indexPath) as? ToDoTableViewCell else {return UITableViewCell()}
        
        let todo: Todo
               if searching {
                   todo = searchingArray[indexPath.row]
               } else {
                   todo = array[indexPath.row]
               }
        cell.titleLabel.text = todo.title
        cell.idLabel.text = "\(todo.id)"
               return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        array.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchingArray = array.filter({$0.title.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        
        vc?.numLabel = "\(array[indexPath.row].id)"
        vc?.titleLbl = array[indexPath.row].title
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}

