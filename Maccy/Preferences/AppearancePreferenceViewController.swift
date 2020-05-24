import Cocoa
import Preferences

class AppearancePreferenceViewController: NSViewController, PreferencePane {
  public let preferencePaneIdentifier = PreferencePane.Identifier.appearance
  public let preferencePaneTitle = "Appearance"
  public let toolbarItemIcon = NSImage(named: NSImage.colorPanelName)!

  override var nibName: NSNib.Name? { "AppearancePreferenceViewController" }

  @IBOutlet weak var popupAtButton: NSPopUpButton!
  @IBOutlet weak var imageHeightSlider: NSSlider!
  @IBOutlet weak var imageHeightLabel: NSTextField!
  @IBOutlet weak var showMenuIconButton: NSButton!
  @IBOutlet weak var showSearchFieldButton: NSButton!
  @IBOutlet weak var showTitleButton: NSButton!
  @IBOutlet weak var showFooterButton: NSButton!

  override func viewWillAppear() {
    super.viewWillAppear()
    populatePopupPosition()
    populateImageHeight()
    populateShowMenuIcon()
    populateShowSearchField()
    populateShowTitle()
    populateShowFooter()
  }

  @IBAction func popupPositionChanged(_ sender: NSPopUpButton) {
    switch sender.title {
    case "Screen center":
      UserDefaults.standard.popupPosition = "center"
    case "Menu icon":
      UserDefaults.standard.popupPosition = "statusItem"
    default:
      UserDefaults.standard.popupPosition = "cursor"
    }
  }

  @IBAction func imageHeightChanged(_ sender: NSSlider) {
    let old = String(UserDefaults.standard.imageMaxHeight)
    let new = String(imageHeightSlider.integerValue)
    updateImageHeightLabel(old: old, new: new)
    UserDefaults.standard.imageMaxHeight = sender.integerValue
  }

  @IBAction func showMenuIconChanged(_ sender: NSButton) {
    UserDefaults.standard.showInStatusBar = (sender.state == .on)
  }

  @IBAction func showSearchFieldChanged(_ sender: NSButton) {
    UserDefaults.standard.hideSearch = (sender.state == .off)
  }

  @IBAction func showTitleChanged(_ sender: NSButton) {
    UserDefaults.standard.hideTitle = (sender.state == .off)
  }

  @IBAction func showFooterChanged(_ sender: NSButton) {
    UserDefaults.standard.hideFooter = (sender.state == .off)
  }

  private func populatePopupPosition() {
    switch UserDefaults.standard.popupPosition {
    case "center":
      popupAtButton.selectItem(withTitle: "Screen center")
    case "statusItem":
      popupAtButton.selectItem(withTitle: "Menu icon")
    default:
      popupAtButton.selectItem(withTitle: "Cursor")
    }
  }

  private func populateImageHeight() {
    imageHeightSlider.integerValue = UserDefaults.standard.imageMaxHeight
    let new = String(imageHeightSlider.integerValue)
    updateImageHeightLabel(old: "{imageHeight}", new: new)
  }

  private func updateImageHeightLabel(old: String, new: String) {
    let newLabelValue = imageHeightLabel.stringValue.replacingOccurrences(
      of: old,
      with: new,
      options: [],
      range: imageHeightLabel.stringValue.range(of: old)
    )
    imageHeightLabel.stringValue = newLabelValue
  }

  private func populateShowMenuIcon() {
    showMenuIconButton.state = UserDefaults.standard.showInStatusBar ? .on : .off
  }

  private func populateShowSearchField() {
    showSearchFieldButton.state = UserDefaults.standard.hideSearch ? .off : .on
  }

  private func populateShowTitle() {
    showTitleButton.state = UserDefaults.standard.hideTitle ? .off : .on
  }

  private func populateShowFooter() {
    showFooterButton.state = UserDefaults.standard.hideFooter ? .off : .on
  }
}