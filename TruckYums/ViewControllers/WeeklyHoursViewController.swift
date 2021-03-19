//
//  WeeklyHoursViewController.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/23/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

import UIKit

protocol HoursSelectDelegate {
    func updateHours(hoursArray: [String])
    func closedHours()
}

class WeeklyHoursViewController: UIViewController, ListAdapterDataSource, UIScrollViewDelegate, WeeklyHoursSelectedDelegate {
    
    
    // MARK: - Variables
    private let screenSize = UIScreen.main.bounds.size;
    
    public var delegate: WeeklyHoursDelegate?
    
    public lazy var hoursArray: [String] = {
        let array = [String]()
        
        return array
    }()
    
    private lazy var objects: [Any] = {
        let array = [Any]()
        
        return array
    }()
    
    private lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater.init(), viewController: self, workingRangeSize: 0)
        adapter.scrollViewDelegate = self
        
        return adapter
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 20.0
        
        return view
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    private lazy var buttonApply: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Apply", for: .normal)
        button.setTitleColor(.init(hex: 0x455409), for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Teko-Regular", size: 18.0)
        button.addTarget(self, action: #selector(buttonApply_TouchUpInside), for: .touchUpInside)
        button.backgroundColor = UIColor.init(hex: 0xCDDC91)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20.0
        button.layer.maskedCorners = [.layerMinXMaxYCorner]
        
        return button
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
        button.layer.maskedCorners = [.layerMaxXMaxYCorner]
        
        return button
    }()
    
    // MARK: - Initialization
    private func customInitWeeklyHoursViewController() {
        
    }
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        customInitWeeklyHoursViewController()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customInitWeeklyHoursViewController()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        customInitWeeklyHoursViewController()
    }
    
    
    
    // MARK: - UIViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .init(white: 0.0, alpha: 0.6)
        
        self.objects.append(WeeklyHours.init(withHours: self.hoursArray))
        
        // Setup
        setupWeeklyHoursViewController()
        
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    // MARK: - Private API
    private func setupWeeklyHoursViewController() {
        
        // Adapter
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self
        
        // Content View
        self.view.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(50);
            make.left.equalTo(self.view.snp.left).offset(10);
            make.right.equalTo(self.view.snp.right).inset(10);
            make.bottom.equalTo(self.view.snp.bottom).offset(-20);
            make.height.equalTo(0).priority(250);
        }
        
        // Apply Button
        self.contentView.addSubview(self.buttonApply)
        self.buttonApply.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.centerX)
            make.height.equalTo(50)
        }
        
        // Close Button
        self.contentView.addSubview(self.buttonClose)
        self.buttonClose.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.left.equalTo(self.contentView.snp.centerX)
            make.right.equalTo(self.contentView.snp.right)
            make.height.equalTo(50)
        }
        
        
        // Collection View
        self.contentView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(10)
            make.left.equalTo(self.contentView.snp.left).offset(20)
            make.right.equalTo(self.contentView.snp.right).offset(-20)
            make.bottom.equalTo(self.buttonClose.snp.top)
            make.height.equalTo(self.view.frame.size.height - 50 - 120)
        }
        
    }
    
    // MARK: UIResponders
    @objc private func buttonClose_TouchUpInside(sender: UIButton) {
        self.delegate?.closedHours()
        self.dismiss(animated: true, completion: nil)
    }
    @objc private func buttonApply_TouchUpInside(sender: UIButton) {
        
        self.delegate?.updateHours(hoursArray: self.hoursArray)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    // MARK: - Public API
    
    // MARK: - Delegate methods
    // ListAdapterDataSource
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        self.objects as [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return WeeklyHoursSectionController.init(delegate: self)
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let label = UILabel(frame: .zero)
        label.text = "Issue with View"
        label.textAlignment = .center
        
        return label
    }
    
    // WeeklyHoursSelected
    func weeklyHoursDidUpdate(hoursArray: [String]) {
        self.hoursArray = hoursArray
    }
    
}
