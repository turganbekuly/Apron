import UIKit

public final class FeatureToggleViewController: UIViewController,
                                                UITableViewDelegate,
                                                UITableViewDataSource,
                                                UISearchBarDelegate,
                                                FeatureToggleTagViewDelegate {
    
    private enum Spec {
        static let searchBarHeight: CGFloat = 60
        static let tagViewHeight: CGFloat = 50
    }
    
    private lazy var tags: [FeatureToggleTagStorage] = [
        FeatureToggleTagStorage(
            type: FeatureToggleTeamTag.self,
            currentTag: .all,
            allCases: FeatureToggleTeamTag.allCases,
            view: FeatureToggleTagView<FeatureToggleTeamTag>()
        )
    ]
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private lazy var searchBar: UISearchBar = {
        let frame = CGRect(
            x: 0,
            y: navigationController?.navigationBar.frame.maxY ?? 0,
            width: view.bounds.width,
            height: Spec.searchBarHeight
        )
        
        let searchBar = UISearchBar(frame: frame)
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        if #available(iOS 13.0, *) {
            searchBar.backgroundColor = .systemBackground
        } else {
            searchBar.backgroundColor = .white
        }
        searchBar.backgroundImage = .init()
        return searchBar
    }()
    
    private var toggles = TogglesStorage.allToggles
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.addSubview(searchBar)
   
        var tagViewMaxY = searchBar.frame.maxY
        
        tags.enumerated().forEach { index, tag in
            let tagView = tag.view
            tagView.frame = CGRect(
                x: 0,
                y: searchBar.frame.maxY + CGFloat(index) * Spec.tagViewHeight,
                width: view.bounds.width,
                height: Spec.tagViewHeight
            )
            
            tagViewMaxY = tagView.frame.maxY
                       
            tagView.tags = tag.allCases
            tagView.delegate = self
            tagView.selectAll()
            
            view.addSubview(tagView)
        }
        
        tableView.frame = CGRect(
            x: 0,
            y: tagViewMaxY,
            width: view.bounds.width,
            height: view.bounds.height - tagViewMaxY
        )
      
        tableView.keyboardDismissMode = .onDrag
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.allowsSelection = false
        tableView.reloadData()
        
        let resetButton = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(reset))
        navigationItem.rightBarButtonItem = resetButton
    }
   
    // MARK: - Actions
    @objc private func reset() {
        FeatureToggle.reset()
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toggles.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let toggleTableViewCell: FeatureToggleTableViewCell
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: FeatureToggleTableViewCell.reuseIdentifier)
            as? FeatureToggleTableViewCell
        {
            toggleTableViewCell = cell
        } else {
            toggleTableViewCell = FeatureToggleTableViewCell()
        }
        
        let toggle = toggles[indexPath.row]
        let description = toggle.description
        let identifier = toggle.identifier
        let allowedValues = toggle.valueDescriptions
        let currentValue = FeatureToggle.valueDescription(forToggle: toggle) ?? ""
        let onValueChange: (String) -> Void = { valueDescription in
            FeatureToggle.set(valueDescription: valueDescription, forToggleIdentifier: toggle.identifier)
        }
        
        toggleTableViewCell.configure(
            description: description,
            identifier: identifier,
            allowedValues: allowedValues,
            currentValue: currentValue,
            onValueChange: onValueChange
        )

        return toggleTableViewCell
    }
    
    // MARK: - UISearchBarDelegate
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateToggles(with: searchText)
    }
    
    // MARK: - FeatureToggleTagViewDelegate
    func didSelectTag(_ tag: FeatureToggleTag, for tagType: FeatureToggleTag.Type) {
        updateTags(with: .tag(tag), for: tagType)
        updateToggles(with: searchBar.text ?? "")
    }
    
    func didSelectAll(for tagType: FeatureToggleTag.Type) {
        updateTags(with: .all, for: tagType)
        updateToggles(with: searchBar.text ?? "")
    }
    
    private func updateTags(with tag: FeatureToggleTagStorage.TagType, for tagType: FeatureToggleTag.Type) {
        var newTags: [FeatureToggleTagStorage] = []
             
        tags.forEach {
            if $0.type == tagType {
                newTags.append(.init(type: tagType, currentTag: tag, allCases: $0.allCases, view: $0.view))
            } else {
                newTags.append($0)
            }
        }
             
        tags = newTags
    }
    
    private func updateToggles(with text: String) {
        defer {
            tableView.reloadData()
        }
         
        var newToggles: [AbstractToggle.Type] = []
         
        for tagItem in tags {
            newToggles += TogglesStorage.allToggles.filter { $0.tags.contains { $0.rawValue == tagItem.currentTag.rawValue } }
        }
         
        let allToggles = newToggles.isEmpty ? TogglesStorage.allToggles : newToggles
        
        guard !text.isEmpty else {
            toggles = allToggles
            return
        }
                
        let searchText = text.lowercased()
                
        toggles = allToggles.filter {
            $0.identifier.lowercased().contains(searchText) || $0.description.lowercased().contains(searchText)
        }
    }
    
}
