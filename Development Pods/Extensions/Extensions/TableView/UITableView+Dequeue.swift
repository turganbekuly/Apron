import UIKit

extension UITableView {

    public func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: "\(Cell.self)", for: indexPath) as? Cell else {
            fatalError("register(cellClass:) has not been implemented")
        }

        return cell
    }

    public func dequeueReusableHeaderFooterView<Cell: UITableViewHeaderFooterView>() -> Cell {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: "\(Cell.self)") as? Cell else {
            fatalError("register(aClass:) has not been implemented")
        }

        return view
    }

}
