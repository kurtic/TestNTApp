//
//  MostEmailedFactory.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 10.05.2023.
//

import Foundation

final class MostEmailedFactory: BaseFactory {
    
    static var main = MostEmailedFactory()
    private override init() {}
    
    func makeMostEmailedVC<T: Coordinator & MostEmailedVMDelegate>(delegate: T) -> MostEmailedVC {
        makeController(delegate) {
            $0.viewModel = MostEmailedVM(useCases: delegate.useCases, delegate: delegate)
        }
    }
}
