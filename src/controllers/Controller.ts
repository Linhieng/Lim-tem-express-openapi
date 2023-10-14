import fs from 'fs'
import path from 'path'
import config from '../config'
import logger from '../logger'

export default class Controller {
    static sendResponse(response, payload) {
        /**
         * The default response-code is 200. We want to allow to change that. in That case,
         * payload will be an object consisting of a code and a payload. If not customized
         * send 200 and the payload as received in this method.
         */
        response.status(payload.code || 200)
        const responsePayload =
            payload.payload !== undefined ? payload.payload : payload
        if (responsePayload instanceof Object) {
            response.json(responsePayload)
        } else {
            response.end(responsePayload)
        }
    }

    static sendError(response, error) {
        response.status(error.code || 500)
        if (error.error instanceof Object) {
            response.json(error.error)
        } else {
            response.end(error.error || error.message)
        }
    }

    /**
     * Files have been uploaded to the directory defined by config.js as upload directory
     * Files have a temporary name, that was saved as 'filename' of the file object that is
     * referenced in reuquest.files array.
     * This method finds the file and changes it to the file name that was originally called
     * when it was uploaded. To prevent files from being overwritten, a timestamp is added between
     * the filename and its extension
     * @param request
     * @param fieldName
     * @returns {string}
     */
    static collectFile(request, fieldName) {
        let uploadedFileName = ''
        if (request.files && request.files.length > 0) {
            const fileObject = request.files.find(
                (file) => file.fieldname === fieldName,
            )
            if (fileObject) {
                const fileArray = fileObject.originalname.split('.')
                const extension = fileArray.pop()
                fileArray.push(`_${Date.now()}`)
                uploadedFileName = `${fileArray.join('')}.${extension}`
                fs.renameSync(
                    path.join(config.FILE_UPLOAD_PATH, fileObject.filename),
                    path.join(config.FILE_UPLOAD_PATH, uploadedFileName),
                )
            }
        }
        return uploadedFileName
    }

    // static collectFiles(request) {
    //   logger.info('Checking if files are expected in schema');
    //   const requestFiles = {};
    //   if (request.openapi.schema.requestBody !== undefined) {
    //     const [contentType] = request.headers['content-type'].split(';');
    //     if (contentType === 'multipart/form-data') {
    //       const contentSchema = request.openapi.schema.requestBody.content[contentType].schema;
    //       Object.entries(contentSchema.properties).forEach(([name, property]) => {
    //         if (property.type === 'string' && ['binary', 'base64'].indexOf(property.format) > -1) {
    //           const fileObject = request.files.find(file => file.fieldname === name);
    //           const fileArray = fileObject.originalname.split('.');
    //           const extension = fileArray.pop();
    //           fileArray.push(`_${Date.now()}`);
    //           const uploadedFileName = `${fileArray.join('')}.${extension}`;
    //           fs.renameSync(path.join(config.FILE_UPLOAD_PATH, fileObject.filename),
    //             path.join(config.FILE_UPLOAD_PATH, uploadedFileName));
    //           requestFiles[name] = uploadedFileName;
    //         }
    //       });
    //     } else if (request.openapi.schema.requestBody.content[contentType] !== undefined
    //         && request.files !== undefined) {
    //       [request.body] = request.files;
    //     }
    //   }
    //   return requestFiles;
    // }

    static collectRequestParams(request) {
        const requestParams = {}
        if (request.openapi.schema.requestBody !== undefined) {
            const { content } = request.openapi.schema.requestBody
            if (content['application/json'] !== undefined) {
                const schema =
                    request.openapi.schema.requestBody.content[
                        'application/json'
                    ]
                //
                // 这里的代码是通过 OpenAPI Generator 生成的，在它的版本中 schema 身上似乎保留了 $ref，但在我的测试中，由于
                // express-openapi-validator 库的处理（借助 json-schema-ref-parser），$ref 属性已经被替换成具体的引用对象值了
                // 所以该 if 判断可能永远不会为 true
                // 之所以没有删掉这行代码，是因为该行代码的目的是获取请求体数据的接口对象名，如果能够实现的话，那么编写代码时会更加清晰
                // 在 services 中可以直接通过变量名知道数据是什么数据，而不是简单的一个 body
                //
                if (schema.$ref) {
                    requestParams[
                        schema.$ref.substr(schema.$ref.lastIndexOf('.'))
                    ] = request.body
                } else {
                    // @ts-ignore
                    requestParams.body = request.body
                }
            } else if (content['multipart/form-data'] !== undefined) {
                Object.keys(
                    content['multipart/form-data'].schema.properties,
                ).forEach((property) => {
                    const propertyObject =
                        content['multipart/form-data'].schema.properties[
                            property
                        ]
                    if (
                        propertyObject.format !== undefined &&
                        propertyObject.format === 'binary'
                    ) {
                        requestParams[property] = this.collectFile(
                            request,
                            property,
                        )
                    } else {
                        requestParams[property] = request.body[property]
                    }
                })
            }
        }
        // if (request.openapi.schema.requestBody.content['application/json'] !== undefined) {
        //   const schema = request.openapi.schema.requestBody.content['application/json'];
        //   if (schema.$ref) {
        //     requestParams[schema.$ref.substr(schema.$ref.lastIndexOf('.'))] = request.body;
        //   } else {
        //     requestParams.body = request.body;
        //   }
        // }
        request.openapi.schema.parameters.forEach((param) => {
            if (param.in === 'path') {
                requestParams[param.name] =
                    request.openapi.pathParams[param.name]
            } else if (param.in === 'query') {
                requestParams[param.name] = request.query[param.name]
            } else if (param.in === 'header') {
                requestParams[param.name] = request.headers[param.name]
            }
        })
        return requestParams
    }

    static async handleRequest(request, response, serviceOperation) {
        try {
            const serviceResponse = await serviceOperation(
                this.collectRequestParams(request),
            )
            Controller.sendResponse(response, serviceResponse)
        } catch (error) {
            Controller.sendError(response, error)
        }
    }
}
