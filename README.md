# 练习-体检系统后台

TODO:

- [x] 借助 openapi 搭建基于 node 的 express 的后台模版
- [x] 对接数据库
- [ ] 请求失败时，提供消息体；修改运行错误的返回格式

待解决问题：

- [x] ~~camelcase 是 ES 模块，ts将其处理为了 commonJS。考虑使用 rollup 代替~~ 自己创建了一个 npm 包来解决此问题。
- [ ] apifox 的 openapi 文档有点问题，需要自己再次处理一下

## 笔记

PS: 由于没有系统学习过后台，所以相关概念的理解可能有偏差。

接口均在 `openapi.yaml` 中定义（即 openapi），该文件可以自己编写，但目前是使用 apifox 生成。当收到一个请求时，首先会经过中间件 `OpenApiValidator` 的校验，如果请求的接口未在 openapi 中定义，或者请求的数据类型错误，则会返回一个错误。该错误会由 global handle error 捕获，然后将其包装一下发送给客户。如果校验通过，则先经过 controllers 的处理。具体是哪个 controllers，同样也是在 openapi 中定义。controller 中会对请求的数据进行处理，然后会将处理后的数据交给 services 处理。所以我们主要就是在编写 services 中的代码。

openapi.yaml 中的  与 controllers 和 services 中的 函数名是相对应的（相同）。

借助 openapi 实现后台系统，主要靠的是 express-openapi-validator 插件，该插件会获取我们的 openapi.yaml，同时利用 json-schema-ref-parser 处理 $ref 引用，同时处理了我们在 openapi.yaml 中定义的各个接口，将他们与代码中的 controllers 和 services 联系起来。具体的说，openapi.yaml 指定了 `operationId` 属性，该值与 controllers 中的函数名是对应的，而 controllers 中会调用到 services 中的代码。故逻辑上代码运行流程是 openapi.yaml --> controller --> services

开发流程：

1. 在 apifox 中编写对应的接口
2. 在 apifox 中生成代码，需要的产物有 openapi.yaml、controllers 和 services
3. 在 services 中编写具体的逻辑代码——处理请求体，返回响应体

## 参考文献

虽然查找了很多文章，但在我看来，不管是什么架构、什么设计，目的都是为了提高效率。所以，首要任务还是多开发，多敲代码，只有在开发中学习，才能更好的理解这些架构和思维。

- [Model, DAO, Service, Controller](https://juejin.cn/post/6854573216002736141)
- [三层架构](https://blog.csdn.net/hanxuemin12345/article/details/8544957)
- [三层架构和 MVC 的区别](https://zhuanlan.zhihu.com/p/328443789)
- [MVVC 架构](https://zhuanlan.zhihu.com/p/59467370)
