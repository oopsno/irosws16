# 插图说明

总体上分4个模块

+ Illuminate， 继承于Master，扩展了其注册多个服务实例的能力
+ Shadow， 客户端的Master代理
+ Daemon， Docker容器内的ROS Master代理
+ Middleman，运行于容器的宿主机上， 负责容器地址-主机端口的网络地址转换

为了便于区分，于ROS中以Service称呼代码模块，以Node称呼运行中的实例；在容器里，代码部分仍叫Service，实例暂定名为Cell。

## 交互

![image](figures-1.pdf)

这是4个模块之间的交互关系

- (a) 客户端侧，与私有Service无关的一切API调用都被转发至Illuminate
- (b) 容器内部，`(un)registerService`被改写成`(un)regCell`转发至Illuminate， 以实现注册， 其他的`(un)?register*`被丢弃，其余访问原样转发至Illuminate；Daemon每次转发`registerService`前通过iptables把Service使用的端口映射到容器内的30000端口，每次`unregisterService`转发前取消端口映射
- (c) Daemon每次转发`registerService`前，在端口映射完成后，向Middleman查询真实地址

## Illuminate

这是Illuminate的运行时行为。


![image](figures-3.pdf)


+ 蓝线标记的是来自容器内部的，与Cell相关的API调用的执行路径，由Illuminate直接操作内建的哈希表，来控制完成注册
+ 青线标记的是来自容器内部的其他API调用的执行路径，由Illuminate直接转发给内嵌的Master
+ 绿线标记的是客户端方面的`lookupService`的API调用，由Illuminate直接处理。为了保持兼容性，优先查询内嵌的Master有无已注册的同名Node，若没有，则查询有无已注册的同名Cell
+ 红线标记的是的其他API调用的执行路径，由Illuminate直接转发给内嵌的Master


## 容器内部

这是容器内部，与Cell相关的API调用的执行逻辑。

![image](figures-5.pdf)

+ (a) 请求由服务发起，交给Daemon
+ (b) Daemon执行（或取消）端口映射（黑线）
+ (c) Middleman查询Docker Server以获取容器信息
+ (d) Daemon将改写过后的请求转发

黑线标记的是iptables的端口映射过程。

## 客户端

Shadow存在是为了支持使用外部不可见的私有Service、通过配置混合使用远程或者本地的Service实例两项功能而可选添加的，如果不需要这些功能，只设置`ROS_MASTER_URI`，ROS的原有功能均能正常运转。

![image](figures-7.pdf)

+ 红色路径标记的是`lookupService`的执行过程，a-b为查询本地的私有Service的实例，由Shadow转发至本地运行的Master；a-c为查询公共的已注册的Node或者Cell，由Shadow至转发至Illuminate
+ 绿色标记的是客户端发起的注册或注销Service或者Publisher实例的API调用，d-e为注册或者本地的私有Service的实例，由Shadow转发至本地运行的Master；d-f为其他情况，由Shadow至转发至Illuminate
+ 蓝色标记的是其他所有的API调用，由Shadow直接转发到Illuminate
