//
//  VideoAudioViewController.m
//  DemoList
//
//  Created by 罗琰 on 16/3/2.
//  Copyright © 2016年 luoyan. All rights reserved.
//

#import "VideoAudioViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface VideoAudioViewController ()
{
    BOOL _recording;
    MPMoviePlayerViewController *mpviemController;
    UILabel *label;
    //定义专门进行录制的类AVAudioRecoder
    AVAudioRecorder *recoder;
    //播放
    AVAudioPlayer *player;
}
@property(nonatomic,strong) AVAudioRecorder *recoder;
@property(nonatomic,strong) AVAudioPlayer *player;
@end

@implementation VideoAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- ( long long ) fileSizeAtPath:( NSString *) filePath{
    
    //
    
    //    NSData* data = [NSData dataWithContentsOfFile:[VoiceRecorderBaseVC getPathByFileName:_convertAmr ofType:@"amr"]];
    
    //    NSLog(@"amrlength = %d",data.length);
    
    //    NSString * amr = [NSString stringWithFormat:@"amrlength = %d",data.length];
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    
    return 0 ;
}

- (void)compositVideoAudio
{
    // 合成视频文件 url 的时候，必须在前面拼接一个 file:// 因为刚才录制视频后存到沙盒里面的是以 /private 开头的。
    
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"try" ofType:@"mp4"];
    
    NSString *dir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //设定路径
    NSString *audioPath = [NSString stringWithFormat:@"%@/testAudio.aif",dir];
    //定义URL
    
    // 下面两句是分别取得视频和声音文件的 url ，以供合成用。
    
    AVURLAsset *audioAsset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:audioPath] options:nil];
    
    NSLog(@"audioAsset===%@==",audioAsset);
    
    AVURLAsset *videoAsset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoPath] options:nil];
    
    NSLog(@"videoAsset===%@==",videoAsset);
    
    // 下面就是合成的过程了。
    
    AVMutableComposition *mixComposition = [AVMutableComposition composition];
    
    //插入音频
    AVMutableCompositionTrack *compositionCommentaryTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                                        preferredTrackID: kCMPersistentTrackID_Invalid];
    
    [compositionCommentaryTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset.duration)
                                        ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0]
                                         atTime:kCMTimeZero error:nil];
    
    //插入视频
    AVMutableCompositionTrack *compositionVideoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                                   preferredTrackID:kCMPersistentTrackID_Invalid];
    
    [compositionVideoTrack insertTimeRanges:@[[NSValue valueWithCMTimeRange:CMTimeRangeMake(kCMTimeZero,videoAsset.duration)]]
                                   ofTracks:[videoAsset tracksWithMediaType:AVMediaTypeVideo]
                                    atTime:kCMTimeZero error:nil];
    
    
    AVAssetExportSession *_assetExport = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                             presetName:AVAssetExportPresetPassthrough];

    //设定路径
    NSString *exportPath = [NSString stringWithFormat:@"%@/export.mp4",dir];
    
    long long temp = [self fileSizeAtPath:exportPath];
    
    NSLog (@"temp===%lld",temp);
    
    NSLog (@"exportPaht === %@",exportPath);
    
    NSURL *exportUrl = [NSURL fileURLWithPath :exportPath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:exportPath])
        
        [[NSFileManager defaultManager] removeItemAtPath:exportPath error:nil];
    
    _assetExport. outputFileType = AVFileTypeQuickTimeMovie;
    
    NSLog ( @"file type %@" ,_assetExport. outputFileType );
    
    _assetExport. outputURL = exportUrl;
    
    _assetExport. shouldOptimizeForNetworkUse = YES ;
    
    // 下面是按照上面的要求合成视频的过程。
    
    [_assetExport exportAsynchronouslyWithCompletionHandler :
     ^( void ) {
         // 下面是把视频存到本地相册里面，存储完后弹出对话框。
         ALAssetsLibrary *_assetLibrary = [[ALAssetsLibrary alloc] init];
         [_assetLibrary writeVideoAtPathToSavedPhotosAlbum :[ NSURL URLWithString :exportPath] completionBlock :^( NSURL *assetURL, NSError *error1) {
             
             NSLog(@"error1 = %@",error1);
             
             UIAlertView *alert = [[ UIAlertView alloc ] initWithTitle : @" 好的 !" message : @" 整合并保存成功！ "
                                   
                                                              delegate : nil
                                   
                                                     cancelButtonTitle : @"OK"
                                   
                                                     otherButtonTitles : nil ];
             
             [alert show ];
         }];
    }];
}

- (void)caption
{
    MPMoviePlayerController *mp = [mpviemController moviePlayer];
    
    UIImage *thumbImage = [mp thumbnailImageAtTime:mp.currentPlaybackTime timeOption:MPMovieTimeOptionNearestKeyFrame];
    NSData *imagedata = UIImagePNGRepresentation(thumbImage);
    
    [imagedata writeToFile:@"iosxcode4.png" atomically:YES];
}

