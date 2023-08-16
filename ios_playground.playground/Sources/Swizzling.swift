import Foundation

import UIKit
public extension UIColor {

    @objc func colorDescription() -> String {
        return "Printing rainbow colours."
    }

    private static let swizzleDesriptionImplementation: Void = {
        let instance: UIColor = UIColor.red
        let aClass: AnyClass! = object_getClass(instance)
        let originalMethod = class_getInstanceMethod(aClass, #selector(description))
        let swizzledMethod = class_getInstanceMethod(aClass, #selector(colorDescription))
        if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
        // switch implementation..
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }()

    static func swizzleDesription() {
        _ = self.swizzleDesriptionImplementation
    }
}

public class Swizzling {
    public static func run() {
        print(UIColor.red)
        print(UIColor.green)
        UIColor.swizzleDesription()
        print("\nswizzled\n")
        print(UIColor.red)
        print(UIColor.red)
        UIColor.swizzleDesription()
        print("\nTrying to swizzle again\n")
        print(UIColor.red)
        print(UIColor.red)
    }
}
