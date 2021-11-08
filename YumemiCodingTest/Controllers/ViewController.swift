//
//  ViewController.swift
//  YumemiCodingTest
//
//  Created by system on 2021/10/25.
//

import UIKit

struct Repository: Codable {
    //let fullName: String
    var language: String
//    let stars: Int
//    let watchers: Int
//    let forks: Int
//    let openIssues: Int
//    struct owner: Codable {
//        let avatarUrl: String
//    }
    
}

class ViewController: UIViewController {
    
    fileprivate var repositories: [Repository] = []
    
    
    
    var task: URLSessionTask?
    var textUserInput: String?
    var url: String?
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .secondarySystemBackground
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        
        navigationController?.navigationBar.topItem?.titleView = searchBar
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
}

//MARK: - searchBar

extension ViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        textUserInput = searchBar.text
        searchBar.resignFirstResponder()
        guard let textUserInput = textUserInput else {
            return
        }
        if textUserInput.count != 0 {
            fetchRepository(with: textUserInput, completion: {( repository ) in
                //self.repositories = repository
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    func fetchRepository(with textUserInput: String, completion: @escaping (Repository) -> Swift.Void) {
        url = "https://api.github.com/search/repositories?q=\(textUserInput)"
        guard let url = url else {return}
        task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
            guard let jsonData = data else {
                return
            }
            do {
                print(jsonData)
                let repository = try JSONDecoder().decode(Repository.self, from: jsonData)
                print(repository)
                completion(repository)
            } catch {
                print(error.localizedDescription)
            }
        }
        // これ呼ばなきゃリストが更新されません
        task?.resume()
        
    }
}

//MARK: - tableView

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let repository = repositories[indexPath.row]
        //cell.textLabel?.text = data["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository.language as? String ?? ""
        cell.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = ResultViewController()
        
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.navigationItem.title = "Result"
        
        let repository = repositories[indexPath.row]
        print(repository.language)
        // ResultVCに値を渡す
        vc.indexPathRow = indexPath.row
        vc.repositories = repositories
        navigationController?.pushViewController(vc, animated: true)
    }
}


