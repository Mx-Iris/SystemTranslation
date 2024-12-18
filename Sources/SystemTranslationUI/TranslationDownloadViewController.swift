#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import Translation
import SystemTranslation

@available(macOS 15.0, *)
public final class TranslationDownloadViewController: NSViewController {
    enum Section {
        case main
    }

    typealias DataSource = NSTableViewDiffableDataSource<Section, TranslationLanguageDownloadStatus>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, TranslationLanguageDownloadStatus>

    let scrollView = NSScrollView()

    let tableView = NSTableView()

    private lazy var dataSource = makeDataSource()

    @MainActor
    private var downloadStatuses: [TranslationLanguageDownloadStatus] = []

    public override func loadView() {
        view = NSView()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        scrollView.documentView = tableView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        tableView.dataSource = dataSource
        tableView.headerView = nil
        tableView.rowHeight = 45
        tableView.selectionHighlightStyle = .none
        tableView.usesAlternatingRowBackgroundColors = true
        tableView.addTableColumn(.init(identifier: .init(.init(describing: Self.self))))

        fetchDownloadStatuses()
    }

    func fetchDownloadStatuses() {
        Task {
            downloadStatuses = await TranslationService.shared.languageDownloadStatuses
            reloadData()
        }
    }

    @MainActor
    func reloadData() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(downloadStatuses, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func makeDataSource() -> DataSource {
        DataSource(tableView: tableView) { [weak self] tableView, _, _, downloadStatus in
            guard let self else { return NSView() }
            let cellView = tableView.makeView(ofClass: TableCellView.self)
            cellView.title = downloadStatus.language.friendlyName
            cellView.isDownloaded = downloadStatus.isDownloaded
            cellView.downloadButtonClicked = {
                Task {
                    do {
                        try await TranslationService.shared.prepareTranslation(in: self, source: downloadStatus.language, target: nil)
                        self.fetchDownloadStatuses()
                    } catch {
                        await MainActor.run {
                            if let window = self.view.window {
                                NSAlert(error: error).beginSheetModal(for: window)
                            } else {
                                NSAlert(error: error).runModal()
                            }
                        }
                    }
                }
            }
            return cellView
        }
    }

    class TableCellView: NSTableCellView {
        var downloadButtonClicked: (() -> Void)?

        var title: String = "" {
            didSet {
                titleLabel.stringValue = title
            }
        }

        var isDownloaded: Bool = false {
            didSet {
                if isDownloaded {
                    downloadButton.image = NSImage(systemSymbolName: "checkmark.circle", accessibilityDescription: "Downloaded")
                    downloadButton.contentTintColor = .systemGreen
                } else {
                    downloadButton.image = NSImage(systemSymbolName: "arrow.down.circle", accessibilityDescription: "Download")
                    downloadButton.contentTintColor = .systemBlue
                }
            }
        }

        let titleLabel = NSTextField(labelWithString: "")
        let downloadButton = NSButton()

        override init(frame frameRect: NSRect) {
            super.init(frame: frameRect)
            addSubview(titleLabel)
            addSubview(downloadButton)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            downloadButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                downloadButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                downloadButton.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 10),
            ])
            downloadButton.isBordered = false
            downloadButton.target = self
            downloadButton.action = #selector(downloadButtonAction)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        @objc func downloadButtonAction() {
            guard !isDownloaded else { return }
            downloadButtonClicked?()
        }
    }
}

extension NSTableView {
    func makeView<View: NSView>(ofClass viewClass: View.Type, modify: ((View) -> Void)? = nil) -> View {
        if let cellView = makeView(withIdentifier: .init(String(describing: viewClass)), owner: nil) as? View {
            modify?(cellView)
            return cellView
        } else {
            let cellView = View()
            cellView.identifier = .init(String(describing: viewClass))
            modify?(cellView)
            return cellView
        }
    }
}

#endif
