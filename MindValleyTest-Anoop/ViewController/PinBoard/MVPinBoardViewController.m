//
//  MVPinBoardViewController.m
//  MindValleyTest-Anoop
//
//  Created by Anoop Radhakrishnan on 10/04/16.
//  Copyright © 2016 Anoop Radhakrishnan. All rights reserved.
//

#import "MVPinBoardViewController.h"
#import "PinImageDownloader.h"
#import "PinItem.h"
#import "Pin.h"

#import "UIImageView+AsyncImageLoading.h"

static NSString* PIN_ITEM = @"PinItem";

@interface MVPinBoardViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *pinboard;
@property(nonatomic,strong)NSDictionary *responseData;
@property(nonatomic,strong)NSArray *pinDatasources;
@end

@implementation MVPinBoardViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if(!_responseData) _responseData = [NSDictionary new];
    if(!_pinDatasources) _pinDatasources = [NSArray new];
    [self fetchData];
}

-(void)fetchData{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.pinterest.com/v3/pidgets/boards/highquality/travel/pins/"]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSError* JSerror;
        if(_responseData && data)
        {
            _responseData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&JSerror];
            if(!JSerror){
                if(_pinDatasources)
                    _pinDatasources =  [[_responseData objectForKey:@"data"]objectForKey:@"pins"];
            }
            else{
                NSString *err = [JSerror localizedDescription];
                NSLog(@"Encountered error parsing: %@", err);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.pinboard reloadData];
            });
        }
    }] resume];
}

#pragma mark - Collection view Datasource

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_pinDatasources count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PinItem *pinItem = (PinItem*)[collectionView dequeueReusableCellWithReuseIdentifier:PIN_ITEM forIndexPath:indexPath];
    pinItem.pinImageVIew.tag = indexPath.row;
    
    Pin *pin = [Pin getPinData:[_pinDatasources objectAtIndex:indexPath.row]];
        
     pinItem.Activity.hidden = FALSE;
    [pinItem.Activity startAnimating];
    if(pin.pinImageURL){
        
        [pinItem.pinImageVIew setImageFromUrl:pin.pinImageURL completion:^{
           
            [pinItem.Activity stopAnimating];
             pinItem.Activity.hidden = TRUE;
        }];
    }
    return pinItem;
}
@end
