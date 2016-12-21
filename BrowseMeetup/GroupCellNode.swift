//
//  GroupCellNode.swift
//  BrowseMeetup
//
//  Created by Ziad on 10/23/16.
//  Copyright © 2016 Intensify Studio. All rights reserved.
//

import AsyncDisplayKit

fileprivate let SmallFontSize: CGFloat = 12
fileprivate let FontSize: CGFloat = 12
fileprivate let OrganizerImageSize: CGFloat = 30
fileprivate let HorizontalBuffer: CGFloat = 10

final class GroupCellNode: ASCellNode {
    
    fileprivate var _organizerAvatarImageView: ASNetworkImageNode!
    fileprivate var _organizerNameLabel: ASTextNode!
    fileprivate var _locationLabel: ASTextNode!
    fileprivate var _timeIntervalSincePostLabel: ASTextNode!
    fileprivate var _photoImageView: ASNetworkImageNode!
    
    
    init(group: Group) {
        super.init()
        
        
        _organizerAvatarImageView = ASNetworkImageNode()
        _organizerAvatarImageView.cornerRadius = OrganizerImageSize/2
        _organizerAvatarImageView.clipsToBounds = true
        _organizerAvatarImageView?.url = group.organizer.thumbUrl
        
        _organizerNameLabel = createLayerBackedTextNode(attributedString: group.organizer.name.attributedString(fontSize: FontSize, color: UIColor.darkGray))
        
        _locationLabel = createLayerBackedTextNode(attributedString: group.location.attributedString(fontSize: SmallFontSize, color: UIColor.blue))
        _locationLabel?.maximumNumberOfLines = 1
        
        _timeIntervalSincePostLabel = createLayerBackedTextNode(attributedString: group.timeInterval.attributedString(fontSize: FontSize, color: UIColor.lightGray))
        
        _photoImageView = ASNetworkImageNode()
        _photoImageView?.url = group.photoUrl
        
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        _locationLabel.style.flexShrink = 1.0
        _organizerNameLabel.style.flexShrink = 1.0
        
        let headerSubStack = ASStackLayoutSpec.vertical()
        headerSubStack.children = [_organizerNameLabel, _locationLabel]
    
        _organizerAvatarImageView.style.preferredSize = CGSize(width: OrganizerImageSize, height: OrganizerImageSize)
        
        let spacer = ASLayoutSpec()
        spacer.style.flexGrow = 1.0
        
        let avatarInsets = UIEdgeInsets(top: HorizontalBuffer, left: 0, bottom: HorizontalBuffer, right: HorizontalBuffer)
        let avatarInset = ASInsetLayoutSpec(insets: avatarInsets, child: _organizerAvatarImageView)
        
        let headerStack = ASStackLayoutSpec.horizontal()
        headerStack.alignItems = ASStackLayoutAlignItems.center
        headerStack.justifyContent = ASStackLayoutJustifyContent.start
        headerStack.children = [avatarInset, headerSubStack, spacer, _timeIntervalSincePostLabel]
        
        let headerInsets = UIEdgeInsets(top: 0, left: HorizontalBuffer, bottom: 0, right: HorizontalBuffer)
        let headerWithInset = ASInsetLayoutSpec(insets: headerInsets, child: headerStack)
        
        let cellWidth = constrainedSize.max.width
        
        _photoImageView.style.preferredSize = CGSize(width: cellWidth, height: cellWidth)
        let photoImageViewAbsolute = ASAbsoluteLayoutSpec(children: [_photoImageView]) //ASStaticLayoutSpec(children: [_photoImageView])
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.alignItems = ASStackLayoutAlignItems.stretch
        verticalStack.children = [headerWithInset, photoImageViewAbsolute]
        
        return verticalStack
    }
    
    ///--------------------------------------
    // MARK - Helper Methods
    ///--------------------------------------
    
    fileprivate func createLayerBackedTextNode(attributedString: NSAttributedString) -> ASTextNode {
        let textNode = ASTextNode()
        textNode.isLayerBacked = true
        textNode.attributedText = attributedString
        
        return textNode
    }
}

