//
//  NavigationEvent.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 09/03/22.
//

internal enum Navigation {
    case previous(ScreenResult?)
    case next(ScreenResult?)
}

internal final class NavigationEvent {

    typealias EventHandler = ((Navigation) -> Void)

    var eventHandler: EventHandler?

    func send(_ navigation: Navigation) {
        eventHandler?(navigation)
    }

    func on(_ handler: @escaping EventHandler) {
        eventHandler = handler
    }
}
