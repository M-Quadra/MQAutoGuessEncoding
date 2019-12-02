# MQAutoGuessEncoding

Auto guess encoding of Data/NSData

尽量直接使用`CreateML`训练模型(懒), 可能会用tf

有些神奇的编码可能会出现崩溃, 原因未知

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