# MQAutoGuessEncoding

字符集编码检测, 基于`CreateML`(懒), 可能会上tf

- 目前Uint4xUint4方案最优, 可能大概或许应该会更新
- 截取前500byte作为输入, 不使用全量判断
- 预筛选编码, 加速分类速度

# 未解之谜

事先筛选了可以转换的编码类型, 有些神奇的编码转换可能会出现崩溃, 原因未知

# 冷涩残垣

[性能测试](./BaseTest.md)

[DataCreater](./DataCreater)文件夹为训练数据的生成工程

[Demo](./Demo)文件夹为模型的基准测试工程

生成与测试需要重新指定文件路径

主要训练数据的文本为简体中文, 不清楚其他语言是否正常

<del>踩坑</del>辣鸡手札, 按时间先后排序

## Uint8

统计`UInt8`次数, `CreateML`训练/验证准确率停留在`60%`左右

看来需要引入位置信息, 或者改变输入结构

由于编码可能存在交集, 实际准确率估计并不差, 目前还没有经过大规模验证

速度比之前那个猜乱码的方案快了不少(获取后面献个丑？)

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

`acc`为`65~70%`