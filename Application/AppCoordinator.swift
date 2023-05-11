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
    
    // MARK: - Life Cycle
    init(useCases: UseCasesProvider) {
        self.useCases = useCases
        let coordinator = MainCoordinator(useCases: useCases, window: window)
        coordinator.start()
    }
}
