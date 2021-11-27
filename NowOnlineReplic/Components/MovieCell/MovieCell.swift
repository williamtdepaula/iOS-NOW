//
//  MovieCell.swift
//  NowOnlineReplic
//
//  Created by William Tristão de Pauloa on 16/11/21.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {
    var moviePosterURL: String = "" {
        didSet {
            let url = URL(string: "\(moviePosterURL)?w=500")
            image.kf.setImage(with: url)
        }
    }
    
    private let image: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let placeholderImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "placeholder")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        view.contentMode = .scaleAspectFill
        return view
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(placeholderImage)
        contentView.addSubview(image)
        
        NSLayoutConstraint.activate([
            placeholderImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            placeholderImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            placeholderImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            placeholderImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
