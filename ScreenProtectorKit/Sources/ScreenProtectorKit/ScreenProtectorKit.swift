import UIKit

public enum ScreenProtectionMode {
    case fullApp
    case singleScreen(UIViewController)
    case multipleScreens([UIViewController])
}

public enum ScreenProtectionOverlay {
    case white
    case black
    case custom(UIView)
}

@MainActor
public final class ScreenProtectorKit {
    
    public static let shared = ScreenProtectorKit()
    private init() {}
    
    private var protectedControllers: [UIViewController] = []
    private var overlayViewTag = 888888
    private var overlayType: ScreenProtectionOverlay = .black
    
    public func enableProtection(_ mode: ScreenProtectionMode,
                                 overlay: ScreenProtectionOverlay = .black) {
        self.overlayType = overlay
        
        switch mode {
        case .fullApp:
            if let window = UIApplication.shared.windows.first {
                protect(view: window)
            }
        case .singleScreen(let vc):
            protect(view: vc.view)
            protectedControllers.append(vc)
        case .multipleScreens(let vcs):
            vcs.forEach {
                protect(view: $0.view)
                protectedControllers.append($0)
            }
        }
        
        listenForScreenCapture()
    }
    
    public func disableProtection() {
        removeAllOverlays()
        NotificationCenter.default.removeObserver(self)
    }
    
    private func protect(view: UIView) {
        let field = UITextField()
        field.isSecureTextEntry = true
        view.addSubview(field)
        field.center = view.center
        view.layer.superlayer?.addSublayer(field.layer)
        field.isHidden = true
    }
    
    private func listenForScreenCapture() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(screenCaptureChanged),
            name: UIScreen.capturedDidChangeNotification,
            object: nil
        )
    }
    
    @objc private func screenCaptureChanged() {
        if UIScreen.main.isCaptured {
            showOverlay()
        } else {
            hideOverlay()
        }
    }
    
    private func showOverlay() {
        guard let window = UIApplication.shared.windows.first else { return }
        if window.viewWithTag(overlayViewTag) != nil { return }
        
        let overlay: UIView
        switch overlayType {
        case .white:
            overlay = UIView(frame: window.bounds)
            overlay.backgroundColor = .white
        case .black:
            overlay = UIView(frame: window.bounds)
            overlay.backgroundColor = .black
        case .custom(let customView):
            overlay = customView
            overlay.frame = window.bounds
        }
        
        overlay.tag = overlayViewTag
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        window.addSubview(overlay)
    }
    
    private func hideOverlay() {
        UIApplication.shared.windows.first?.viewWithTag(overlayViewTag)?.removeFromSuperview()
    }
    
    private func removeAllOverlays() {
        hideOverlay()
        protectedControllers.removeAll()
    }
}
