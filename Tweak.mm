#import <UIKit/UIKit.h>

// This attribute tells the system: "Run this the second the library loads"
__attribute__((constructor))
static void initialize_my_button() {
    // We dispatch to the main thread because you can't touch the UI on background threads
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 1. Grab the main window of the app
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        
        // 2. Create the button (Top Right, 60x60 size)
        UIButton *myButton = [UIButton buttonWithType:UIButtonTypeSystem];
        myButton.frame = CGRectMake(keyWindow.frame.size.width - 70, 50, 60, 60);
        myButton.backgroundColor = [UIColor redColor];
        [myButton setTitle:@"MOD" forState:UIControlStateNormal];
        [myButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        myButton.layer.cornerRadius = 30; // Make it a circle
        
        // 3. Add an action (What happens when clicked)
        [myButton addTarget:nil action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        // 4. Inject it into the view
        [keyWindow addSubview:myButton];
        
        NSLog(@"[MyDylib] Button successfully injected!");
    });
}

// The function that runs when you tap the button
void buttonClicked() {
    printf("Button was clicked!\n");
}
