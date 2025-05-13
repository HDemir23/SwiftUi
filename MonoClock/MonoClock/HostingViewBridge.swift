//
//  HostingViewBridge.swift
//  MonoClock
//
//  Created by Hakan Demir on 28.04.2025.
//

import SwiftUI

@objc(HostingViewBridge)
class HostingViewBridge: NSView {
    private var hostingView: NSHostingView<MonoClock>?

    @objc override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupHostingView()
    }

    @objc required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHostingView()
    }

    private func setupHostingView() {
        let swiftUIView = MonoClock()
        let host = NSHostingView(rootView: swiftUIView)
        host.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(host)

        NSLayoutConstraint.activate([
            host.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            host.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            host.topAnchor.constraint(equalTo: self.topAnchor),
            host.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
