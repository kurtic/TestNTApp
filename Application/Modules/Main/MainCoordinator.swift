//
//  MainCoordinator.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 10.05.2023.
//

import UIKit

// MARK: - Tabs

enum TabBarType: Int, CaseIterable {
    case mostEmailed = 0, mostShared, mostViewed, favourite
    
    var tabBarItem: UITabBarItem {
        switch self {
        case .mostEmailed:
            return UITabBarItem(title: "Most Emailed",
                                image: Img.icMostEmailed(),
                                selectedImage: Img.icMostEmailed())
        case .mostShared:
            return UITabBarItem(title: "Most Shared",
                                image: Img.icMostShared(),
                                selectedImage: Img.icMostShared())
        case .mostViewed:
            return UITabBarItem(title: "Most Viewed",
                                image: Img.icMostViewed(),
                                selectedImage: Img.icMostViewed())
        case .favourite:
            return UITabBarItem(title: "Favourite",
                                image: Img.icFavourite(),
                                selectedImage: Img.icFavourite())
        }
    }
}

final class MainCoordinator: Coordinator {
    // MARK: - Public Properties
    var useCases: UseCasesProvider
    
    // MARK: - Private Properties
    private var window: UIWindow?
    private weak var presenter: BaseTabBarVC!
    private var childCoordinators: [Coordinator] = []
    
    private var selectedTab: TabBarType = .mostEmailed {
        didSet {
            presenter.selectedIndex = selectedTab.rawValue
        }
    }
    
    // MARK: - Life Cycle
    init(useCases: UseCasesProvider, window: UIWindow) {
        self.window = window
        self.useCases = useCases
        setup()
    }
    
    func start(animated: Bool = true) {
        setup()
    }
    
    func stop(animated: Bool = true) {}
    
    private func setup() {
        let bar = BaseTabBarVC()
        presenter = bar
        bar.setCoordinator(self)
        window?.rootViewController = bar
        configure()
        window?.makeKeyAndVisible()
    }
    
    private func configure() {
        // Most Emailed
        let mostEmailedNavigation = UINavigationController()
        mostEmailedNavigation.tabBarItem = TabBarType.mostEmailed.tabBarItem
        presenter.addChild(mostEmailedNavigation)
        let mostEmailedCoordinator = MostEmailedCoordinator(navContoller: mostEmailedNavigation, useCases: useCases)
        childCoordinators.append(mostEmailedCoordinator)
        mostEmailedCoordinator.start()
        
        // Most Shared
        let mostSharedNavigation = UINavigationController()
        mostSharedNavigation.tabBarItem = TabBarType.mostShared.tabBarItem
        presenter.addChild(mostSharedNavigation)
        let mostSharedCoordinator = MostSharedCoordinator(navContoller: mostSharedNavigation, useCases: useCases)
        childCoordinators.append(mostSharedCoordinator)
        mostSharedCoordinator.start()
        
        // Most Viewed
        let mostViewedNavigation = UINavigationController()
        mostViewedNavigation.tabBarItem = TabBarType.mostViewed.tabBarItem
        presenter.addChild(mostViewedNavigation)
        let mostViewedCoordinator = MostViewedCoordinator(navContoller: mostViewedNavigation, useCases: useCases)
        childCoordinators.append(mostViewedCoordinator)
        mostViewedCoordinator.start()
        
        // Favourite
        let favouriteNavigation = UINavigationController()
        favouriteNavigation.tabBarItem = TabBarType.favourite.tabBarItem
        presenter.addChild(favouriteNavigation)
        let favouriteCoordinator = FavouriteCoordinator(navContoller: favouriteNavigation, useCases: useCases)
        childCoordinators.append(favouriteCoordinator)
        favouriteCoordinator.start()
        
        selectedTab = .favourite
    }
}
