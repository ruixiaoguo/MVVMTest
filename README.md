# MVVM-master
MVVM就是在MVC的基础上分离出业务处理的逻辑到ViewModel层，即：

> Model层：请求的原始数据
> View层：视图展示，由ViewController来控制
> ViewModel层：负责业务处理和数据转化

简单来说，就是API请求完数据，解析成Model，之后在ViewModel中转化成能够直接被视图层使用的数据，交付给前端（View层）。

