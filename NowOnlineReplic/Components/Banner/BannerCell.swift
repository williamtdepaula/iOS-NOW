//
//  BannerCell.swift
//  NowOnlineReplic
//
//  Created by William Tristão de Pauloa on 25/11/21.
//

import UIKit
import Kingfisher

class BannerCell: UICollectionViewCell {
    var posterURL: String = "" {
        didSet {
            let url = URL(string: posterURL)
            poster.kf.setImage(with: url)
        }
    }
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var infos: String = "" {
        didSet {
            infosLabel.text = infos
        }
    }
    
    private lazy var poster: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        let gradient = CAGradientLayer()
        
        gradient.frame = contentView.bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor]

        view.layer.insertSublayer(gradient, at: 0)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "NOME DO FILME"
        view.textColor = .white
        view.font = .systemFont(ofSize: 26, weight: .heavy)
        view.numberOfLines = 3
        view.textAlignment = .center
        return view
    }()
    
    private lazy var infosLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Ação • 2019 • 108min"
        view.textColor = .white
        view.font = .systemFont(ofSize: 18)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(poster)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infosLabel)
        
        NSLayoutConstraint.activate([
            poster.topAnchor.constraint(equalTo: contentView.topAnchor),
            poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            poster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            poster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: infosLabel.topAnchor, constant: -7),
        ])
        
        NSLayoutConstraint.activate([
            infosLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            infosLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
