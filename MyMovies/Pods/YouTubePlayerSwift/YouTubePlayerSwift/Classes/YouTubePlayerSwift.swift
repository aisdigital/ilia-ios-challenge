
import UIKit;
import WebKit;

open class YouTubePlayerView: UIView, WKScriptMessageHandler {
    
    fileprivate var webView: WKWebView!
    
    // MARK: Various methods for initialization
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        buildWebView();
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildWebView();
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        // Remove web view in case it's within view hierarchy, reset frame, add as subview
        webView.removeFromSuperview()
        webView.frame = bounds
        addSubview(webView)
    }
    
    // MARK: Web view initialization
    
    fileprivate func buildWebView() {
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let config = WKWebViewConfiguration()
        config.preferences = preferences
        config.mediaTypesRequiringUserActionForPlayback = [];
        let userContent: WKUserContentController = WKUserContentController()
        userContent.add(
            self,
            name: "callbackHandler"
        )
        config.userContentController = userContent
        config.allowsInlineMediaPlayback = true
        
        let webView = WKWebView(frame: self.bounds, configuration: config)
        let userAgent = UIWebView().stringByEvaluatingJavaScript(from: "navigator.userAgent") ?? "Mozilla/5.0 (iPhone; CPU iPhone OS 11_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15F79"
        webView.customUserAgent = userAgent + " Safari";
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.scrollView.isScrollEnabled = false
        self.webView = webView;
        
        
    }
    
    // MARK: Player setup
    
    public func play(videoID:String) {
        webView.load(URLRequest(url: URL(string: "https://shareme.pro/youtube/" + videoID)!));
    }
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    public static func videoIDFromYouTubeURL(_ videoURL: URL) -> String? {
        if videoURL.pathComponents.count > 1 && (videoURL.host?.hasSuffix("youtu.be"))! {
            return videoURL.pathComponents[1]
        } else if videoURL.pathComponents.contains("embed") {
            return videoURL.pathComponents.last
        }
        return videoURL.queryStringComponents()["v"] as? String
    }

}

private extension URL {
    func queryStringComponents() -> [String: AnyObject] {
        
        var dict = [String: AnyObject]()
        
        // Check for query string
        if let query = self.query {
            
            // Loop through pairings (separated by &)
            for pair in query.components(separatedBy: "&") {
                
                // Pull key, val from from pair parts (separated by =) and set dict[key] = value
                let components = pair.components(separatedBy: "=")
                if (components.count > 1) {
                    dict[components[0]] = components[1] as AnyObject?
                }
            }
            
        }
        
        return dict
    }
}
