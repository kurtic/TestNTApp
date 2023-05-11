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
        static let saveButtonTitle = "Save"
    }
    
    // MARK: - IBOutlets
    @IBOutlet private weak var webView: WKWebView!
    
    // MARK: - Private Properties
    private lazy var saveButton = UIBarButtonItem(title: C.saveButtonTitle,
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(saveTapped))
    
    // MARK: - Life Cycle
    func didSetViewModel(_ viewModel: DetailArticleVM, lifetime: Lifetime) {
        setupWebView(with: viewModel.article.value?.url)
        if viewModel.article.value?.isSaved == false {
            navigationItem.rightBarButtonItem = saveButton
        }
    }
    
    private func getHTML(_ completion: @escaping (String) -> ()) {
        webView.evaluateJavaScript(C.getHTMLString) { (html, error) in
            guard let html = html as? String else { return }
            completion(html)
        }
    }
    
    private func setupWebView(with urlString: String?) {
        webView.navigationDelegate = self
        if viewModel.article.value?.isSaved == true {
            guard let urlString = viewModel.article.value?.html else { return }
            webView.loadHTMLString(urlString, baseURL: nil)
        } else {
            guard let urlString = urlString, let url = URL(string: urlString) else { return }
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    //MARK: - Actions
    @objc private func saveTapped() {
        getHTML { [weak self] htmlSring in
            self?.viewModel.article.value?.html = htmlSring
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
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        stopShowingActivity()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopShowingActivity()
    }
}
