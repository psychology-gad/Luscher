#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    LUSCHER_BLUE,
    LUSCHER_GREEN,
    LUSCHER_RED,
    LUSCHER_YELLOW,
    LUSCHER_VIOLET,
    LUSCHER_BROWN,
    LUSCHER_GRAY,
    LUSCHER_BLACK
}LUSCHERS;

@interface CollectionViewController : UICollectionViewController <UIAlertViewDelegate>
@end