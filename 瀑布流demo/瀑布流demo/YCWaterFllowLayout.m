//
//  YCWaterFllowLayout.m
//  瀑布流demo
//
//  Created by 姚伟聪 on 16/1/21.
//  Copyright © 2016年 姚伟聪. All rights reserved.
//

#import "YCWaterFllowLayout.h"

@interface YCWaterFllowLayout ()

//用来记录每一列的最大Y值
@property(nonatomic,strong)NSMutableDictionary *maxYDict;
@property(nonatomic,assign)int colum;///<列数
@property(nonatomic,strong)NSMutableArray *layoutAttributes;///<存cell的布局属性
@property(nonatomic,assign)CGFloat maxY;///<最大Y值
@property(nonatomic,assign)CGFloat columnWidth;///<列宽
@property(nonatomic,assign)UIEdgeInsets sectionInsert;
@property(nonatomic,assign)CGFloat columnMargin;///<列间距
@property(nonatomic,assign)CGFloat rowMargin;///<行间距

@end

@implementation YCWaterFllowLayout

-(instancetype)init{

    if (self = [super init]) {
        self.colum = 4;
        
        static CGFloat margin = 8;
        self.sectionInsert = UIEdgeInsetsMake(margin, margin, margin, margin);
        self.columnMargin = margin;
        self.rowMargin = margin;
    }
    return self;
}

-(void)prepareLayout{
    
    for (int i = 0; i < self.colum; i++) {
        
        NSString *str = [[NSString alloc]initWithFormat:@"%d",i];
        [self.maxYDict setObject:@"0" forKey:str];
    }
    
    [self.layoutAttributes removeAllObjects];
    
    self.maxY = 0;
    
    self.columnWidth = ([UIScreen mainScreen].bounds.size.width - (2 * self.sectionInsert.left) - (self.columnMargin * (self.colum - 1))) / self.colum;

    NSInteger num = [self.collectionView numberOfItemsInSection:0];
    
    NSLog(@"%ld",num);
    for (NSInteger i = 0; i < num; i++) {
        
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        
       UICollectionViewLayoutAttributes *layoutAttribut = [self layoutAttributesForItemAtIndexPath:index];
        
        [self.layoutAttributes addObject:layoutAttribut];
    }
    
    [self calcMaxY];
}


-(CGSize)collectionViewContentSize{

   
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, self.maxY + 8);
}

///计算最大的Y值
-(void)calcMaxY{

    //默认第0列最长

    __block int maxYCoulumn = 0;
    
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        NSString *str = [NSString stringWithFormat:@"%d",maxYCoulumn];

        if ([obj compare:self.maxYDict[str]] == NSOrderedDescending) {
            
            NSString *num = key;
            maxYCoulumn = num.intValue;
            
        }
    }];
    
    
    NSString *str = [NSString stringWithFormat:@"%d",maxYCoulumn];
    NSString *maxYstr = self.maxYDict[str];
    self.maxY = maxYstr.floatValue;
    
    NSLog(@"%lf",self.maxY);
    
}


///返回每个cell的布局属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{

    //计算cell的frame
    
    //需要获得cell的高度
    CGFloat height = 0;
    if([self.delegate respondsToSelector:@selector(waterFllowLayout:andHeightForWidth:andIndexPath:)]){
      height = [self.delegate waterFllowLayout:self andHeightForWidth:self.columnWidth andIndexPath:indexPath];
    }
    //要找到最短的一列
   __block NSInteger minYColumn = 0;
    NSLog(@"***************");
    NSLog(@"%@",self.maxYDict);
    
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *str = [NSString stringWithFormat:@"%ld",minYColumn];
        NSString *minStr = self.maxYDict[str];
        NSInteger min = minStr.integerValue;
        
        NSString *nowStr = obj;
        NSInteger now = nowStr.integerValue;
        if (now < min) {
            NSString *num = key;
            minYColumn = num.integerValue;
        }
    }];

    CGFloat x = self.sectionInsert.left + minYColumn * (self.columnWidth + self.columnMargin);
    NSLog(@"x%lf minYColumn %ld",x,minYColumn);
    
    NSString *num = [NSString stringWithFormat:@"%ld",minYColumn];
    NSString *YStr = self.maxYDict[num];
    
    CGFloat y = YStr.floatValue + self.rowMargin;
    
    CGRect frame = CGRectMake(x, y, self.columnWidth, height);
    
    NSString *maxYStr = [NSString stringWithFormat:@"%lf",CGRectGetMaxY(frame)];
    
    [self.maxYDict setObject:maxYStr forKey:num];
     NSLog(@"%@",self.maxYDict);
    NSLog(@"***************");
    UICollectionViewLayoutAttributes *layoutAtt = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    layoutAtt.frame = frame;
    return layoutAtt;
    
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
   
  
    return self.layoutAttributes;
}

#pragma mark- 懒加载
-(NSMutableDictionary *)maxYDict{

    if (_maxYDict == nil) {
        _maxYDict = [[NSMutableDictionary alloc] init];
    }
    
    return _maxYDict;

}
-(NSMutableArray *)layoutAttributes{

    if (_layoutAttributes == nil) {
        _layoutAttributes = [NSMutableArray array];
    }
    return _layoutAttributes;
}
@end
