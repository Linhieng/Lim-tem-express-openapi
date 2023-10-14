# 数据库表结构

## 表

| table name      | info                                                |
|-----------------|-----------------------------------------------------|
| user            | 用户表：存储所有用户信息                             |
| doctor          | 医生信息表：存储所有医生信息                         |
| hospital        | 医院信息表：存储所有医院信息                         |
| setmeal         | 体检套餐信息表：存储所有体检套餐信息                 |
| order           | 体检预约订单表：存储所有体检预约订单信息             |
| checkItem       | 检查项信息表：存储所有检查项信息                     |
| checkItemDetail | 检查项明细表：存储所有检查项明细信息                 |
| overallResult   | 总检结论信息表：存储某体检报告的总检结论信息         |
| ciReport        | 体检报告检查项信息表：存储某体检报告的检查项信息     |
| ciReportDetail  | 体检报告检查项明细表：存储某体检报告的检查项明细信息 |

### user

| fieldname    | type    | size | check  | info     |
|--------------|---------|------|--------|----------|
| userId       | varchar | 11   | PK, NN |          |
| phone        | varchar | 11   | NN     |          |
| password     | varchar | 20   | NN     |          |
| realName     | varchar | 20   | NN     |          |
| gender       | int     |      | NN     | 1男 0 女 |
| identityCard | varchar | 18   | NN     |          |
| birthday     | date    |      | NN     |          |

### doctor

| fieldname | type    | size | check  | info               |
|-----------|---------|------|--------|--------------------|
| docId     | varchar |      | PK, NN |                    |
| docCode   | varchar | 20   | NN     | 医生编码（用于登录） |
| realName  | varchar | 20   | NN     |                    |
| password  | varchar |      | NN     |                    |
| gender    | int     |      | NN     |                    |

### hospital

| fieldname    | type    | size | check  | info                 |
|--------------|---------|------|--------|----------------------|
| hpId         | varchar |      | PK, NN |                      |
| hpName       | varchar | 30   | NN     |                      |
| picture      | varchar |      | NN     | 医院图片             |
| phone        | varchar |      | NN     | 医院电话             |
| address      | varchar | 100  | NN     |                      |
| businessTime | varchar |      | NN     |                      |
| deadline     | varchar |      | NN     |                      |
| orderRule    | varchar |      |        | 预约人数规则         |
| state        | int     |      |        | 医院状态，1正常，2其他 |

### setmeal

| fieldname | type    | size | check  | info                 |
|-----------|---------|------|--------|----------------------|
| smId      | varchar |      | PK, NN |                      |
| smName    | varchar |      | NN     |                      |
| type      | int     |      | NN     | 1 男士套餐，0女士套餐 |
| price     | int     |      | NN     |                      |

### order

| fieldname | type    | size | check  | info                           |
|-----------|---------|------|--------|--------------------------------|
| orderId   | varchar |      | PK, NN |                                |
| orderDate | date    |      | NN     |                                |
| userId    | varchar |      | NN,FK  |                                |
| hpId      | varchar |      | NN,FK  |                                |
| smId      | varchar |      | NN,FK  |                                |
| state     | int     |      | NN     | 订单归档状态，1 未归档，2 已归档 |

### overallResult

| fieldname | type    | size | check  | info |
|-----------|---------|------|--------|------|
| orId      | varchar |      | PK, NN |      |
| title     | varchar |      |        |      |
| content   | varchar |      |        |      |
| orderId   |         |      | NN, FK |      |

### checkItem

| fieldname  | type    | size | check  | info       |
|------------|---------|------|--------|------------|
| ciId       | varchar |      | PK, NN |            |
| ciName     | varchar |      |        | 体检项名称 |
| ciContent  | varchar |      |        | 体检项内容 |
| meaning    | varchar |      |        | 体检项含义 |
| postscript | varchar |      |        | 备注       |

### checkItemDetail

| fieldname    | type    | size | check  | info                                               |
|--------------|---------|------|--------|----------------------------------------------------|
| cidId        | varchar |      | PK, NN |                                                    |
| cidName      | varchar |      | NN     | 体检项明细名称                                     |
| cidType      | int     |      | NN     | 1 数值范围型；2数值相等型；3无需验证型；4描述型；5其他 |
| ciId         | varchar |      | NN, FK | 所属体检项                                         |
| cidUnit      | varchar |      |        | 单位                                               |
| minVal       | double  |      |        | 正常范围中的最小值                                 |
| maxVal       | double  |      |        | 正常范围中的最大值                                 |
| normalVal    | varchar |      |        | 非数字类型的正常范围                               |
| normalValStr | varchar |      |        | 正常范围说明文字                                   |
| postscript   | varchar |      |        | 备注                                               |

### ciReport

| fieldname | type    | size | check  | info |
|-----------|---------|------|--------|------|
| cirId     | varchar |      | PK, NN |      |
| ciId      | varchar |      | NN, FK |      |
| ciName    | varchar |      | NN     |      |
| orderId   | varchar |      | NN, FK |      |

### ciReportDetail

| fieldname    | type    | size | check  | info                                               |
|--------------|---------|------|--------|----------------------------------------------------|
| cidrId       | varchar |      | PK, NN |                                                    |
| name         | varchar |      | NN     |                                                    |
| unit         | varchar |      |        |                                                    |
| minVal       | double  |      |        |                                                    |
| maxVal       | double  |      |        |                                                    |
| normalVal    | varchar |      |        |                                                    |
| normalValStr | varchar |      |        |                                                    |
| postscript   | varchar |      |        |                                                    |
| type         | int     |      |        | 1 数值范围型；2数值相等型；3无需验证型；4描述型；5其他 |
| value        |         |      |        | 检查结果值                                         |
| isError      |         |      |        | 该项是否异常                                       |
| ciId         |         |      |        |                                                    |
| orderId      |         |      |        |                                                    |
