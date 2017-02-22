//
//  MacroDefinition.h
//  IJHealth
//
//  Created by amu-mac on 16/1/5.
//  Copyright © 2016年 智业互联网络科技有限公司 艾嘉健康. All rights reserved.
//

#ifndef MacroDefinition_h
#define MacroDefinition_h

#pragma mark - 获取设备大小

//NavBar高度
#define NavigationBar_Height 44
//获取屏幕 宽度、高度
#define WIDTH  self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
#define ContentViewH (ScreenHeight-20-44-49)
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height//获取屏幕高度，兼容性测试
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width//获取屏幕宽度，兼容性测试

#define  SizeScaleX   ([AppDelegate shareInstance].autoSizeScaleY)
#define  SizeScaleY   ([AppDelegate shareInstance].autoSizeScaleX)

#pragma mark - 打印日志

#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...);
#endif


#pragma mark - 系统

#define isiPhone4 ([[UIScreen mainScreen]bounds].size.height == 480)
#define isiPhone5 ([[UIScreen mainScreen]bounds].size.height == 568)
#define isiPhone6 ([[UIScreen mainScreen]bounds].size.height == 667)
#define isiPhonep ([[UIScreen mainScreen]bounds].size.height == 736)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])


//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

#define WEAKSELF __weak __typeof(self) weakSelf = self;


#pragma mark - 内存

//使用ARC和不使用ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif

#pragma mark - common functions
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }

//释放一个对象
#define SAFE_DELETE(P) if(P) { [P release], P = nil; }

#define SAFE_RELEASE(x) [x release];x=nil


#pragma mark - 图片

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

//读取本地图片
#define LoadImage(imageName)[[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:@"png"]]



#pragma mark - 颜色类
#define RGBCOLOR(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define kNavigationBG [UIColor colorWithRed:0/255.0 green:162/255.0 blue:255/255.0 alpha:1]
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define kDarkGrayColor       RGBCOLOR(51, 51, 51)
#define kGrayColor           RGBCOLOR(153, 153, 153)
#define kLightGrayColor      RGBCOLOR(185, 185, 185)

#define     DEFAULT_BACKGROUND_COLOR         COLOR(242, 242, 242, 100)

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)


#pragma mark - 其他

#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#endif
