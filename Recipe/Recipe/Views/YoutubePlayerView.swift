//
//  YoutubePlayerView.swift
//  Recipe
//
//  Created by Joshua Lopez on 5/27/25.
//

import SwiftUI
import WebKit

struct YoutubePlayerView: UIViewRepresentable {
    let videoId: String
    func makeUIView(context: Context) ->  WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let demoURL = URL(string: "https://www.youtube.com/embed/\(videoId)") else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: demoURL))
    }
}

#Preview {
    YoutubePlayerView(videoId: "6R8ffRRJcrg")
}
