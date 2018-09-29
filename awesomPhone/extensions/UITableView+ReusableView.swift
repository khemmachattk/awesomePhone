import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        self.register(T.self,
                      forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T: UITableViewCell>(_: T.Type) where T: NibLoadable {
        self.register(T.nib,
                      forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T: UITableViewHeaderFooterView>(_: T.Type) where T: NibLoadable {
        self.register(T.nib,
                      forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
}
