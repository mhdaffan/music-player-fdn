//
//  LibraryViewModel.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 09/03/22.
//

import RxSwift

final class LibraryViewModel: BaseViewModel {
    
    private let useCase: LibraryUseCase = Resolver.resolve()
    
    let trackListSubject = PublishSubject<SubscribeResult<TrackListModel>>()
    var trackListModel = TrackListModel(header: HeaderModel(available: -1), trackList: [])
    var searchTrackListModel = TrackListModel(header: HeaderModel(available: -1), trackList: [])
    
    var isFetchInProgress: Bool = false
    var currentPage: Int = 0
    var currentSearchPage: Int = 0
    var artistKeyword: String = ""
    
    func getTrackList() {
        guard !isFetchInProgress,
              trackListModel.header.available != trackListModel.trackList.count,
              searchTrackListModel.header.available != searchTrackListModel.trackList.count else {
                  return
              }
        
        isFetchInProgress = true
        let page = artistKeyword.isEmpty ? currentPage : currentSearchPage
        baseStateProperty.onNext(.loading)
        
        useCase.getTrackList(page: page + 1, pageSize: 10, artistName: artistKeyword)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(
                onNext: { [weak self] response in
                    self?.baseStateProperty.onNext(.finished)
                    if let keyword = self?.artistKeyword, keyword.isEmpty {
                        self?.currentPage += 1
                        self?.trackListModel.header = response.header
                        self?.trackListModel.trackList.append(contentsOf: response.trackList)
                    } else {
                        self?.currentSearchPage += 1
                        self?.searchTrackListModel.header = response.header
                        self?.searchTrackListModel.trackList.append(contentsOf: response.trackList)
                    }
                    self?.syncronizeData()
                    self?.isFetchInProgress = false
                    
                    self?.trackListSubject.onNext(.Success(response))
                }, onError: { [weak self] error in
                    self?.baseStateProperty.onNext(.failed)
                    self?.isFetchInProgress = false
                    self?.trackListSubject.onNext(.Failure(error))
                })
            .disposed(by: disposeBag)
    }
    
    func getAllLocalTracks() -> [MusicTrackLocalDataModel] {
        return useCase.getAllLocalTracks()
    }
    
    func saveToLocal(item: MusicTrackLocalDataModel) {
        useCase.saveToLocal(item: item)
        syncronizeData()
    }
    
    func syncronizeData() {
        let localTracks = getAllLocalTracks()
        trackListModel.trackList = trackListModel.trackList.map { item -> TrackModel in
            var _item = item
            _item.isFavorite = false
            localTracks.forEach {
                if $0.trackId == _item.trackId {
                    _item.isFavorite = $0.trackId == _item.trackId
                }
            }
            
            return _item
        }
        
        searchTrackListModel.trackList = searchTrackListModel.trackList.map { item -> TrackModel in
            var _item = item
            _item.isFavorite = false
            localTracks.forEach {
                if $0.trackId == _item.trackId {
                    _item.isFavorite = $0.trackId == _item.trackId
                }
            }
            
            return _item
        }
    }
}
