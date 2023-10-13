import config from './config'
import logger from './logger'
import ExpressServer from './expressServer'

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

launchServer().catch((e) => logger.error(e))
