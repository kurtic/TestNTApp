//
//  DetailArticleVC.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 11.05.2023.
//

import ReactiveSwift
import WebKit

extension DetailArticleVC: Makeable {
    static func make() -> DetailArticleVC { R.storyboard.detailArticle.detailArticleVC()! }
}

final class DetailArticleVC: BaseVC, ViewModelContainer {
    
    private enum C {
        static let getHTMLString = "document.documentElement.outerHTML"
    }
    
    // MARK: - IBOutlets
    @IBOutlet private weak var webView: WKWebView!
    
    // MARK: - Private Properties
    private lazy var saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
    private lazy var deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTapped))
    
    // MARK: - Life Cycle
    func didSetViewModel(_ viewModel: DetailArticleVM, lifetime: Lifetime) {
        setupWebView(with: viewModel.article.value.url)
        
        reactive.makeBindingTarget { vc, isSaved in
            vc.navigationItem.rightBarButtonItem = isSaved ? vc.deleteButton : vc.saveButton
        } <~ viewModel.isArticleAlreadySaved
    }
    
    private func getHTML(_ completion: @escaping (String) -> ()) {
        webView.evaluateJavaScript(C.getHTMLString) { (html, error) in
            guard let html = html as? String else { return }
            completion(html)
        }
    }
    
    private func setupWebView(with urlString: String?) {
        webView.navigationDelegate = self
        guard let urlString = viewModel.article.value.url,
              let url = URL(string: urlString) else { return }
        if viewModel.isArticleAlreadySaved.value, let htmlString = viewModel.article.value.html {
            webView.loadHTMLString(htmlString, baseURL: url)
        } else {
            webView.load(URLRequest(url: url))
        }
    }
    
    //MARK: - Actions
    @objc private func deleteTapped() {
        viewModel.deleteArticle()
    }
    
    @objc private func saveTapped() {
        getHTML { [weak self] htmlSring in
            self?.viewModel.article.value.html = htmlSring
            if let article = self?.viewModel.article.value {
                self?.viewModel.saveArticleAction.apply(article).start()
            }
        }
    }
}

// MARK: - WKNavigationDelegate
extension DetailArticleVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        startShowingActivity()
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        stopShowingActivity()
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopShowingActivity()
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
}
