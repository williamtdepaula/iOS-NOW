//
//  BannerCollection.swift
//  NowOnlineReplic
//
//  Created by William Tristão de Pauloa on 25/11/21.
//

import UIKit

class Banner: UICollectionViewCell {
    let cellBannerID = "cellBannerID"
    
    var items: [ItemCarousel]? {
        didSet {
            guard let items = items else {
                return
            }

            bannerControll.totalItemsOnBanner = items.count
        }
    }
    var scrollTimer: Timer?
    var currentItemInFocus: Int = 0 {
        didSet {
            bannerControll.currentPage = currentItemInFocus
        }
    }
    
    private lazy var collectionBanner: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: contentView.bounds.width, height: contentView.bounds.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.dataSource = self
        view.delegate = self
        view.register(BannerCell.self, forCellWithReuseIdentifier: cellBannerID)
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    private lazy var bannerControll: BannerControll = {
        let view = BannerControll(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        startAutoScroll()
        
        contentView.addSubview(collectionBanner)
        contentView.addSubview(bannerControll)
        
        NSLayoutConstraint.activate([
            collectionBanner.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionBanner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionBanner.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionBanner.bottomAnchor.constraint(equalTo: bannerControll.topAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            bannerControll.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            bannerControll.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: CollectionView
extension Banner: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = items?[indexPath.row] else {return UICollectionViewCell()}
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellBannerID, for: indexPath) as? BannerCell
        
        cell?.posterURL = item.images?.bannerPortrait ?? ""
        cell?.title = item.title
        cell?.infos = item.getBannerInfo()
        
        return cell!
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopAutoScroll()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let indexPath = collectionBanner.indexPathsForVisibleItems.first else {return}
        
        currentItemInFocus = indexPath.row
        startAutoScroll()
    }
    
}

//MARK: Auto Scroll
extension Banner {
    @objc private func scrollToNextCell(){
        guard let totalItems = items?.count else {return}
        
        currentItemInFocus = currentItemInFocus < totalItems - 1 ? currentItemInFocus + 1 : 0
        
        DispatchQueue.main.async {[weak self] in
            self?.collectionBanner.isPagingEnabled = false
            self?.collectionBanner.scrollToItem(at: IndexPath(item: self?.currentItemInFocus ?? 0, section: 0), at: .centeredHorizontally, animated: true)
            self?.collectionBanner.isPagingEnabled = true
        }
    }
    
    func startAutoScroll() {
        guard scrollTimer == nil else {return}
        scrollTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(scrollToNextCell), userInfo: nil, repeats: true)
    }
    
    func stopAutoScroll(){
        scrollTimer?.invalidate()
        scrollTimer = nil
    }
}
