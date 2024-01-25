//
//  ViewController.swift
//  GCD
//
//  Created by 차소민 on 1/25/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        concurrentAsync()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        present(NASAViewController(), animated: true)
    }
    
    
}

extension ViewController {
    
    // serial == main
    // async == 비동기. 큐에게 전달한 뒤 기다리지 않고 다음 일을 처리한다
    // 메인쓰레드가 일을 하다가 DispatchQueue.main.async를 만나서 그 블럭의 일은 매니저에게 전달하고 다음 할 일을 함. 하지만 serial 이라서 매니저는 main에게 일을 부탁 -> 메인쓰레드 할 일 마지막에 추가됨
    func serialAsync() {
        print("시작🌱", Thread.isMainThread)
        for i in 1...10 {
            print(i, Thread.isMainThread, terminator: " ")
            
        }
        DispatchQueue.main.async {
            
            for i in 11...20 {
                print(i, Thread.isMainThread, terminator: " ")
            }
        }
        
        for i in 21...30 {
            print(i, Thread.isMainThread, terminator: " ")
        }
        
        DispatchQueue.main.async {
            
            for i in 31...40 {
                print(i, Thread.isMainThread, terminator: " ")
            }
            
            for i in 41...50 {
                print(i, Thread.isMainThread, terminator: " ")
            }
        }
        print("끝🌱", Thread.isMainThread)
    }
    
    
    // 메인쓰레드가 20까진 일을 잘 하다가 DispatchQueue.main.sync를 만나서 매니저에게 일을 전달하고 기다린다.
    // 매니저는 전달 받고 serial 이니까 메인에게 부탁하려고 함
    // 하지만 메인쓰레드는 21...30 일이 처리되기를 기다리는데 그 일을 처리해야하는 쓰레드도 본인이니까 21...30이 처리될 수가 없게 됨 -> 오류 발생
    func serialSync() {
        print("시작🌱", Thread.isMainThread)
        for i in 1...10 {
            print(i, Thread.isMainThread, terminator: " ")
        }
        
        for i in 11...20 {
            print(i, Thread.isMainThread, terminator: " ")
        }
        
        DispatchQueue.main.sync {
            for i in 21...30 {
                print(i, Thread.isMainThread, terminator: " ")
            }
        }
        
        
        for i in 31...40 {
            print(i, Thread.isMainThread, terminator: " ")
        }
        
        for i in 41...50 {
            print(i, Thread.isMainThread, terminator: " ")
        }
        
        print("끝🌱", Thread.isMainThread)
    }
    
    
    // 동시에 일을 하기 때문에 끝이 뭐가 될지 알 수 없음
    // 메인과 글로벌이 각자 서로의 일을 하기 때문에 프린트가 막 섞여져서 나온다
    // global.async 내부 11...20, 21...30은 순차적으로 출력
    // DispatchQueue.global().async 를 두 개 작성한다면 그 두 블럭도 각자 할 일을 한다
    func concurrentAsync() {
        print("시작🌱", Thread.isMainThread)
        for i in 1...10 {
            print(i, Thread.isMainThread, terminator: " ")
        }
        
        DispatchQueue.global().async {
            for i in 11...20 {
                print(i, Thread.isMainThread, terminator: " ")
            }
            
            for i in 21...30 {
                DispatchQueue.global().async {      // 10개의 프린트를 각각 쓰레드로 전달. 21~30 출력 순서도 보장못하게됨
                    print(i, Thread.isMainThread, terminator: " ")
                }
            }
        }
        
        for i in 31...40 {
            print(i, Thread.isMainThread, terminator: " ")
        }
        
        DispatchQueue.global().async {
            for i in 41...50 {
                print(i, Thread.isMainThread, terminator: " ")
            }
        }
        DispatchQueue.global().async {
            print("끝🌱", Thread.isMainThread)
        }
    }
    
    
    // global 로 보냈지만 sync여서 기다렸다가 작동 -> 결국 Main 혼자 알 하는 시간과 동일하다.
    // -> 내부적으로 그냥 global로 보내지 않고 main에게 일 시킴. Thread.isMainThread 가 전부 true 로 출력된다
    func concurrentSync() {
        print("시작🌱", Thread.isMainThread)
        for i in 1...10 {
            print(i, Thread.isMainThread, terminator: " ")
        }
        
        DispatchQueue.global().sync {
            for i in 11...20 {
                print(i, Thread.isMainThread, terminator: " ")
            }
        }
        
        for i in 21...30 {
            print(i, Thread.isMainThread, terminator: " ")
        }
        
        
        for i in 31...40 {
            print(i, Thread.isMainThread, terminator: " ")
        }
        
        
        for i in 41...50 {
            print(i, Thread.isMainThread, terminator: " ")
        }
        
        
        print("끝🌱", Thread.isMainThread)
        
    }
    
}
