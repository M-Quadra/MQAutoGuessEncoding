# MQAutoGuessEncoding
Auto guess encoding of Data/NSData

## DataCreater

训练数据的生成代码, 需要自己生成训练数据的话, 需要改动输入输出

使用`UInt8`次数分类, `CreateML`分类准确率停留在`60%`左右

看来需要引入位置信息, 或者改变输入结构