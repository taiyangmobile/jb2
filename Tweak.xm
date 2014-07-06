// #import <SpringBoard/SpringBoard.h>
%hook EAGLTouchScreenView
- (void)removeTouch:(int)arg1{
    %orig();
	for(int i=0;i<10;i++){
	    	NSLog(@"i===%i",i);
    }

}
- (void)touchesBegan:(id)arg1 withEvent:(id)arg2{
	%orig();
	NSLog(@"touch  Began");

}
- (void)touchesCancelled:(id)arg1 withEvent:(id)arg2{
	
   // %orig(); //invoke the orignal method to do what should to do.
    NSLog(@"=========================================================");
    NSLog(@"Hello MobileSubstrate!!");
    NSLog(@"arg1===%@, arg 2====  %@",arg1,arg2);

    for(int i=0;i<10;i++){
    	sleep(1);
    	%orig();

    	NSLog(@"i===%i",i);

   	 	[self touchesBegan:arg1 withEvent:arg2];

    }
    NSLog(@"=========================================================");
    
    
}
%end