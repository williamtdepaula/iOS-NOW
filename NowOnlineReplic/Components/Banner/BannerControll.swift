//
//  BannerControll.swift
//  NowOnlineReplic
//
//  Created by William Tristão de Pauloa on 26/11/21.
//

import UIKit

//MARK: BannerControll
class BannerControll: UIView {
    
    var totalItemsOnBanner: Int = 0 {
        didSet {
            setupControlls()
        }
    }
    
    var currentPage: Int = 0 {
        didSet {
            changeCurrentPage()
        }
    }
    
    private lazy var stack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupControlls(){
        stack.removeFullyAllArrangedSubviews()
        
        for index in 0...totalItemsOnBanner-1 {
            stack.addArrangedSubview(Controll(frame: .zero, startFocused: index == currentPage))
        }
    }
    
    
    private func changeCurrentPage(){
        for controllIndex in 0..<stack.arrangedSubviews.count {
            guard let controll = stack.arrangedSubviews[controllIndex] as? Controll else {return}
            controll.focus(controllIndex == currentPage)
        }
    }
}

//MARK: Controll
class Controll: UIView {
    private let colorFocused: UIColor = .white
    private let colorUnfocused: UIColor = UIColor(hex: "#464646FF") ?? .gray
    
    var startFocused: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    init(frame: CGRect, startFocused: Bool) {
        super.init(frame: frame)
        self.startFocused = startFocused
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func focus(_ focus: Bool){
        self.backgroundColor = focus ? colorFocused : colorUnfocused
    }
    
    private func setupLayout(){
        self.backgroundColor = startFocused ? colorFocused : colorUnfocused
        self.layer.cornerRadius = 4
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 30),
            self.heightAnchor.constraint(equalToConstant: 8),
        ])
    }
}
