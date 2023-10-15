import { DoctorInfo } from './dbTable'

/**
 * 通用的响应体，所有响应体都继承自该接口
 */
export interface ResponseGeneral {
    code: number
    message: string
    data?: any
}

/**
 * 返回一个失败的请求时的统一接口。
 * 失败的请求包括 500, 404, 403 等
 */
export interface ResponseError extends ResponseGeneral {
    data?: Array<any>
}

/**
 * 医生登录响应体
 */
export interface DoctorLoginResponse {
    doctor?: DoctorInfo
    /**
     * 操作是否成功
     */
    isSucceed: boolean
}
