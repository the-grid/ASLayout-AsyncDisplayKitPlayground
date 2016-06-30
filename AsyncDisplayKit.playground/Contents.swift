//: Please build the scheme 'AsyncDisplayKitPlayground' first
import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

import AsyncDisplayKit

class CardBackgroundNetworkImageNode: ASNetworkImageNode {
    
    static let cardImage = UIImage(named: "profileRaw.png")
    
    override func placeholderImage() -> UIImage? {
        return CardBackgroundNetworkImageNode.cardImage
    }
}

class Root: ASDisplayNode, ASNetworkImageNodeDelegate {
    
    let backgroundNode = ASDisplayNode()
    let cardImageNode = CardBackgroundNetworkImageNode()
    let cardBackground = ASDisplayNode()
    
    override init() {
        cardImageNode.contentMode = .ScaleAspectFill
        cardImageNode.needsDisplayOnBoundsChange = false
        cardImageNode.layerBacked = true
        cardImageNode.placeholderEnabled = true
        cardImageNode.placeholderFadeDuration = 2.0
        cardImageNode.backgroundColor = UIColor.whiteColor()
        super.init()
        cardImageNode.delegate = self
        usesImplicitHierarchyManagement = true
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let rootSpec = ASBackgroundLayoutSpec(child: backgroundNode, background: cardImageNode)
        backgroundNode.preferredFrameSize = constrainedSize.max
        
        return rootSpec
        
    }
    
    // MARK: --- ASNetworkImageNodeDelegate ---
    
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

let url = NSURL(string: "https://thecatapi.com/api/images/get?format=src&type=png")
rootNode.cardImageNode.URL = url

XCPlaygroundPage.currentPage.liveView = rootNode.view


/* Here is the stuff I need to wrap my head around --- 🙀🙀🙀🙀🙀🙀
 
 ASStackLayoutSpec(direction: <#T##ASStackLayoutDirection#>, spacing: <#T##CGFloat#>, justifyContent: <#T##ASStackLayoutJustifyContent#>, alignItems: <#T##ASStackLayoutAlignItems#>, children: <#T##[ASLayoutable]#>)
 
 ASInsetLayoutSpec(insets: <#T##UIEdgeInsets#>, child: <#T##ASLayoutable#>)
 
 ASCenterLayoutSpec(centeringOptions: <#T##ASCenterLayoutSpecCenteringOptions#>, sizingOptions: <#T##ASCenterLayoutSpecSizingOptions#>, child: <#T##ASLayoutable#>)
 
 ASCenterLayoutSpec(horizontalPosition: <#T##ASRelativeLayoutSpecPosition#>, verticalPosition: <#T##ASRelativeLayoutSpecPosition#>, sizingOption: <#T##ASRelativeLayoutSpecSizingOption#>, child: <#T##ASLayoutable#>)
 
 ASStaticLayoutSpec(children: <#T##[ASStaticLayoutable]#>)
 
 ASRatioLayoutSpec(ratio: <#T##CGFloat#>, child: <#T##ASLayoutable#>)
 
 ASOverlayLayoutSpec(child: <#T##ASLayoutable#>, overlay: <#T##ASLayoutable?#>)
 
 ASRelativeLayoutSpec(horizontalPosition: <#T##ASRelativeLayoutSpecPosition#>, verticalPosition: <#T##ASRelativeLayoutSpecPosition#>, sizingOption: <#T##ASRelativeLayoutSpecSizingOption#>, child: <#T##ASLayoutable#>)
 */
