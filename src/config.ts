import path from 'path'

type ConfigType = {
    ROOT_DIR: any
    URL_PORT: any
    URL_PATH: any
    BASE_VERSION: any
    CONTROLLER_DIRECTORY: any
    PROJECT_DIR: any
    OPENAPI_YAML: any
    FULL_PATH: any
    FILE_UPLOAD_PATH: any
}

const config = {
    ROOT_DIR: __dirname,
    URL_PORT: 3000,
    URL_PATH: 'http://localhost',
    BASE_VERSION: 'v2',
    CONTROLLER_DIRECTORY: path.join(__dirname, 'controllers'),
    PROJECT_DIR: __dirname,
} as ConfigType

config.OPENAPI_YAML = path.join(config.ROOT_DIR, 'api', 'openapi.yaml')
config.FULL_PATH = `${config.URL_PATH}:${config.URL_PORT}/${config.BASE_VERSION}`
config.FILE_UPLOAD_PATH = path.join(config.PROJECT_DIR, 'uploaded_files')

export default config