//- (void)loadSubview
//{
//    NSString *movpath =[[NSBundle mainBundle] pathForResource:@"try" ofType:@"mp4"];
//    
////    mpviemController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:movpath]];
////    
////    [mpviemController.moviePlayer prepareToPlay];
////    
////    [self presentMoviePlayerViewControllerAnimated:mpviemController]; // 这里是presentMoviePlayerViewControllerAnimated
////    
////    [mpviemController.moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
////    
////    [mpviemController.view setBackgroundColor:[UIColor clearColor]];
////    
////    [mpviemController.view setFrame:self.view.bounds];
//    
//    MPMoviePlayerController *movewController =[[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:movpath]];
//    
//    [movewController prepareToPlay];
//    
//    [self.view addSubview:movewController.view];//设置写在添加之后   // 这里是addSubView
//    
//    movewController.shouldAutoplay=YES;
//    
//    [movewController setControlStyle:MPMovieControlStyleDefault];
//    
//    [movewController setFullscreen:YES];
//    
//    [movewController.view setFrame:self.view.bounds];
//}

-(void)loadSubview{
    UIView *view=[[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    view.backgroundColor=[UIColor orangeColor];
    self.view=view;
    label=[[UILabel alloc]initWithFrame:CGRectMake(90, 70, 160, 40)];
    label.text=@"等待录制声音";
    
    [self.view addSubview:label];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(90, 100, 100, 40);
    [button setTitle:@"开始录制" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(startPlayer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame=CGRectMake(90, 160, 100, 40);
    [button2 setTitle:@"停止录制" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(stopPlayer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    UIButton *button3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button3.frame=CGRectMake(90, 220, 100, 40);
    [button3 setTitle:@"播放录制" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(startRecord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton *button4=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button4.frame=CGRectMake(90, 280, 100, 40);
    [button4 setTitle:@"合成" forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(compositVideoAudio) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
}
-(void)startPlayer{
    //设置label状态显示 显示为正在录制
    label.textColor = [UIColor redColor];
    label.text = @"录制中...";
    label.textAlignment = UITextAlignmentCenter;
    
    //判断当前的录制状态和播放状态
    if (recoder.isRecording) {
        [recoder stop];
    }
    if (player.isPlaying) {
        [player stop];
    }
    NSError *err = nil;
    //设定录制信息
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:&err];
    [[AVAudioSession sharedInstance] setActive:YES error:&err];
    //设置采样的详细数据
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [settings setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey]; //采样率
    [settings setValue:[NSNumber numberWithInt:1]
                forKey:AVNumberOfChannelsKey];//通道的数目
    [settings setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];//采样位数 默认 16
    [settings setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];//大端还是小端 是内存的组织方式
    [settings setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];//采样信号是整数还是浮点数
    
    //定义路径，设定要保存的位置  /BDEIDJDFDSF-SDfDS4232/document
    NSString *dir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //设定路径
    NSString *savePath = [NSString stringWithFormat:@"%@/testAudio.aif",dir];
    
    NSLog(@"savaPath:%@",savePath);
    
    //定义URL
    NSURL *fileUrl = [NSURL fileURLWithPath:savePath];
    
    if (err) {
        NSLog(@"录制之前配置出错了！");
        return;
    }
    //初始化了录制的类
    recoder  = [[AVAudioRecorder alloc] initWithURL:fileUrl settings:settings error:&err];
    //开始录制
    [recoder record];
    
}
-(void)stopPlayer{
    //设置label状态显示 显示为正在录制
    label.textColor = [UIColor greenColor];
    label.text = @"已停止...";
    label.textAlignment = UITextAlignmentCenter;
    
    //正在录制的时候，要停止录制，正在播放的时候，要停止播放
    if (recoder.isRecording) {
        [recoder stop];
    }
    
    if(player.isPlaying){
        
        [player stop];
    }
}
-(void)startRecord{
    //设置label状态显示 显示为正在录制
    label.textColor = [UIColor purpleColor];
    label.text = @"正在播放...";
    label.textAlignment = UITextAlignmentCenter;
    
    NSError *err = nil;
    //获得录制的文件的路径
    //定义路径，设定要保存的位置  /BDEIDJDFDSF-SDfDS4232/document
    NSString *dir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //设定路径
    NSString *savePath = [NSString stringWithFormat:@"%@/testAudio.aif",dir];
    //定义URL
    NSURL *fileUrl = [NSURL fileURLWithPath:savePath];
    //设定后台播放
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&err];
    //设定为激活状态
    [[AVAudioSession sharedInstance] setActive:YES error:&err];
    //使用播放器进行播放
    player  = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&err];
    
    [player play];
    
}
              
@end
