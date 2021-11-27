//
//  ChannelCell.swift
//  NowOnlineReplic
//
//  Created by William Tristão de Pauloa on 15/11/21.
//

import UIKit
import Kingfisher

class ChannelCell: UICollectionViewCell {
    
    var isLive: Bool = false {
        didSet {
            hiddeLiveLabel(!isLive)
        }
    }
    
    var logoURL: String = "" {
        didSet {
            let url = URL(string: logoURL)
            logo.kf.setImage(with: url)
        }
    }
    
    private lazy var liveCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        view.widthAnchor.constraint(equalToConstant: 6).isActive = true
        view.heightAnchor.constraint(equalToConstant: 6).isActive = true
        view.layer.cornerRadius = 3
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var liveLabel: UILabel = {
        let view = UILabel()
        view.text = "Ao vivo"
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = .white
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "channel")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        
        view.heightAnchor.constraint(equalToConstant: 70).isActive = true
        view.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConfigs()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func hiddeLiveLabel(_ hidde: Bool) -> Void {
        liveLabel.isHidden = hidde
        liveCircle.isHidden = hidde
    }
}

extension ChannelCell: CodeView{
    func configViews() {
        contentView.addSubview(liveCircle)
        contentView.addSubview(liveLabel)
        contentView.addSubview(logo)
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            liveCircle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            liveCircle.trailingAnchor.constraint(equalTo: liveLabel.leadingAnchor, constant: -3),
        ])
        
        NSLayoutConstraint.activate([
            liveLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            liveCircle.centerYAnchor.constraint(equalTo: liveLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: contentView.topAnchor),
            logo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func additionalConfig() {
        self.layer.cornerRadius = 4
        self.backgroundColor = UIColor(hex: "#191919FF")
    }
    
}
