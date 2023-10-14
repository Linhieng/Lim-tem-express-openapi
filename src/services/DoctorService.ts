/* eslint-disable no-unused-vars */
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
            const response: DoctorLoginResponse = {
                isSucceed: false,
            }

            const searchResult = await searchByCodeAndPass(data)

            if (searchResult.length > 0) {
                response.isSucceed = true
                response.doctor = searchResult[0]
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
