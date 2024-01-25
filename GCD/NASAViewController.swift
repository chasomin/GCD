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
        view.addSubview(oneImageView)
        view.addSubview(twoImageView)
        view.addSubview(threeImageView)
        view.addSubview(fourImageView)

        view.addSubview(syncButton)
        view.addSubview(asyncButton)
    }
    
    func setFrame() {
        syncButton.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: 50)
        asyncButton.frame = CGRect(x: UIScreen.main.bounds.width/2, y: 0, width: UIScreen.main.bounds.width/2, height: 50)
        
        let imageHeight = (UIScreen.main.bounds.height - 50) / 4
        
        oneImageView.frame = CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: imageHeight)
        twoImageView.frame = CGRect(x: 0, y: 50 + imageHeight, width: UIScreen.main.bounds.width, height: imageHeight)
        threeImageView.frame = CGRect(x: 0, y: 50 + imageHeight * 2, width: UIScreen.main.bounds.width, height: imageHeight)
        fourImageView.frame = CGRect(x: 0, y: 50 + imageHeight * 3, width: UIScreen.main.bounds.width, height: imageHeight)


    }
    
    func setUI() {
        syncButton.setTitle("sync", for: .normal)
        syncButton.setTitleColor(.black, for: .normal)
        syncButton.backgroundColor = .lightGray
        syncButton.addTarget(self, action: #selector(syncButtonTapped), for: .touchUpInside)

        asyncButton.setTitle("async", for: .normal)
        asyncButton.setTitleColor(.black, for: .normal)
        asyncButton.backgroundColor = .lightGray
        asyncButton.addTarget(self, action: #selector(asyncButtonTapped), for: .touchUpInside)

        
        oneImageView.backgroundColor = .red
        oneImageView.contentMode = .scaleAspectFill

        twoImageView.backgroundColor = .blue
        twoImageView.contentMode = .scaleAspectFill

        threeImageView.backgroundColor = .yellow
        threeImageView.contentMode = .scaleAspectFill

        fourImageView.backgroundColor = .green
        fourImageView.contentMode = .scaleAspectFill

    }

    // 동기
    @objc func syncButtonTapped() {
        syncDownloadImage(oneImageView, value: "1")
        syncDownloadImage(twoImageView, value: "2")
        syncDownloadImage(threeImageView, value: "3")
        syncDownloadImage(fourImageView, value: "4")
    }
    
    // 모든 일을 메인쓰레드 혼자 처리
    // 데이터 가져오고 그리고 가져오고 그리고 해야되는데
    // 너무 바빠서 다 가져온 다음에 한 번에 그린다
    func syncDownloadImage(_ imageView: UIImageView, value: String) {
        print("=시작=", value)
        let url = Endpoint.url
        print("=url 받아옴=", value)
        do {
            print("=do 들어옴=", value)
            let data = try Data(contentsOf: url)
            print("=data 받아옴=", value)
            imageView.image = UIImage(data: data)
            print("=image 그림=", value)
        } catch {
            imageView.image = UIImage(systemName: "star.fill")
        }
        print("=do catch 끝=", value)
    }
    
    
    
    
    // 비동기
    // 뭐가 먼저 그려질 지 알 수 없다
    @objc func asyncButtonTapped() {
        asyncDownloadImage(oneImageView, value: "1")
        asyncDownloadImage(twoImageView, value: "2")
        asyncDownloadImage(threeImageView, value: "3")
        asyncDownloadImage(fourImageView, value: "4")
    }
    
    // 메인
    // asyncButtonTapped -> asyncDownloadImage 실행 -> 프린트시작 -> let url -> 프린트url -> 일 전달 -> asyncButtonTapped -> .....
    func asyncDownloadImage(_ imageView: UIImageView, value: String) {
        print("=시작=", value, Thread.isMainThread)
        let url = Endpoint.url
        print("=url 받아옴=", value, Thread.isMainThread)
        DispatchQueue.global().async {
            do {
                print("=do 들어옴=", value, Thread.isMainThread)
                let data = try Data(contentsOf: url)
                print("=data 받아옴=", value, Thread.isMainThread)
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data)
                    print("=image 그림=", value, Thread.isMainThread)
                }
            } catch {
                imageView.image = UIImage(systemName: "star.fill")
            }
            print("=do catch 끝=", value, Thread.isMainThread)
        }
    }
}
