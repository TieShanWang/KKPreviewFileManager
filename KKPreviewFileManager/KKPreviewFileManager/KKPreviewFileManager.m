//
//  PreviewFileManager.m
//  Cal
//
//  Created by MR.KING on 16/2/20.
//  Copyright © 2016年 EBJ. All righUI reserved.
//

#import "KKPreviewFileManager.h"

const NSString * success = @"操作成功";
const NSString * fileNotExist = @"文件不存在";
const NSString * fileIsDirectory = @"文件是文件夹";
const NSString * filePathNil = @"文件路径为空";
const NSString * showViewNil = @"显示的图层为空";
const NSString * noApplicationToOpen = @"没有应用可以打开此文件";

@interface KKPreviewFileManager()<UIDocumentInteractionControllerDelegate>
{
    NSFileManager * fileManager;
}
@property(nonatomic,copy)FileOperation operation;


@end

@implementation KKPreviewFileManager


- (instancetype)init
{
    self = [super init];
    if (self) {
        fileManager = [NSFileManager defaultManager];
    }
    return self;
}




-(void)previewFile:(NSString*)path inView:(UIView*)showView operateResult:(FileOperation)operate{
    
    self.operation = operate;
    
    if (!showView) {
        self.operation(FileOperationFail,showViewNil);
    }
    
    if (([path length] == 0) || !path ) {
        self.operation(FileOperationFail,filePathNil);
    }
    
    BOOL isDirectory ;
    
    BOOL exist = [fileManager fileExistsAtPath:path isDirectory:&isDirectory];
    
    if (!exist) {
        self.operation(FileOperationFail,fileNotExist);
        return;
    }
    
    if (exist) {
        if (isDirectory) {
            self.operation(FileOperationFail,fileIsDirectory);
            return;
        }
    }
    
    self.filePath = path;
    
    _documentController = [UIDocumentInteractionController
     
     interactionControllerWithURL:[NSURL fileURLWithPath:path]];
    
     _documentController.delegate = self;
    
    BOOL canOpen = [_documentController presentOpenInMenuFromRect:CGRectZero
     
                                           inView:showView
     
                                         animated:YES];
    if (!canOpen) {
        self.operation(FileOperationFail,noApplicationToOpen);
    }
}



- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController *)controller{
}
- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller{
    
}

-(void)documentInteractionController:(UIDocumentInteractionController *)controller

       willBeginSendingToApplication:(NSString *)application

{
    self.operation(FileOperationSuccess,application);
}

-(void)documentInteractionController:(UIDocumentInteractionController *)controller

          didEndSendingToApplication:(NSString *)application

{
    
}




@end
