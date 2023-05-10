//
//  AppCoordinator.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 10.05.2023.
//

import UIKit

final class AppCoordinator {
    // MARK: - Properties
    let window = UIWindow(frame: UIScreen.main.bounds)
    private let useCases: UseCasesProvider
    private lazy var navigationController = UINavigationController()
    
    // MARK: - Life Cycle
    init(useCases: UseCasesProvider) {
        self.useCases = useCases
        let coordinator = MainCoordinator(useCases: useCases, window: window)
        coordinator.start()
    }
}
