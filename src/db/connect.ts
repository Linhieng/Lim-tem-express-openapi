import mysql from 'mysql2/promise'

const poll = mysql.createPool({
    host: 'localhost',
    user: 'root',
    port: 3306,
    password: '1234',
    database: 'physical',
})

export default poll
