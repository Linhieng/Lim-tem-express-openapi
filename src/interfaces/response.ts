import { DoctorInfo } from './dbTable'

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
