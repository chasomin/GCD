//
//  NASAViewController.swift
//  GCD
//
//  Created by 차소민 on 1/25/24.
//

import UIKit

class NASAViewController: UIViewController {
    let syncButton = UIButton()
    let asyncButton = UIButton()
    
    let oneImageView = UIImageView()
    let twoImageView = UIImageView()
    let threeImageView = UIImageView()
    let fourImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubView()
        setFrame()
        setUI()
        
    }
    
    func addSubView() {
        view.addSubview(syncButton)
        view.addSubview(asyncButton)
        
        view.addSubview(oneImageView)
        view.addSubview(twoImageView)
        view.addSubview(threeImageView)
        view.addSubview(fourImageView)

    }
    
    func setFrame() {
        syncButton.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: 50)
        asyncButton.frame = CGRect(x: UIScreen.main.bounds.width/2, y: 0, width: UIScreen.main.bounds.width/2, height: 50)
        
        oneImageView.frame = CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 100) / 4)
        twoImageView.frame = CGRect(x: 0, y: 50 + (UIScreen.main.bounds.height - 100) / 4, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 100) / 4)
        threeImageView.frame = CGRect(x: 0, y: 50 + (UIScreen.main.bounds.height - 100) / 2, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 100) / 4)
        fourImageView.frame = CGRect(x: 0, y: 50 + (UIScreen.main.bounds.height - 100) / 4 * 3, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 100) / 4)


    }
    
    func setUI() {
        syncButton.setTitle("sync", for: .normal)
        syncButton.setTitleColor(.black, for: .normal)
//        syncButton.backgroundColor = .black
        syncButton.addTarget(self, action: #selector(syncButtonTapped), for: .touchUpInside)

        asyncButton.setTitle("async", for: .normal)
        asyncButton.setTitleColor(.black, for: .normal)
//        asyncButton.backgroundColor = .black
        asyncButton.addTarget(self, action: #selector(asyncButtonTapped), for: .touchUpInside)
        
        oneImageView.backgroundColor = .red
        twoImageView.backgroundColor = .blue
        threeImageView.backgroundColor = .yellow
        fourImageView.backgroundColor = .green
    }

    // 동기
    @objc func syncButtonTapped() {
        
    }
    
    func syncDownloadImage() {
        
    }
    
    // 비동기
    @objc func asyncButtonTapped() {
        
    }
    
    func asyncDownloadImage() {
        
    }
}
