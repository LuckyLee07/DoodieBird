//
//  LayoutHelper.h
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright FancyGame 2026年. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "cocos2d.h"

static const CGFloat kDBDesignWidth = 480.0f;
static const CGFloat kDBDesignHeight = 320.0f;

static inline CGFloat DBLayoutScale(CGSize winSize)
{
    return MIN(winSize.width / kDBDesignWidth, winSize.height / kDBDesignHeight);
}

static inline CGFloat DBLayoutOriginX(CGSize winSize)
{
    return (winSize.width - (kDBDesignWidth * DBLayoutScale(winSize))) * 0.5f;
}

static inline CGFloat DBLayoutOriginY(CGSize winSize)
{
    return (winSize.height - (kDBDesignHeight * DBLayoutScale(winSize))) * 0.5f;
}

static inline CGPoint DBLayoutPoint(CGSize winSize, CGFloat x, CGFloat y)
{
    const CGFloat scale = DBLayoutScale(winSize);
    return ccp(DBLayoutOriginX(winSize) + (x * scale),
               DBLayoutOriginY(winSize) + (y * scale));
}

static inline CGPoint DBLayoutOffset(CGSize winSize, CGFloat x, CGFloat y)
{
    const CGFloat scale = DBLayoutScale(winSize);
    return ccp(x * scale, y * scale);
}

static inline CGPoint DBLayoutLocalPoint(CGSize winSize, CGFloat x, CGFloat y)
{
    return DBLayoutOffset(winSize,
                          x - (kDBDesignWidth * 0.5f),
                          y - (kDBDesignHeight * 0.5f));
}

static inline CGFloat DBLayoutValue(CGSize winSize, CGFloat value)
{
    return value * DBLayoutScale(winSize);
}

static inline BOOL DBShouldUseWideAssets(CGSize winSize)
{
    return winSize.height > 0.0f && (winSize.width / winSize.height) > 1.7f;
}

static inline NSString *DBWideAssetName(NSString *filename, CGSize winSize)
{
    if (filename == nil || !DBShouldUseWideAssets(winSize))
    {
        return filename;
    }

    NSRange dotRange = [filename rangeOfString:@"." options:NSBackwardsSearch];
    if (dotRange.location == NSNotFound)
    {
        return filename;
    }

    NSString *wideFilename = [NSString stringWithFormat:@"%@_wide%@",
                              [filename substringToIndex:dotRange.location],
                              [filename substringFromIndex:dotRange.location]];

    NSString *widePath = [[CCFileUtils sharedFileUtils] fullPathFromRelativePath:wideFilename];
    if (widePath != nil && [widePath length] > 0)
    {
        return wideFilename;
    }

    return filename;
}

static inline void DBLayoutCoverSprite(CCSprite *sprite, CGSize winSize)
{
    if (!sprite)
    {
        return;
    }

    const CGSize spriteSize = sprite.contentSize;
    if (spriteSize.width <= 0.0f || spriteSize.height <= 0.0f)
    {
        return;
    }

    sprite.anchorPoint = ccp(0.5f, 0.5f);
    sprite.position = ccp(winSize.width * 0.5f, winSize.height * 0.5f);
    sprite.scale = MAX(winSize.width / spriteSize.width, winSize.height / spriteSize.height);
}
