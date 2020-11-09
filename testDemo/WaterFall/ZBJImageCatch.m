//
//  ZBJImageCatch.m
//  testDemo
//
//  Created by zbj on 2020/11/9.
//  Copyright © 2020 ace. All rights reserved.
//

#import "ZBJImageCatch.h"
#import "NSString+Utils.h"

@interface ZBJImageCatch ()

@property(nonatomic, strong) NSMutableDictionary *catchDict;

@end

@implementation ZBJImageCatch

+ (instancetype)share {
    static ZBJImageCatch *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self alloc] init];
        obj.catchDict = [NSMutableDictionary dictionary];
    });
    return obj;
}

- (void)imageWithUrlString:(NSString *)urlString completion:(void (^)(UIImage *image))completion {
    
    if (urlString == nil) {
        return;
    }
    
    NSString *md5String = [urlString md5];
    if ([self.catchDict objectForKey:md5String]) {
        completion([self.catchDict objectForKey:md5String]);
    }
    else {
        NSString *directoryPath = [self zbj_cachePath];
        NSString *path = [NSString stringWithFormat:@"%@/%@",
                          directoryPath,
                          md5String];
        __block UIImage *image = [UIImage imageWithContentsOfFile:path];
        if (image) {
            [self.catchDict setObject:image forKey:md5String];
            completion([UIImage imageWithContentsOfFile:path]);
        }
        else {
            __weak typeof (self) weakSelf = self;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                __strong typeof (weakSelf) strongSelf = weakSelf;
                image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
                if (image) {
                    [strongSelf.catchDict setObject:image forKey:md5String];
                    [strongSelf saveImageWithUrlString:urlString image:image];
                    completion(image);
                }
            });
        }
    }
}

- (void)clearImageCatch {
    
    [self.catchDict removeAllObjects];
    
    NSString *directoryPath = [self zbj_cachePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:&error];
        
        if (error) {
            NSLog(@"clear caches error: %@", error);
        } else {
            NSLog(@"clear caches ok");
        }
    }
}


- (void)saveImageWithUrlString:(NSString *)urlString image:(UIImage *)image {
    
    if (image == nil) {
        return;
    }
    
    NSString *md5String = [urlString md5];
    
    NSString *directoryPath = [self zbj_cachePath];
    
    
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error];
        if (error) {
            NSLog(@"create cache dir error: %@", error);
            return;
        }
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",
                      directoryPath,
                      md5String];
    NSData *data = UIImagePNGRepresentation(image);
    if (data) {
        BOOL isOk = [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
        
        if (isOk) {
            NSLog(@"cache file ok: %@", urlString);
        } else {
            NSLog(@"cache file error: %@", urlString);
        }
    }
}

- (NSString *)zbj_cachePath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ImageCatch"];
}

@end
