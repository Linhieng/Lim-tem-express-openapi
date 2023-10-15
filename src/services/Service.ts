import { ResponseError, ResponseGeneral } from '../interfaces'

export default class Service {
    static rejectResponse(error: ResponseError, code = 500) {
        return { error, code }
    }

    static successResponse(payload: ResponseGeneral, code = 200) {
        return { payload, code }
    }
}
