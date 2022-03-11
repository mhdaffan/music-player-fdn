//
//  BaseViewModel.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 11/03/22.
//

import RxSwift

enum LoadingState: Int {
    case notLoad
    case loading
    case finished
    case failed
}

class BaseViewModel {
    
    var disposeBag = DisposeBag()
    
    let baseStateProperty = BehaviorSubject<LoadingState>(value: .notLoad)
    
}
