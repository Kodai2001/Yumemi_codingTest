//
//  ResultViewViewController.swift
//  YumemiCodingTest
//
//  Created by system on 2021/10/25.
//

import UIKit

class ResultViewController: UIViewController {
    
    let vc = ViewController()
    var indexPathRow: Int!
    var datas: [String: Any]? = [:]
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.numberOfLines = 2
        label.tintColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.text = "languageLabel"
        label.numberOfLines = 2
        label.tintColor = .secondaryLabel
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let starsLabel: UILabel = {
        let label = UILabel()
        label.text = "starsLabel"
        label.tintColor = .secondaryLabel
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    let watchersLabel: UILabel = {
        let label = UILabel()
        label.text = "watchersLabel"
        label.tintColor = .secondaryLabel
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    let forksLabel: UILabel = {
        let label = UILabel()
        label.text = "forksLabel"
        label.tintColor = .secondaryLabel
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    let issuesLabel: UILabel = {
        let label = UILabel()
        label.text = "issuesLabel"
        label.tintColor = .secondaryLabel
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        getText()
        getImage()
        addSubviews()
    }
    
    // ラベルのテキスト内容を取得する
    private func getText() {
        let data = datas!
        languageLabel.text = "Written in \(data["language"] as? String ?? "")"
        starsLabel.text = "\(data["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(data["wachers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(data["forks_count"] as? Int ?? 0) forks"
        issuesLabel.text = "\(data["open_issues_count"] as? Int ?? 0) open issues"
    }
    
    // imageViewを取得する
    private func getImage() {
        guard let data = datas else {
            return
        }
        titleLabel.text = data["full_name"] as? String
        
        if let owner = data["owner"] as? [String: Any] {
            if let imgURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
                    let img = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.imageView.image = img
                    }
                }.resume()
            }
        }
    }
    
    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(languageLabel)
        view.addSubview(starsLabel)
        view.addSubview(watchersLabel)
        view.addSubview(forksLabel)
        view.addSubview(issuesLabel)
    }
    
    override func viewDidLayoutSubviews() {
        
        let widthSize = (view.frame.size.width)/2.0
        imageView.frame = CGRect(x: widthSize-widthSize/2.0,
                                 y: view.safeAreaInsets.top+100,
                                 width: widthSize,
                                 height: widthSize)
        
        titleLabel.frame = CGRect(x: 0,
                                  y: view.safeAreaInsets.top+widthSize+130,
                                  width: view.frame.size.width,
                                  height: 60)
        
        languageLabel.frame = CGRect(x: 20,
                                     y: view.safeAreaInsets.top+widthSize+200,
                                     width: widthSize,
                                     height: 60)
        
        starsLabel.frame = CGRect(x: widthSize,
                                  y: view.safeAreaInsets.top+widthSize+200,
                                  width: widthSize-10,
                                  height: 30)
        
        watchersLabel.frame = CGRect(x: widthSize,
                                     y: view.safeAreaInsets.top+widthSize+250,
                                     width: widthSize-10,
                                     height: 30)
        
        forksLabel.frame = CGRect(x: widthSize,
                                  y: view.safeAreaInsets.top+widthSize+300,
                                  width: widthSize-10,
                                  height: 30)
        
        issuesLabel.frame = CGRect(x: widthSize,
                                   y: view.safeAreaInsets.top+widthSize+350,
                                   width: widthSize-10,
                                   height: 30)
    }
}
