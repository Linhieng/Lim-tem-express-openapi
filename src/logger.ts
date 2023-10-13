import { createLogger, format, transports } from 'winston'

function generateFormat(
    timeFormat: string,
    options: { isAlign?: boolean; isColor?: boolean } = {
        isAlign: true,
        isColor: false,
    },
) {
    const combineItem = [
        format.timestamp({ format: timeFormat }),
        format.printf((info) => {
            if (info.level === 'error') {
                // 目前不需要考虑日志输出堆栈信息带来的性能问题
                return `${info.level} ${[info.timestamp]}: ${info.message} ${
                    info.error
                        ? `\n${info.error.message}\n${info.error.stack}`
                        : ''
                }`
            }
            return `${info.level}: ${[info.timestamp]}: ${info.message}`
        }),
    ]
    if (options.isAlign) {
        combineItem.push(format.align())
    }
    if (options.isColor) {
        combineItem.unshift(format.colorize())
    }
    return format.combine(...combineItem)
}

const logger = createLogger({
    level: 'info',
    format: generateFormat('YY-MM-DD HH:mm:ss'),
    defaultMeta: { service: 'user-service' },
    transports: [
        //
        // - Write all logs with importance level of `error` or less to `error.log`
        // - Write all logs with importance level of `info` or less to `combined.log`
        //
        new transports.File({ filename: 'error.log', level: 'error' }),
        new transports.File({ filename: 'combined.log' }),
    ],
})

//
// 非生成环境时，控制台的输出简单一些
//
if (process.env.NODE_ENV !== 'production') {
    logger.add(
        new transports.Console({
            format: generateFormat('HH:mm:ss', { isColor: true }),
        }),
    )
}
export default logger
