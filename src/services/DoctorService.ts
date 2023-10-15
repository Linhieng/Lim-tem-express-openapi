/* eslint-disable no-unused-vars */
import { CODE_ERROR, CODE_FAITH, CODE_SUCCEED } from '../constants'
import { DoctorLoginRequest, DoctorLoginResponse } from '../interfaces'
import { searchByCodeAndPass } from '../models'
import Service from './Service'

/**
 * 医生登录
 */
export const doctorGetDoctorByCodeByPassPOST = ({ body, doctorLoginRequest }) =>
    new Promise(async (resolve, reject) => {
        try {
            const data: DoctorLoginRequest = doctorLoginRequest || body
            const searchResult = await searchByCodeAndPass(data)

            let response: DoctorLoginResponse

            if (searchResult.length > 0) {
                response = {
                    code: CODE_SUCCEED,
                    message: '登录成功',
                    data: searchResult[0],
                }
            } else {
                response = {
                    code: CODE_FAITH,
                    message: '登录失败，请检查账号或密码是否错误',
                    data: null,
                }
            }

            resolve(Service.successResponse(response))
        } catch (e) {
            reject(
                Service.rejectResponse(
                    { code: CODE_ERROR, message: e.message || 'Invalid input' },
                    e.status || 405,
                ),
            )
        }
    })
