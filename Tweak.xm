// #import <SpringBoard/SpringBoard.h>
%hook EAGLTouchScreenView
NSString *isOpen;
NSMutableDictionary *dic;
NSTimer *timer;
- (void)touchesBegan:(id)arg1 withEvent:(id)arg2{
	%orig;
    if (!dic){
        dic=[[NSMutableDictionary alloc] init];
    }
    [dic setObject:arg1 forKey:@"beginArg1"];
    [dic setObject:arg2 forKey:@"beginArg2"];
    if (isOpen){
        [self touchesEnded:arg1 withEvent:arg2];  
    }
}
- (void)touchesEnded:(id)arg1 withEvent:(id)arg2{
    %orig;
    if ([[arg2 allTouches] count]==1){
        [dic setObject:arg1 forKey:@"endArg1"];
        [dic setObject:arg2 forKey:@"endArg2"];
    }
    if ([[arg2 allTouches] count]==4 && !isOpen){
        if (timer){
            [timer invalidate];
            timer = nil;
            isOpen=nil;
        }
        isOpen=@"";
        int seedTime = arc4random() % 12 + 6;
        timer= [NSTimer scheduledTimerWithTimeInterval:seedTime target:self selector:@selector(autotouch) userInfo:nil repeats:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"欢迎使用coc助手"  message:@"开启屏幕常亮"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show]; 
                [alert release];
    }
    if ([[arg2 allTouches] count]==5 && isOpen){
        if (timer){
            [timer invalidate];
            timer = nil;
            isOpen=nil;
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"欢迎使用coc助手"  message:@"已关闭屏幕常亮"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show]; 
                [alert release];
        }
    }
}


%new( @@: )
-(void)autotouch{
    id barg1=[dic objectForKey:@"beginArg1"];
    id barg2=[dic objectForKey:@"beginArg2"];

    //id earg1=[dic objectForKey:@"endArg1"];
    //id earg2=[dic objectForKey:@"endArg2"];

    [self touchesBegan:barg1 withEvent:barg2];
}
%end
