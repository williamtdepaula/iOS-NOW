//
//  HomeViewModel.swift
//  NowOnlineReplic
//
//  Created by William Tristão de Pauloa on 24/11/21.
//

import Foundation

protocol HomeViewModelDelegate {
    func onRequestCatalogWithSuccess()
    func onRequestCatalogWithFailure()
}

class HomeViewModel {
    public var page: Page?
    
    public var delegate: HomeViewModelDelegate?
    
    public func requestCatalog() -> Void{
        Request().getHome {[weak self] result in
            switch result {
            case .success(let data):
                print("SUCCESS!!")
                self?.page = data.response
                self?.delegate?.onRequestCatalogWithSuccess()
            case .failure(let err):
                print("Erro!!! ", err)
                self?.delegate?.onRequestCatalogWithFailure()
            }
        }
    }
}
