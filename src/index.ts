import config from './config'
import logger from './logger'
import ExpressServer from './expressServer'
import poll from './db/connect' // 导入时，执行连接 DB 操作

const launchServer = async () => {
    try {
        const expressServer = new ExpressServer(
            config.URL_PORT,
            config.OPENAPI_YAML,
        )
        expressServer.launch()
        logger.info('Express server running')
    } catch (error) {
        logger.error({
            message: 'Express Server failure',
            error,
        })
    }
}

launchServer().catch((e) => logger.error({ message: 'root error', error: e }))
