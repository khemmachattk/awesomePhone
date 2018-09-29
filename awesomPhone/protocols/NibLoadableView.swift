import UIKit

protocol NibLoadable: class {
    static var nib: UINib { get }
    static var nibName: String { get }
}

// MARK: General
extension NibLoadable {
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

// MARK: UIView
extension NibLoadable where Self: UIView {
    static var nib: UINib {
        return UINib(nibName: nibName,
                     bundle: Bundle(for: self))
    }
    
    static var loadView: Self {
        return nib.instantiate(withOwner: nil, options: nil).first as! Self
    }
}

// MARK: UIViewController
extension NibLoadable where Self: UIViewController {
    static var nib: UINib {
        return UINib(nibName: nibName,
                     bundle: Bundle(for: self))
    }
    
    static var viewController: Self {
        return Self(nibName: nibName, bundle: nil)
    }
}
