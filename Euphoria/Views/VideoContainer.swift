//
//  VideoContainer.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/12/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class VideoContainer: UIView {
    var playerLayer: CALayer?
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        self.playerLayer?.frame = self.bounds
    }
}
