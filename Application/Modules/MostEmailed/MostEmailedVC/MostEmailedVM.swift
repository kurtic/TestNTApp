//
//  MostEmailedVM.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 11.05.2023.
//

import ReactiveSwift

protocol MostEmailedVMDelegate: AnyObject {
    
}

final class MostEmailedVM: UseCasesConsumer {
    typealias UseCases = HasArticlesUseCase
    
    // MARK: - Private Properties
    private weak var delegate: MostEmailedVMDelegate?
    
    // MARK: - Life Cycle
    init(useCases: UseCases, delegate: MostEmailedVMDelegate) {
        self.useCases = useCases
        self.delegate = delegate
    }
}
