//
//  ResultViewViewController.swift
//  YumemiCodingTest
//
//  Created by system on 2021/10/25.
//

import UIKit

class ResultViewController: UIViewController {
    
    let vc = ViewController()
    
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .red
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.tintColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.text = "languageLabel"
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
        
        addSubviews()
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
        let constraint1 = NSLayoutConstraint(item: imageView,
                                             attribute: .centerX,
                                             relatedBy: .equal,
                                             toItem: view,
                                             attribute: .centerX,
                                             multiplier: 1.0,
                                             constant: 0.0)
        view.addConstraint(constraint1)
        
        titleLabel.frame = CGRect(x: widthSize-widthSize/2.0,
                                  y: view.safeAreaInsets.top+widthSize+130,
                                  width: widthSize,
                                  height: 30)
        
        languageLabel.frame = CGRect(x: 20,
                                     y: view.safeAreaInsets.top+widthSize+200,
                                     width: widthSize,
                                     height: 30)
        
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
