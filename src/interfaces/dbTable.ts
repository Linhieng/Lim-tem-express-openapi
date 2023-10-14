/**
 * 数据库中所有表共有字段
 */
export interface TableBasic {
    /**
     * 主键，无语义
     */
    id: number
    /**
     * 1代表记录有效；0代表记录无效（相当于删除）
     */
    status: number
    /**
     * 记录创建时间
     */
    createTime: Date
    /**
     * 记录更新时间
     */
    updateTime: Date
}

/**
 * 医生信息表
 */
export interface DoctorInfo extends TableBasic {
    /**
     * 医生编码（用于登录）
     */
    doctorCode: string
    /**
     * 0女；1男；2保密
     */
    gender: number
    /**
     * 密码
     */
    password: string
    /**
     * 姓名
     */
    realName: string
}
