#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import Translation
import SystemTranslation

@MainActor
@available(macOS 15.0, *)
public final class TranslationLanguageDownloadViewController: NSViewController {
    private enum Section {
        case main
    }

    private typealias DataSource = NSTableViewDiffableDataSource<Section, TranslationLanguageDownloadStatus>

    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, TranslationLanguageDownloadStatus>

    private let scrollView = NSScrollView()

    private let tableView = NSTableView()
    
    private let titleLabel = NSTextField(labelWithString: "Download Translation Languages")

    private let descriptionLabel = NSTextField(labelWithString: "Download translation languages to use the translation feature.")

    private lazy var doneButton = NSButton(title: "Done", target: self, action: #selector(doneAction))

    private let topStackView = NSStackView()

    private let bottomStackView = NSStackView()
    
    private lazy var dataSource = makeDataSource()

    private var downloadStatuses: [TranslationLanguageDownloadStatus] = []

    public override func loadView() {
        view = NSView()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        view.addSubview(topStackView)
        view.addSubview(bottomStackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        topStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            scrollView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor, constant: -20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
        scrollView.documentView = tableView
        scrollView.hasVerticalScroller = true
        scrollView.scrollerStyle = .overlay
        scrollView.borderType = .bezelBorder
        topStackView.orientation = .vertical
        topStackView.spacing = 10
        topStackView.distribution = .fill
        topStackView.alignment = .leading
        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(descriptionLabel)
        bottomStackView.orientation = .horizontal
        bottomStackView.spacing = 10
        bottomStackView.distribution = .gravityAreas
        bottomStackView.alignment = .centerY
        bottomStackView.addView(doneButton, in: .trailing)
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .labelColor
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .secondaryLabelColor
        doneButton.keyEquivalent = "\r"

        tableView.dataSource = dataSource
        tableView.headerView = nil
        tableView.rowHeight = 45
        tableView.selectionHighlightStyle = .none
        tableView.usesAlternatingRowBackgroundColors = true
        tableView.addTableColumn(.init(identifier: .init(.init(describing: Self.self))))

        Task {
            await fetchDownloadStatuses()
        }
    }

    @objc private func doneAction() {
        dismiss(nil)
    }

    private func fetchDownloadStatuses() async {
        downloadStatuses = await TranslationService.shared.languageDownloadStatuses
        reloadData()
    }

    private func reloadData() {
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
                        await self.fetchDownloadStatuses()
                        try await TranslationService.shared.prepareTranslation(in: self, source: downloadStatus.language, target: nil)
                        await self.fetchDownloadStatuses()
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

    private class TableCellView: NSTableCellView {
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
            downloadButton.symbolConfiguration = .init(pointSize: 18, weight: .regular)
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
