//
//  ViewController.swift
//  YumemiCodingTest
//
//  Created by system on 2021/10/25.
//

import UIKit

class ViewController: UIViewController {
    
    public var datas: [[String: Any]]=[]
    
    
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
    
    public override func viewDidLoad() {
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
            url = "https://api.github.com/search/repositories?q=\(textUserInput)"
            guard let url = url else {
                return
            }
            task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
                if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                    if let items = obj["items"] as? [[String: Any]] {
                        self.datas = items
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            // これ呼ばなきゃリストが更新されません
            task?.resume()
        }
    }
}

//MARK: - tableView

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        let data = datas[indexPath.row]
        cell.textLabel?.text = data["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = data["language"] as? String ?? ""
        cell.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = ResultViewController()
        
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.navigationItem.title = "Result"
        
        let data = datas[indexPath.row]
        
        // ResultVCに値を渡す
        vc.indexPathRow = indexPath.row
        vc.datas = data
        navigationController?.pushViewController(vc, animated: true)
    }
}


