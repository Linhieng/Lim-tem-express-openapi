/* eslint-disable no-unused-vars */
import { DoctorLoginRequest, ResponseResult } from '../interfaces'
import Service from './Service'

/**
 * 医生登录
 *
 * doctorLoginRequest DoctorLoginRequest  (optional)
 * returns Result
 * */
export const doctorGetDoctorByCodeByPassPOST = ({ body, doctorLoginRequest }) =>
    new Promise(async (resolve, reject) => {
        try {
            const data: DoctorLoginRequest = doctorLoginRequest || body
            const response: ResponseResult = {
                isSucceed: false,
            }
            if (data.docCode === '123' && data.password === '123') {
                response.isSucceed = true
            }
            resolve(Service.successResponse(response))
        } catch (e) {
            reject(
                Service.rejectResponse(
                    e.message || 'Invalid input',
                    e.status || 405,
                ),
            )
        }
    })
