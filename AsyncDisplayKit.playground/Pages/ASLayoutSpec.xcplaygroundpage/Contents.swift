//: [Next - Some other demo](@next)

//: Please build the scheme 'AsyncDisplayKitPlayground' first
import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: ## AsyncDisplayKit - Using ASLayoutSpec
//:
//: Bla here we talk about important stuffs
//: regarding the node, caching, spec stuffs
//:
//: ----
//:
//: Some more important stuffs here

import AsyncDisplayKit

//: ## Explore the ASNetworkImageNode, and basic ASLayoutSpec
//:
//: What happens when you combine fast image loading, caching, decoding and display with offloading expensive operations? Cool things.


//: ### A Custom ASNetworkImageNode Node

class CardBackgroundNetworkImageNode: ASNetworkImageNode {
    
    static let cardImage = UIImage(named: "profileRaw.png")
    
    override func didLoad() {
        super.didLoad()
        contentMode = .ScaleAspectFill
        placeholderEnabled = true
        placeholderFadeDuration = 2.0
        backgroundColor = UIColor.whiteColor()
    }
    
    override func placeholderImage() -> UIImage? {
        return CardBackgroundNetworkImageNode.cardImage
    }
}

//: ### A Custom Node

class CardInfoOverlayNode: ASDisplayNode {
    
    let contentTextNode = ASTextNode()
    let title: String
    let body: String
    let publisherName: String
    let authorName: String
    
    let paragraph = NSMutableParagraphStyle()
    let background = ASDisplayNode()
    var titleColor = UIColor.darkTextColor()
    var bodyColor = UIColor.lightGrayColor()
    var metaColor = UIColor.lightGrayColor()
    var attributionColor = UIColor.magentaColor()
    var attribution2Color = UIColor.blueColor()
    
    static let titleFontSize: CGFloat = 32
    static let bodyFontSize: CGFloat = 16
    
    init (
        title t: String,
        body b: String,
        publisherName p: String,
        authorName a: String
        ) {
        // Setup text node
        paragraph.alignment = NSTextAlignment.Left
        paragraph.lineBreakMode = NSLineBreakMode.ByWordWrapping
        contentTextNode.layerBacked = true
        contentTextNode.placeholderEnabled = false
        contentTextNode.truncationMode = NSLineBreakMode.ByTruncatingTail
        title = t
        body = b
        publisherName = p
        authorName = a
        
        super.init()
        backgroundColor = UIColor.whiteColor()
        usesImplicitHierarchyManagement = true
                
        applyStyledContent()
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        contentTextNode.flexShrink = true
        
        let insets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let hSpecWithInset = ASInsetLayoutSpec(insets: insets, child: contentTextNode)
        
        return hSpecWithInset
    }
    
    private func applyStyledContent() {
        paragraph.paragraphSpacing = CardInfoOverlayNode.bodyFontSize * 0.4
        
        let titleFont = UIFont.systemFontOfSize(CardInfoOverlayNode.titleFontSize, weight: UIFontWeightRegular)
        let titleAttrs = [NSFontAttributeName: titleFont, NSForegroundColorAttributeName: titleColor, NSParagraphStyleAttributeName: paragraph]
        let bodyFont = UIFont.systemFontOfSize(CardInfoOverlayNode.bodyFontSize, weight: UIFontWeightThin)
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
}

class Root: ASDisplayNode, ASNetworkImageNodeDelegate {
    
    let backgroundNode = ASDisplayNode()
    let cardImageNode = CardBackgroundNetworkImageNode()
    let cardInfoOverlayNode = CardInfoOverlayNode(title: "Use Funtional Swift Wisely", body: "There is a little known secret about Swift functional programming. It get's absurd by overuse of custom operators and impossible to follow event streams. Then curry the cryptic operators and make a truly painful thing.", publisherName: "The Grid", authorName: "Nick Velloff")
    
    override init() {
        super.init()
        cardImageNode.delegate = self
        usesImplicitHierarchyManagement = true
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let relativeSpec = ASRelativeLayoutSpec(horizontalPosition: .Center, verticalPosition: .End, sizingOption: .MinimumHeight, child: cardInfoOverlayNode)
        
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let insetSpec = ASInsetLayoutSpec(insets: insets, child: relativeSpec)
        
        let backgroundSpec = ASBackgroundLayoutSpec(child: backgroundNode, background: cardImageNode)
        backgroundNode.preferredFrameSize = constrainedSize.max
        
        let 🙀 = ASOverlayLayoutSpec(child: backgroundSpec, overlay: insetSpec)
        
        return 🙀
        
    }
    
//: MARK: --- ASNetworkImageNodeDelegate ---
    func imageNode(imageNode: ASNetworkImageNode, didLoadImage image: UIImage) {
        print("didLoadImage")
    }
    
    func imageNodeDidStartFetchingData(imageNode: ASNetworkImageNode) {
        print("imageNodeDidStartFetchingData")
    }
    
    func imageNode(imageNode: ASNetworkImageNode, didFailWithError error: NSError) {
        print("didFailWithError: \(error)")
    }
    
    func imageNodeDidFinishDecoding(imageNode: ASNetworkImageNode) {
        print("imageNodeDidFinishDecoding")
    }
}

let rootNode = Root()
let origin = CGPointZero
let size = CGSize(width: 400, height: 400)
let constrainedSize = ASSizeRange(min: size, max: size)
rootNode.measureWithSizeRange(constrainedSize)
rootNode.frame = CGRect(origin: origin, size: size)

let url = NSURL(string: "https://thecatapi.com/api/images/get?format=src&type=gif")
rootNode.cardImageNode.URL = url

XCPlaygroundPage.currentPage.liveView = rootNode.view


/* Here is the stuffs I need to wrap my head around --- 🙀🙀🙀🙀🙀🙀
 
 ASStackLayoutSpec(direction: <#T##ASStackLayoutDirection#>, spacing: <#T##CGFloat#>, justifyContent: <#T##ASStackLayoutJustifyContent#>, alignItems: <#T##ASStackLayoutAlignItems#>, children: <#T##[ASLayoutable]#>)
 
 ASInsetLayoutSpec(insets: <#T##UIEdgeInsets#>, child: <#T##ASLayoutable#>)
 
 ASCenterLayoutSpec(centeringOptions: <#T##ASCenterLayoutSpecCenteringOptions#>, sizingOptions: <#T##ASCenterLayoutSpecSizingOptions#>, child: <#T##ASLayoutable#>)
 
 ASCenterLayoutSpec(horizontalPosition: <#T##ASRelativeLayoutSpecPosition#>, verticalPosition: <#T##ASRelativeLayoutSpecPosition#>, sizingOption: <#T##ASRelativeLayoutSpecSizingOption#>, child: <#T##ASLayoutable#>)
 
 ASStaticLayoutSpec(children: <#T##[ASStaticLayoutable]#>)
 
 ASRatioLayoutSpec(ratio: <#T##CGFloat#>, child: <#T##ASLayoutable#>)
 
 ASOverlayLayoutSpec(child: <#T##ASLayoutable#>, overlay: <#T##ASLayoutable?#>)
 
 ASRelativeLayoutSpec(horizontalPosition: <#T##ASRelativeLayoutSpecPosition#>, verticalPosition: <#T##ASRelativeLayoutSpecPosition#>, sizingOption: <#T##ASRelativeLayoutSpecSizingOption#>, child: <#T##ASLayoutable#>)
 */
