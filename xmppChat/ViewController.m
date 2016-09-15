//
//  ViewController.m
//  xmppChat
//
//  Created by 邓茂江 on 16/9/11.
//  Copyright © 2016年 maojiang. All rights reserved.
//

#import "ViewController.h"
#import "TextInputView.h"
#import "ChatTableViewCell.h"
#import "ChatDataModel.h"
@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSouce;
@property (nonatomic,strong) TextInputView *inputView;
@property (nonatomic)CGRect bounds;
@property(nonatomic)BOOL temp;
@end

static NSString *identifier=@"chatCell";

@implementation ViewController


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSouce count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    ChatDataModel *model=self.dataSouce[indexPath.row];
    if (model.image) {
        [cell refreshCellWithImage:model getBounds:self.bounds];
    }
    else
    {
    [cell refreshCell:self.dataSouce[indexPath.row] passBounds:self.bounds];
    }
    return cell;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSouce = [NSMutableArray arrayWithCapacity:500];
    self.temp=YES;
    self.automaticallyAdjustsScrollViewInsets=NO;
    CGRect bound= [[UIScreen mainScreen] bounds];
    bound.size.height=bound.size.height-20.0;
    self.bounds=bound;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.bounds.size.width, self.bounds.size.height-60-30)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[ChatTableViewCell class] forCellReuseIdentifier:identifier];
    
    // 小技巧，用了之后不会出现多余的Cell
    UIView *view = [[UIView alloc] init];
    self.tableView.tableFooterView = view;
    
    // 底部输入栏
    self.inputView = [[TextInputView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 30, self.bounds.size.width, 30)];
    self.inputView.backgroundColor = [UIColor whiteColor];
    self.inputView.willTextField.delegate = self;
    
    [self.inputView.senderButton addTarget:self action:@selector(clickSengMsg:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputView.addButton addTarget:self action:@selector(pushViewForFunction:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputView.photoButton addTarget:self action:@selector(openPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.inputView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // 增加手势，点击弹回
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.view addGestureRecognizer:tap];


}

- (void)keyBoardShow:(NSNotification *)noti
{
    // 获取到的Noti信息是这样的
    //    NSConcreteNotification 0x7fde0a598bd0 {name = UIKeyboardWillShowNotification; userInfo = {
    //        UIKeyboardAnimationCurveUserInfoKey = 7;
    //        UIKeyboardAnimationDurationUserInfoKey = "0.25";
    //        UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}";
    //        UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 796}";
    //        UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 538}";
    //        UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 258}}";
    //        UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";      就是他
    //        UIKeyboardIsLocalUserInfoKey = 1;
    //    }}
    // 咱们取自己需要的就好了
    CGRect rec = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"%@",NSStringFromCGRect(rec));
    // 小于，说明覆盖了输入框
    if ([UIScreen mainScreen].bounds.size.height - rec.size.height < self.inputView.frame.origin.y + self.inputView.frame.size.height)
    {
        // 把我们整体的View往上移动
        CGRect tempRec = self.view.frame;
        tempRec.origin.y = - (rec.size.height);
        self.view.frame = tempRec;
    }
    // 由于可见的界面缩小了，TableView也要跟着变化Frame
    self.tableView.frame = CGRectMake(0, rec.size.height+64, _bounds.size.width, _bounds.size.height - rec.size.height-94);
    if (self.dataSouce.count != 0)
    {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSouce.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    
}



- (void)keyboardHide:(NSNotification *)noti
{
    self.view.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.tableView.frame = CGRectMake(0, 64, self.bounds.size.width, self.bounds.size.height - 64 - 30);
}

- (void)click:(UITapGestureRecognizer *)tap
{
    [self usingAddButtonChangeFrameUP];
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

-(void)pushViewForFunction:(UIButton *)addButton{
    if (self.temp) {
            [self usingAddButtonChangeFrameUP];
            self.temp=NO;
    }
    else{
        [self usingAddButtonChangeFrameDown];
        self.temp=YES;
    }
    
}

-(void)usingAddButtonChangeFrameUP{
    self.tableView.frame=CGRectMake(0, 64, self.bounds.size.width, self.bounds.size.height-188);
    self.inputView.frame=CGRectMake(0, self.bounds.size.height-124, self.bounds.size.width, 60);
    if (self.dataSouce.count!=0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSouce.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }

}
-(void)usingAddButtonChangeFrameDown{
    self.view.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.tableView.frame = CGRectMake(0, 64, self.bounds.size.width, self.bounds.size.height - 114);
    self.inputView.frame=CGRectMake(0, self.bounds.size.height - 50, self.bounds.size.width, 60);
    
    if (self.dataSouce.count>0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSouce.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
}


//打开照相机
-(void)openCamera:(UIButton *)button{
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *pick=[[UIImagePickerController alloc]init];
        pick.delegate=self;
        pick.allowsEditing=YES;
        pick.sourceType=UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pick animated:YES completion:^{
            
        }];

        
    }
    
    
}

//打开相册
-(void)openPhoto:(UIButton *)button{
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *pick=[[UIImagePickerController alloc]init];
        pick.delegate=self;
        pick.allowsEditing=YES;
        pick.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        //pick.mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:pick.sourceType];
        
        [self presentViewController:pick animated:YES completion:^{
            
        }];
        
        
    }

}




-(void)clickSengMsg:(UIButton *)button{
    if ([self.inputView.willTextField.text isEqualToString:@""]) {
        
    }
    else{
        ChatDataModel *model = [[ChatDataModel alloc]init];
        model.chatTextString=self.inputView.willTextField.text;
        model.flag = arc4random() % 2;
        [self.dataSouce addObject:model];
        //重载tableview,刷新数据
        [self.tableView reloadData];
        //cell 滑动到底部
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSouce.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        

    }
    
    
    
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    dispatch_queue_t queue=dispatch_get_main_queue();
    __weak typeof(self) weakSelf=self;
    dispatch_async(queue, ^{
        if (picker.sourceType==UIImagePickerControllerSourceTypeCamera) {
            UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
            UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
            
        }
        else if(picker.sourceType==UIImagePickerControllerSourceTypePhotoLibrary){
            UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
            ChatDataModel *model = [[ChatDataModel alloc]init];
            model.image=image;
            [weakSelf.dataSouce addObject:model];
            model.flag = arc4random() % 2;
            
            
        }
    
        
        
    });
    NSLog(@"%@",info);
    [self dismissViewControllerAnimated:YES completion:^(void){
        [self.tableView reloadData];
        [self usingAddButtonChangeFrameUP];
    }];


   
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatDataModel *model = self.dataSouce[indexPath.row];
    CGRect rec =  [model.chatTextString boundingRectWithSize:CGSizeMake(200, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    if (model.image) {
        return 140;
    }
    else
    {
    return rec.size.height + 45;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
