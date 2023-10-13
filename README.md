# 练习-体检系统后台

TODO:

- [x] 借助 openapi 搭建基于 node 的 express 的后台模版

接口均在 `openapi.yaml` 中定义（即 openapi），该文件可以自己编写，但目前是使用 apifox 生成。当收到一个请求时，首先会经过中间件 `OpenApiValidator` 的校验，如果请求的接口未在 openapi 中定义，或者请求的数据类型错误，则会返回一个错误。该错误会由 global handle error 捕获，然后将其包装一下发送给客户。如果校验通过，则先经过 controllers 的处理。具体是哪个 controllers，同样也是在 openapi 中定义。controller 中会对请求的数据进行处理，然后会将处理后的数据交给 services 处理。所以我们主要就是在编写 services 中的代码。
