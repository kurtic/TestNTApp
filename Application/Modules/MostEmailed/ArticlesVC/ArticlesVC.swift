//
//  ArticlesVC.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 11.05.2023.
//

import ReactiveSwift

extension ArticlesVC: Makeable {
    static func make() -> ArticlesVC { R.storyboard.articles.articlesVC()! }
}

final class ArticlesVC: BaseVC, ViewModelContainer {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    func didSetViewModel(_ viewModel: ArticlesVM, lifetime: Lifetime) {
        title = viewModel.flow.title
        tableView.registerNib(for: ArticleTVC.self)
        
        reactive.makeBindingTarget { vc, _ in
            if viewModel.flow == .favourite {
                viewModel.getSavedArticles.apply().start()
            } else {
                viewModel.getArticles.apply(viewModel.flow).start()
            }
        } <~ reactive.viewWillAppear
        
        tableView.reactive.reloadData <~ viewModel.articles.map { _ in }
        
        reactive.makeBindingTarget { vc, isExecuting in
            if isExecuting {
                vc.startShowingActivity()
            } else {
                vc.stopShowingActivity()
            }
        } <~ viewModel.getArticles.isExecuting.or(viewModel.getSavedArticles.isExecuting)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ArticlesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.articles.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ArticleTVC.self)) as? ArticleTVC else { return UITableViewCell() }
        cell.configure(delegate: self, article: viewModel.articles.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.openArticleDetails(for: viewModel.articles.value[indexPath.row])
    }
}

// MARK: - ArticleTVCDelegate
extension ArticlesVC: ArticleTVCDelegate {
    // TODO
}
