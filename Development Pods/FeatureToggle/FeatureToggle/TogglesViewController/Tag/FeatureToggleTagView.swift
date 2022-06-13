import UIKit

protocol FeatureToggleTagViewDelegate: AnyObject {
    
    func didSelectAll(for tagType: FeatureToggleTag.Type)
    func didSelectTag(_ tag: FeatureToggleTag, for tagType: FeatureToggleTag.Type)
    
}

protocol FeatureToggleTagViewProtocol: UIView {
    
    var delegate: FeatureToggleTagViewDelegate? { get set }
    var tags: [FeatureToggleTag] { get set }
    
    func selectAll()
    
}

final class FeatureToggleTagView<Tag: FeatureToggleTag>: UIView,
                                                         UICollectionViewDelegate,
                                                         UICollectionViewDataSource,
                                                         FeatureToggleTagViewProtocol {
    
    private struct AllButtonTag: FeatureToggleTag {
        let rawValue = "allButtonTag"
        let title = "All"
        let backgroundColor = UIColor.darkGray
    }
    
    weak var delegate: FeatureToggleTagViewDelegate?
    
    var tags: [FeatureToggleTag] = [] {
        didSet {
            _tags = [AllButtonTag()] + tags
            collectionView.reloadData()
        }
    }
    
    func selectAll() {
        collectionView.selectItem(
            at: IndexPath(item: 0, section: 0),
            animated: false,
            scrollPosition: .centeredHorizontally
        )
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(FeatureToggleTagCell.self, forCellWithReuseIdentifier: identifier)
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .systemBackground
        } else {
            collectionView.backgroundColor = .white
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    
    private lazy var identifier = String(describing: FeatureToggleTagCell.self)
    
    private var _tags: [FeatureToggleTag] = []
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
        
        let offset: CGFloat = 15
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: offset, bottom: 0, right: offset)
        flowLayout.itemSize = CGSize(width: 100, height: bounds.height - offset)
    }
    
    // MARK: - Private methods
    private func commonInit() {
        addSubview(collectionView)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tag = _tags[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FeatureToggleTagCell
       
        cell.currentBackgroundColor = tag.backgroundColor
        cell.setTitle(tag.title)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        if indexPath == IndexPath(item: 0, section: 0) {
            delegate?.didSelectAll(for: Tag.self)
        } else {
            delegate?.didSelectTag(_tags[indexPath.row], for: Tag.self)
        }
    }
}
