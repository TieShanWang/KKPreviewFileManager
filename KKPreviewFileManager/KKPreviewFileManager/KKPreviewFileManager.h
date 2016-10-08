//
//  PreviewFileManager.h
//  Cal
//
//  Created by MR.KING on 16/2/20.
//  Copyright © 2016年 EBJ. All righUI reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FileOperationSuccess,
    FileOperationFail
} FileOperationState;

typedef void(^FileOperation)(FileOperationState state,const NSString * result);




@interface KKPreviewFileManager : NSObject
{
    UIDocumentInteractionController * _documentController;
}

@property(nonatomic,strong)UIDocumentInteractionController * documentController;
@property(nonatomic,copy)NSString * filePath;

-(void)previewFile:(NSString*)path inView:(UIView*)showView operateResult:(FileOperation)operate;

@end
