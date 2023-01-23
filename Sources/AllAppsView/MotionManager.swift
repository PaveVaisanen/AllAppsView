//
//  File.swift
//  
//
//  Created by Pave Vaisanen on 13.1.2023.
//

import SwiftUI
import CoreMotion

@available(iOS 14, macOS 11.0, *)
class MotionManager: ObservableObject {
    
    private let motionManager = CMMotionManager()
    @Published var x = 0.0
    @Published var y = 0.0
    
    init() {
        
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.deviceMotionUpdateInterval = 0.05
        
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
            guard let motion = data?.attitude else { return }
            
            var x = motion.roll / Double.pi
            let y = motion.pitch / Double.pi
            
            if x > 0.5 {
                x = 1 - x
            } else if x < -0.5 {
                x = -1 - x
            }
            
            self?.x = x
            self?.y = y
        }
    }
    
    func getOrientation() -> UIInterfaceOrientation? {
        let scenes = UIApplication.shared.connectedScenes
        let scene = scenes.first as? UIWindowScene
        return scene?.interfaceOrientation
    }
    
    func correctXForDeviceOrientation() -> Double {
        guard let orientation = getOrientation() else { return 0 }
        switch orientation {
        case .portrait:
            return x
        case .portraitUpsideDown:
            return -x
        case .landscapeLeft:
            return -y
        case .landscapeRight:
            return y
        default:
            return 0
        }
    }
    
    func correctYForDeviceOrientation() -> Double {
        guard let orientation = getOrientation() else { return 0 }
        switch orientation {
        case .portrait:
            return y
        case .portraitUpsideDown:
            return -y
        case .landscapeLeft:
            return x
        case .landscapeRight:
            return -x
        default:
            return 0
        }
    }
    
}
