//
//  Coordinator.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 09/03/22.
//

import UIKit

internal protocol Coordinator: AnyObject {

    var navigationController: BaseNavigationController { get set }
    var screenStack: [Screenable] { get set }

    var onCompleted: ((ScreenResult?) -> Void)? { get set }

    func start()

    func updateTitle()

    func showScreen(identifier: String, navigation: Navigation)
}

extension Coordinator {

    /// Sets the passed `screens` to this instance's `navigationController` and `screenStack`.
    func set(_ screens: [Screenable], animated: Bool = true) {

        let viewControllers: [ViewController] = screens.map({ screen -> ViewController in

            screen.event = { navigation in
                self.showScreen(
                    identifier: screen.identifier,
                    navigation: navigation
                )
            }

            return screen.build()
        })

        screenStack = screens

        navigationController.setViewControllers(
            viewControllers,
            animated: animated
        )
    }

    /// Pops to the `screen` by it's identifier and remove from `screenStack`.
    /// If it's not available in current `screenStack`, it will do nothing.
    func pop(byIdentifier identifier: String? = nil, animated: Bool = true) {

        guard !screenStack.isEmpty else {
            return
        }

        var screenIndex: Int?
        
        if identifier == nil {
            /// Pops the latest screen from `navigationController` and remove from `screenStack`.
            screenStack.removeLast()
            
            if navigationController.children.count == 2 {
                self.navigationController.tabBarController?.tabBar.isHidden = false
            }
            
            navigationController.popViewController(animated: animated)
            return
        }

        screenStack.enumerated()
            .forEach({ index, screen in

                if screen.identifier == identifier {
                    screenIndex = index
                }
            })

        guard let index = screenIndex,
            !navigationController.viewControllers.isEmpty,
            (index >= navigationController.viewControllers.startIndex) && (index <= navigationController.viewControllers.endIndex) else {
                return
        }

        for numIndex in ((index + 1)..<screenStack.count).reversed() {
            screenStack.remove(at: numIndex)
        }

        let showTapBar = (screenStack.count == 1)
        if showTapBar {
            self.navigationController.tabBarController?.tabBar.isHidden = false
        }

        let viewController: UIViewController = navigationController.viewControllers[index]

        navigationController.popToViewController(
            viewController,
            animated: animated
        )
    }
    
    /// Pushes the `screen` to this instance's `navigationController` and `screenStack`.
    func push(_ screen: Screenable, animated: Bool = true) {

        screen.event = { navigation in
            self.showScreen(
                identifier: screen.identifier,
                navigation: navigation
            )
        }

        screenStack.append(screen)

        let viewController = screen.build()

        if navigationController.children.count > 0 {
            self.navigationController.tabBarController?.tabBar.isHidden = true
        }
        navigationController.pushViewController(
            viewController,
            animated: animated
        )
    }

}
