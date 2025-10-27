// EmojiDictionary

import UIKit

private let headerKind = "header"

class EmojiCollectionViewController: UICollectionViewController {
    @IBOutlet var layoutButton: UIBarButtonItem!
    
    var emojis: [Emoji] = [
        Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),
        Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
        Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with hearts for eyes.", usage: "love of something; attractive"),
        Emoji(symbol: "🧑‍💻", name: "Developer", description: "A person working on a MacBook (probably using Xcode to write iOS apps in Swift).", usage: "apps, software, programming"),
        Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "Something slow"),
        Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant.", usage: "good memory"),
        Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti.", usage: "spaghetti"),
        Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
        Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
        Emoji(symbol: "📚", name: "Stack of Books", description: "Three colored books stacked on each other.", usage: "homework, studying"),
        Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"),
        Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
        Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage: "completion")
    ]
    
    private var layout: [Layout: UICollectionViewLayout] = [:]
    
    private var collectionDataSource: UICollectionViewDiffableDataSource<String, Emoji.ID>!
    private var emojiIdentifiersSnapshot: NSDiffableDataSourceSnapshot<String, Emoji.ID> {
        var snapshot = NSDiffableDataSourceSnapshot<String, Emoji.ID>()
        
//        snapshot.appendSections(["Main"])
//        snapshot.appendItems(emojis.sorted(by: { $0.name < $1.name }).map(\.id))
        
        let grouped = Dictionary(grouping: emojis, by: { $0.sectionTitle})
        
        for (title, emojis) in grouped.sorted(by: { $0.0 < $1.0}) {
            snapshot.appendSections([title])
            snapshot.appendItems(emojis.sorted(by: { $0.name < $1.name}).map(\.id))
        }
        
        return snapshot
    }
    
    var activeLayout: Layout = .grid{
        didSet {
            if let layout = layout[activeLayout] {
                var snapshot = collectionDataSource.snapshot()
                let visibleIDs =
                collectionView.indexPathsForVisibleItems.compactMap {
                    collectionDataSource.itemIdentifier(for: $0)
                }
                snapshot.reloadItems(visibleIDs)
                collectionDataSource.apply(snapshot)
                
                collectionView.setCollectionViewLayout(layout, animated: true) { (_) in
                    switch self.activeLayout {
                    case .grid:
                        self.layoutButton.image = UIImage(systemName: "rectangle.grid.1x2")
                    case .column:
                        self.layoutButton.image = UIImage(systemName: "square.grid.2x2")
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout[.grid] = generateGridLayout()
        layout[.column] = generateColumnLayout()
        
        
        if let layout = layout[activeLayout] {
            collectionView.collectionViewLayout = layout
        }
        configureDataSource()
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<EmojiCollectionViewHeader>(elementKind: headerKind) {
            [weak self] supplementaryView, elementKind, IndexPath in
            guard let self else { return }
            let snapshot = collectionDataSource.snapshot()
            let sectionID = snapshot.sectionIdentifiers[IndexPath.section]
            
            supplementaryView.titleLabel.text = sectionID
        }
        
        collectionDataSource.supplementaryViewProvider = {
            collectionView, elementKind, IndexPath in
            collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: IndexPath)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionDataSource.apply(emojiIdentifiersSnapshot, animatingDifferences: true)
    }
    
    func generateColumnLayout() -> UICollectionViewLayout {
        let padding: CGFloat = 10
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitem: item, count: 1)
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = padding
        
        section.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: 0, bottom: padding, trailing: 0)
        
        section.boundarySupplementaryItems = [generateHeader()]
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    func generateGridLayout() -> UICollectionViewLayout {
        let padding: CGFloat = 20
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/4)
            ),
            subitem: item,
            count: 2
        )
        
        group.interItemSpacing = .fixed(padding)
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = padding
        section.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: 0, bottom: padding, trailing: 0)
        
        section.boundarySupplementaryItems = [generateHeader()]

        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func generateHeader() -> NSCollectionLayoutBoundarySupplementaryItem{
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(40)
            ),
            elementKind: headerKind,
            alignment: .top
        )
        header.pinToVisibleBounds = true
        
        return header
    }
    
    func configureDataSource() {
        let cellHandler: UICollectionView.CellRegistration<EmojiCollectionViewCell, Emoji.ID>.Handler = { [weak self] cell, indexPath, itemIdentifier in
            //Step 2: Fetch model object to display
            guard let self,
                let emoji = emojis.first(where: { $0.id == itemIdentifier}) else {
                return
            }

            //Step 3: Configure cell
            cell.update(with: emoji)
        }
        
        // Two registration handlers to display the same cell with a different associated layout
        let itemNib = UINib(nibName: "EmojiCollectionViewCell+Item", bundle: Bundle(for: EmojiCollectionViewCell.self))
        let itemCellRegistration = UICollectionView.CellRegistration<EmojiCollectionViewCell, Emoji.ID>(cellNib: itemNib, handler: cellHandler)
        
        let columnItemNib = UINib(nibName: "EmojiCollectionViewCell+ColumnItem", bundle: Bundle(for: EmojiCollectionViewCell.self))
        let columnItemCellRegistration = UICollectionView.CellRegistration<EmojiCollectionViewCell, Emoji.ID>(cellNib: columnItemNib, handler: cellHandler)
        
        collectionDataSource = UICollectionViewDiffableDataSource<String, Emoji.ID>(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self else { return nil }
            
            let registration = activeLayout == .grid ? itemCellRegistration :  columnItemCellRegistration
            
            return collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
        }
        
        
    }
    
    @IBAction func switchLayouts(sender: UIBarButtonItem) {
        switch activeLayout {
        case .grid:
            activeLayout = .column
        case .column:
            activeLayout = .grid
        }
    }

    @IBSegueAction func addEmoji(_ coder: NSCoder, sender: Any?) -> AddEditEmojiTableViewController? {
        return AddEditEmojiTableViewController(coder: coder, emoji: nil)
    }
    
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind",
            let sourceViewController = segue.source as? AddEditEmojiTableViewController,
            let emoji = sourceViewController.emoji else { return }
        
        if let i = emojis.firstIndex(where: {$0 == emoji}) {
            emojis[i] = emoji
            var snapshot = collectionDataSource.snapshot()
            snapshot.reconfigureItems([emoji.id])
            collectionDataSource.apply(snapshot, animatingDifferences: true)
        } else {
            emojis.append(emoji)
            collectionDataSource.apply(emojiIdentifiersSnapshot, animatingDifferences: true)
        }
    }

    // MARK: - UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let emojiID = collectionDataSource.itemIdentifier(for: indexPath),
        let emojiToEdit = emojis.first(where: { $0.id == emojiID }) else {
            return
        }
        
        // Editing Emoji
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: AddEditEmojiTableViewController.self))
        let editController = storyboard.instantiateViewController(identifier: "AddEditEmojiTableViewController") { coder in
            AddEditEmojiTableViewController(coder: coder, emoji: emojiToEdit)
        }
        
        let navigationController = UINavigationController(rootViewController: editController)
        present(navigationController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (elements) -> UIMenu? in
            let delete = UIAction(title: "Delete") { (action) in
                self.deleteEmoji(at: indexPath)
            }
            
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [delete])
        }
        
        return config
    }

    func deleteEmoji(at indexPath: IndexPath) {
        guard let emojiID = collectionDataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        emojis.removeAll{ $0.id == emojiID }
        collectionDataSource.apply(emojiIdentifiersSnapshot, animatingDifferences: true)
    }
}
