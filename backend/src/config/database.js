require('dotenv').config();
const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: process.env.DB_HOST,
  port: parseInt(process.env.DB_PORT || '3306', 10),
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  enableKeepAlive: true,
  keepAliveInitialDelay: 10000,
});

async function testConnection() {
  try {
    const connection = await pool.getConnection();
    console.log('MySQL connection successful');
    connection.release();
    return true;
  } catch (err) {
    console.error('MySQL connection failed:', err.message);
    return false;
  }
}

module.exports = {
  pool,
  testConnection,
};
