//
//  MostEmailedVC.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 11.05.2023.
//

import ReactiveSwift

extension MostEmailedVC: Makeable {
    static func make() -> MostEmailedVC { R.storyboard.mostEmailed.mostEmailedVC()! }
}

final class MostEmailedVC: UIViewController, ViewModelContainer {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    func didSetViewModel(_ viewModel: MostEmailedVM, lifetime: Lifetime) {
        tableView.register(<#T##nib: UINib?##UINib?#>, forCellReuseIdentifier: <#T##String#>)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MostEmailedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
