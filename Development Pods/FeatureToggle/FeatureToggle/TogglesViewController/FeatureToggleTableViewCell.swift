import Foundation
import UIKit

final class FeatureToggleTableViewCell: UITableViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    // MARK: - Subviews
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let identifierLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    // MARK: - State
    private var onValueChange: ((String) -> Void)?

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: FeatureToggleTableViewCell.reuseIdentifier)

        selectionStyle = .none
        segmentedControl.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)

        contentView.addSubview(descriptionLabel)
        contentView.addSubview(identifierLabel)
        contentView.addSubview(segmentedControl)

        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true

        identifierLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4).isActive = true
        identifierLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        identifierLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true

        segmentedControl.topAnchor.constraint(equalTo: identifierLabel.bottomAnchor, constant: 8).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        segmentedControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        onValueChange = nil
    }

    // MARK: - Configure
    func configure(
        description: String,
        identifier: String,
        allowedValues: [String],
        currentValue: String,
        onValueChange: @escaping (String) -> Void) {
        descriptionLabel.text = description
        identifierLabel.text = identifier
        segmentedControl.removeAllSegments()

        allowedValues.enumerated().forEach { index, title in
            segmentedControl.insertSegment(withTitle: title, at: index, animated: false)
        }

        segmentedControl.selectedSegmentIndex = allowedValues.firstIndex(of: currentValue) ?? 0

        self.onValueChange = onValueChange
    }

    // MARK: - Private
    @objc private func handleSwitch() {
        let index = segmentedControl.selectedSegmentIndex
        if let title = segmentedControl.titleForSegment(at: index) {
            onValueChange?(title)
        } else {
            assertionFailure()
        }
    }
}
