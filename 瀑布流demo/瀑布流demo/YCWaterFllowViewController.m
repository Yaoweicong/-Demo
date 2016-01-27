//
//  YCWaterFllowViewController.m
//  瀑布流demo
//
//  Created by 姚伟聪 on 16/1/21.
//  Copyright © 2016年 姚伟聪. All rights reserved.
//

#import "YCWaterFllowViewController.h"
#import "YCWaterFllowLayout.h"

@interface YCWaterFllowViewController ()<YCWaterFllowLayoutDelegate>

@property(nonatomic,strong)YCWaterFllowLayout *layout;

@end

@implementation YCWaterFllowViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
       [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        self.layout.delegate = self;
    // Do any additional setup after loading the view.
}

-(instancetype)init{
    
    self = [super initWithCollectionViewLayout:self.layout];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(CGFloat)waterFllowLayout:(YCWaterFllowLayout *)layout andHeightForWidth:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath{
//+ arc4random_uniform(50)
    return 100 + arc4random_uniform(50) ;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    
    return cell;
}

#pragma mark- 懒加载

-(YCWaterFllowLayout *)layout{
    if (_layout == nil) {
        _layout = [[YCWaterFllowLayout alloc] init];
    }
    return _layout;
}

@end
