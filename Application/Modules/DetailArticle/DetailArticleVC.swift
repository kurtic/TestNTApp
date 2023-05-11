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
    // MARK: - IBOutlets
    @IBOutlet private weak var webView: WKWebView!
    
    // MARK: - Life Cycle
    func didSetViewModel(_ viewModel: DetailArticleVM, lifetime: Lifetime) {
        setupWebView(with: viewModel.article.value?.url)
        
    }
    
    func getHTML(_ completion: @escaping (String) -> ()) {
        webView.evaluateJavaScript("document.documentElement.outerHTML") { (html, error) in
            guard let html = html as? String else {
                print(error)
                return
            }
            completion(html)
        }
    }
    
    func setupWebView(with urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        webView.navigationDelegate = self
        let request = URLRequest(url: url)
        webView.load(request)
//        getHTML { htmlSring in
//            print(htmlSring)
//        }
    }
    
    @IBAction private func saveTapped(_ sender: Any) {
        getHTML { htmlSring in
            print(htmlSring)
        }
    }
}

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
