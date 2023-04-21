//
//  PrivacyPolicyView.swift
//  Concierge Services
//
//  Created by Slindelo Mathenjwa on 2023/03/28.
//

import SwiftUI
import WebKit


struct WebView: UIViewRepresentable {
    
    let htmlFile: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        
        guard let htmlPath = Bundle.main.path(forResource: htmlFile, ofType: "html") else { return }
        guard let htmlString = try? String(contentsOfFile: htmlPath, encoding: .utf8) else { return }
        
       
        let header = """
                <head>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
                    <style>
                        body {
                            font-family: "Avenir";
                            font-size: 26px;
                        }
                    </style>
                </head>
                <body>
                """
        webView.loadHTMLString(header + htmlString + "</body>", baseURL: nil)
    }
}
    
    struct PrivacyPolicyView: View {
        var body: some View {
            VStack(){
                Text("Privacy Policy")
                    .font(.system(size: 20, weight: .semibold, design: .monospaced))
                    .padding(20)
                
                WebView(htmlFile: "privacy")
            }
        }
    }

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
