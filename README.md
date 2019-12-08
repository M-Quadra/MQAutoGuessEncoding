# MQAutoGuessEncoding

字符集编码检测, 基于`CreateML`(懒), 可能会上tf

- 目前Uint4xUint4方案最优, 可能大概或许应该会更新
- 截取前500byte作为输入, 不使用全量判断
- 预筛选编码, 加速分类速度

# 移花接木

- Swift

已集成至[MQKit](https://github.com/M-Quadra/MQKit)

- Objective-C

```
pod 'MQAutoGuessEncodingOC', :git => 'https://github.com/M-Quadra/MQAutoGuessEncoding.git'
or
pod 'MQAutoGuessEncodingOC', :git => 'git@github.com:M-Quadra/MQAutoGuessEncoding.git'
```

```
#import <MQAutoGuessEncodingOC/MQAutoGuessEncodingOC.h>

NSData *txtData = ...;
NSString *txt = [txtData mq_autoString];
```

还不敢发正式库\_(ˊཀˋ」∠)_

# 未解之谜

事先筛选了可以转换的编码类型, 有些神奇的编码转换可能会出现崩溃, 原因未知

# 冷涩残垣

[性能测试](./BaseTest.md)

[DataCreater](./DataCreater)文件夹为训练数据的生成工程

[Demo](./Demo)文件夹为模型的基准测试工程

生成与测试需要重新指定文件路径

主要训练数据的文本为简体中文, 不清楚其他语言是否正常

<del>踩坑</del>辣鸡手札, 按时间先后排序

## 乱码检测

如果直接从二进制数据判断编码, 那就是100+的多分类问题, 如何设计设计输入是个很<del>头疼</del>懒癌的问题, 对于某些编码转换结果, 猜测会由于输入或设计时缺少语义信息, 导致最终结果为乱码却没有过滤掉。

(以上半属胡说八道, 归根结底就是懒。哦不, 是奥卡姆剃刀!)

为了速度考虑, 先截取部分内容, 空格回车这种自ascii就存在的玩意可以作为不错的分界线。判断转码后文本是否为乱码决定编码的可用与否。

- 第一轮

筛选的特征主要使用系统自带的分词

在截取200+长度的文本进行判断时可能会在某些文本上被误识别为乱码, 所以目前把第一轮判断的文本长度提升为300+

有些神奇的排列能在首位解析出`私用区字符`或`无中断空格`, 还是开启检查吧

- 第二轮

加入私用区字符与无中断空格

由于正常文本可能存在极其少量的私用区字符, 检查阀值为2/3

由于即使局部解码成功, 也会存在全文解码失败的情况, 第二轮检查为全文解码

- 尾声

反正姿势很差就对了\_(:з」∠)_

## Uint8

统计`UInt8`次数, `CreateML`训练/验证准确率停留在`60%`左右

看来需要引入位置信息, 或者改变输入结构

由于编码可能存在交集, 实际准确率估计并不差, 目前还没有经过大规模验证

## Uint8xUint8

统计每个`Uint8`后跟随的每个不同`Uint8`出现次数, `256x256`个输入特征

然鹅, `CreateML`似乎是CPU单核训练, 不知道哪天能买得起eGPU

速度太慢, 弃用

## Hex

将`Data`转换为16进制表示, 通过`CreateML`进行文本分类

虽然训练时显示`75%`左右的`acc`, 然而实际效果堪忧, 约等于不能用(或许姿势不对？)

## Uint4xUint4

将一个`Uint8`拆成2个`Uint4`, 统计各个`Uint4`后面跟随的每种`Uint4`数量

特征数相较于只统计`Uint8`没有变化, 还能引入更多的位置信息,提高了`acc`, 并且推理速度快了`1ms`左右\_(:з」∠)_

训练`acc`为`65~70%`, 由于编码可能存在交集, 实际准确率估计不错