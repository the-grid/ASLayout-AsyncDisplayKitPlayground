import Foundation
/*
class OverlayNode: ASDisplayNode {
    
    let contentTextNode = ASTextNode()
    var title: String = ""
    var body: String = ""
    var publisherName: String = ""
    var authorName: String = ""
    var authorAvatarURL: NSURL?
    var titleFontSize: CGFloat = 0
    var bodyFontSize: CGFloat = 0
    let paragraph = NSMutableParagraphStyle()
    let background = ASDisplayNode()
    var titleColor = ThemeManager.currentTheme.value.titleColor
    var bodyColor = ThemeManager.currentTheme.value.textColor
    var metaColor = ThemeManager.currentTheme.value.metaColor
    var attributionColor = ThemeManager.currentTheme.value.textPopColor
    var attribution2Color = ThemeManager.currentTheme.value.textPop2Color
    
    override init() {
        paragraph.alignment = NSTextAlignment.Left
        paragraph.lineBreakMode = NSLineBreakMode.ByWordWrapping
        contentTextNode.layerBacked = false
        contentTextNode.placeholderEnabled = false
        contentTextNode.truncationMode = NSLineBreakMode.ByTruncatingTail
        super.init()
        addSubnode(background)
        addSubnode(contentTextNode)
        ThemeManager.currentTheme.producer.startWithNext { theme in
            self.background.backgroundColor = ThemeManager.currentTheme.value.boxColor
            self.titleColor = ThemeManager.currentTheme.value.titleColor
            self.bodyColor = ThemeManager.currentTheme.value.textColor
            self.metaColor = ThemeManager.currentTheme.value.metaColor
            self.attributionColor = ThemeManager.currentTheme.value.textPopColor
            self.attribution2Color = ThemeManager.currentTheme.value.textPop2Color
            self.setNeedsLayout()
        }
    }
    
    @available(*, unavailable)
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        //        println("deinit Overlay")
    }
    
    func setContent(title t: String?,
                          body b: String?,
                               publisherName pn: String?,
                                             authorName an: String?,
                                                        authorAvatarURL aau: NSURL?) {
        clear()
        title = t ?? ""
        body = b ?? ""
        publisherName = pn ?? ""
        authorName = an ?? ""
        authorAvatarURL = aau
        setNeedsLayout()
    }
    
    private func setNewString() {
        titleFontSize = frame.height / 14
        bodyFontSize = frame.height / 16
        paragraph.paragraphSpacing = bodyFontSize * 0.5
        
        // Note - paragraph.maximumLineHeight may be needed here,
        // but for now this seems correct
        
        let titleFont = FontLoader.getFontByName(FontName.SourceSansProRegular, size: titleFontSize)
        let titleAttrs = [NSFontAttributeName: titleFont, NSForegroundColorAttributeName: titleColor, NSParagraphStyleAttributeName: paragraph]
        let bodyFont = FontLoader.getFontByName(FontName.SourceSansProLight, size: bodyFontSize)
        let bodyAttrs = [NSFontAttributeName: bodyFont, NSForegroundColorAttributeName: bodyColor, NSParagraphStyleAttributeName: paragraph]
        let attributionNameAttrs = [NSFontAttributeName: bodyFont, NSForegroundColorAttributeName: attributionColor, NSParagraphStyleAttributeName: paragraph]
        let attributionAuthorAttrs = [NSFontAttributeName: bodyFont, NSForegroundColorAttributeName: attribution2Color, NSParagraphStyleAttributeName: paragraph]
        let attributionMetaAttrs = [NSFontAttributeName: bodyFont, NSForegroundColorAttributeName: metaColor, NSParagraphStyleAttributeName: paragraph]
        let bn = publisherName.isEmpty ? "\n" : ""
        let attrStringAuthorName = NSMutableAttributedString(string: "\(authorName)\(bn)", attributes : attributionNameAttrs)
        let attrStringFrom = NSMutableAttributedString(string: " from ", attributes : attributionMetaAttrs)
        let attrStringPublisherName = NSMutableAttributedString(string: "\(publisherName)\n", attributes : attributionAuthorAttrs)
        let tn = body.isEmpty ? "" : "\n"
        let attrStringTitle = NSMutableAttributedString(string: "\(title)\(tn)", attributes : titleAttrs)
        let attrStringBody = NSAttributedString(string: body, attributes : bodyAttrs)
        let content = NSMutableAttributedString()
        if !authorName.isEmpty {
            content.appendAttributedString(attrStringAuthorName)
        }
        if !publisherName.isEmpty {
            content.appendAttributedString(attrStringFrom)
            content.appendAttributedString(attrStringPublisherName)
        }
        if !title.isEmpty {
            content.appendAttributedString(attrStringTitle)
        }
        if !body.isEmpty {
            content.appendAttributedString(attrStringBody)
        }
        contentTextNode.attributedString = content
    }
    
    func clear() {
        title = ""
        body = ""
        publisherName = ""
        authorName = ""
        authorAvatarURL = .None
        textHeightScale = .None
        setNeedsLayout()
    }
    
    var textHeightScale: CGFloat? = .None
    let widthPercentage: CGFloat = 0.8
    let minHeightPercentage: CGFloat = 0.2
    let maxHeightPercentage: CGFloat = 0.7
    let paddingOffset: CGFloat = -0.05
    let trailingOffset: CGFloat = -0.05
    
    func recalculateSize() {
        setNewString()
        let fixedWidth = frame.width * widthPercentage
        let minHeight = frame.height * minHeightPercentage
        let maxHeight = frame.height * maxHeightPercentage
        let range = ASSizeRange(min: CGSize(width: fixedWidth, height: minHeight), max: CGSize(width: fixedWidth, height: maxHeight))
        let sizeRange = self.contentTextNode.calculateLayoutThatFits(range)
        textHeightScale = sizeRange.size.height / frame.height
        setNeedsLayout()
    }
    
    override func layout() {
        super.layout()
        guard let textHeightScalePercentage = textHeightScale else {
            recalculateSize()
            return
        }
        setNewString()
        let w = frame.width * widthPercentage
        let h = frame.height * textHeightScalePercentage
        
        let borderPad = frame.height * paddingOffset
        let textBottomPad = frame.height * trailingOffset
        
        let baseRect = CGRect(x: floor((frame.width - w) / 2), y: floor(frame.height - h), width: w, height: h)
        let textRect = baseRect.offsetBy(dx: 0, dy: floor(textBottomPad))
        
        var bgRect = baseRect.insetBy(dx: borderPad, dy: borderPad)
        bgRect.origin.x = (frame.width - bgRect.size.width) / 2
        bgRect.origin.y = frame.height - bgRect.size.height
        
        contentTextNode.frame = textRect
        background.frame = bgRect.integral
    }
}
 
 */