//
//  HomeViewController.swift
//  NowOnlineReplic
//
//  Created by William Tristão de Pauloa on 24/11/21.
//

import UIKit

class HomeViewController: UIViewController {
    private let defaultID = "defaultID"
    private let bannerCarrouselID = "bannerCarrouselID"
    private let channelsCarrouselID = "channelsCarrouselID"
    private let moviesCarrouselID = "moviesCarrouselID"
    private let sectionHeaderID = "sectionHeaderID"
    
    private let viewModel = HomeViewModel()
    
    private func compositionLayout(section: Int) -> NSCollectionLayoutSection {
        let category = viewModel.page?.categories[section]
        
        //Header
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        switch category?.type {
        case .banners:
            //Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            //Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.7))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            //Section
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        case .tv_channels:
            //Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 4, trailing: 0)
            
            //Group Size
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3.5), heightDimension: .fractionalWidth(0.30))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            //Section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = [sectionHeader]
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0)
            
            return section
        case .editorial:
            //Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 4, trailing: 0)
            
            //Group Size
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2.8), heightDimension: .fractionalWidth(0.5))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            //Section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = [sectionHeader]
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0)
            
            return section
        default:
            
            //Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0), heightDimension: .fractionalHeight(0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            //Group Size
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0), heightDimension: .fractionalWidth(0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            //Section
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        
    }
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.compositionLayout(section: sectionIndex)
        }
        
        //Collection Config
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.dataSource = self
        view.isHidden = true
        
        //Cells
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: defaultID)
        view.register(Banner.self, forCellWithReuseIdentifier: bannerCarrouselID)
        view.register(ChannelCell.self, forCellWithReuseIdentifier: channelsCarrouselID)
        view.register(MovieCell.self, forCellWithReuseIdentifier: moviesCarrouselID)
        view.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderID)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.requestCatalog()
        setupConfigs()
    }
}

//MARK: CollectionView
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let totalCategories = viewModel.page?.categories.count else {return 0}
        return totalCategories
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionType = viewModel.page?.categories[section].type else {return 0}
        
        switch sectionType{
        case .banners:
            return 1
        default:
            guard let totalContents = viewModel.page?.categories[section].contents.count else {return 0}
            return totalContents
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let category = viewModel.page?.categories[indexPath.section] else {return UICollectionViewCell()}
        let content = category.contents[indexPath.row]
        switch category.type {
        case .banners:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bannerCarrouselID, for: indexPath) as? Banner else {return UICollectionViewCell()}
            cell.items = category.contents
            return cell
        case .tv_channels:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: channelsCarrouselID, for: indexPath) as? ChannelCell else {return UICollectionViewCell()}
            cell.isLive = content.hasLive ?? false
            cell.logoURL = content.images?.banner ?? ""
            return cell
        case .editorial:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: moviesCarrouselID, for: indexPath) as? MovieCell else {return UICollectionViewCell()}
            cell.moviePosterURL = content.images?.coverPortrait ?? ""
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: defaultID, for: indexPath)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let title = viewModel.page?.categories[indexPath.section].title
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderID, for: indexPath) as? SectionHeader
        header?.title = title ?? ""
        return header!
    }
}

//MARK: CodeView
extension HomeViewController: CodeView {
    func configViews() {
        view.addSubview(collection)
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.topAnchor, constant: -50),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func additionalConfig() {
        view.backgroundColor = .black
    }
}

//MARK: ViewModel
extension HomeViewController: HomeViewModelDelegate {
    func onRequestCatalogWithSuccess() {
        guard let totalCategories = viewModel.page?.categories.count else {return}
        
        if totalCategories > 0 {
            DispatchQueue.main.async {[weak self] in
                self?.collection.isHidden = false
                self?.collection.reloadData()
            }
        }
    }
    
    func onRequestCatalogWithFailure() {
        
    }
    
}
