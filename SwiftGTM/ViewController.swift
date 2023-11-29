//
//  ViewController.swift
//  SwiftGTM
//
//  Created by ukseung.dev on 11/29/23.
//

import UIKit
import Then
import Firebase
import SnapKit
import RxSwift
import RxCocoa

protocol ViewAttributes {
    func setUI()
    func setAttributes()
    func bindRx()
}

class ViewController: UIViewController, ViewAttributes {
    let disposeBag = DisposeBag()
    
    lazy var addButton = UIButton().then {
        $0.setTitle("Add Button", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 10
    }
    
    lazy var modifyButton = UIButton().then {
        $0.setTitle("Modify Button", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 10
    }
    
    lazy var blockButton = UIButton().then {
        $0.setTitle("Block Button", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setAttributes()
        bindRx()
    }
    
    func setUI() {
        self.view.addSubview(addButton)
        self.view.addSubview(modifyButton)
        self.view.addSubview(blockButton)
    }
    
    func setAttributes() {
        addButton.snp.makeConstraints {
            $0.bottom.equalTo(modifyButton.snp.top).offset(-40)
            $0.width.height.centerX.equalTo(modifyButton)
        }
        
        modifyButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        
        blockButton.snp.makeConstraints {
            $0.top.equalTo(modifyButton.snp.bottom).offset(40)
            $0.width.height.centerX.equalTo(modifyButton)
        }
    }
    
    func bindRx() {
        addButton.rx.tap
            .subscribe(onNext: {
                Analytics.logEvent("AddEvent", parameters: nil)
            })
            .disposed(by: disposeBag)
        
        modifyButton.rx.tap
            .subscribe(onNext: {
                Analytics.logEvent("ModifyEvent", parameters: nil)
            })
            .disposed(by: disposeBag)
        
        blockButton.rx.tap
            .subscribe(onNext: {
                Analytics.logEvent("BlockEvent", parameters: nil)
            })
            .disposed(by: disposeBag)
    }
}

