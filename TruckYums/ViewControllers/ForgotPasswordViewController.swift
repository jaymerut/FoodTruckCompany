//
//  ForgotPasswordViewController.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 12/31/20.
//  Copyright © 2020 truckyums. All rights reserved.
//

import UIKit


class ForgotPasswordViewController: UIViewController {
    
    
    // MARK: - Variables
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 20.0
        
        return view
    }()
    private lazy var viewHeader: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.init(hex: "0x055e86")
        view.clipsToBounds = true
        view.layer.cornerRadius = 20.0
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        return view
    }()
    
    private lazy var labelHeader: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Medium", size: 24.0)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    private lazy var buttonClose: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.init(hex: 0x444444), for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Teko-Regular", size: 18.0)
        button.addTarget(self, action: #selector(buttonClose_TouchUpInside), for: .touchUpInside)
        button.backgroundColor = UIColor.init(hex: 0xCCCCCC)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20.0
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return button
    }()
    
    // MARK: - Initialization
    private func customInitForgotPasswordViewController() {
        
    }
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        customInitForgotPasswordViewController()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customInitForgotPasswordViewController()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        customInitForgotPasswordViewController()
    }
    
    
    
    // MARK: - UIViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .init(white: 0.0, alpha: 0.6)
        
        // Setup
        setupForgotPasswordViewController()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    // MARK: - Private API
    private func setupForgotPasswordViewController() {
        
        // Content View
        self.view.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY)
            make.left.equalTo(self.view.snp.left).offset(50)
            make.right.equalTo(self.view.snp.right).inset(50)
            make.height.equalTo(0).priority(250)
        }
        
        // View Header
        self.contentView.addSubview(self.viewHeader)
        self.viewHeader.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.height.greaterThanOrEqualTo(50)
        }
        
        // Close Button
        self.contentView.addSubview(self.buttonClose)
        self.buttonClose.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.height.equalTo(50)
        }
        
        // Collection View
        self.contentView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewHeader.snp.bottom).offset(20)
            make.left.equalTo(self.contentView.snp.left).offset(10)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.bottom.equalTo(self.buttonClose.snp.top)
            make.height.equalTo(140)
        }
        
        
    }
    
    // MARK: UIResponders
    @objc private func buttonClose_TouchUpInside(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Public API
    
    
    
}
