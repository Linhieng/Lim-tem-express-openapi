import poll from '../db/connect'
import { DoctorLoginRequest } from '../interfaces'
import { DoctorInfo } from '../interfaces/dbTable'
import convertToCamelCase from '@linhieng/camelcase'

export async function searchByCodeAndPass({
    doctorCode,
    password,
}: DoctorLoginRequest): Promise<Array<DoctorInfo>> {
    const [rows, fields] = await poll.query(
        `SELECT * FROM doctor_info WHERE doctor_code="${doctorCode}" and password="${password}";`,
    )

    return convertToCamelCase(rows) as any
}
