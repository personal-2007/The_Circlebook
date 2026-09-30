const { pool, testConnection } = require('./config/database');

async function inspect() {
  const connected = await testConnection();
  if (!connected) {
    process.exit(1);
  }

  try {
    const [tables] = await pool.query('SHOW TABLES;');
    const tableNames = tables.map(t => Object.values(t)[0]);
    console.log('TABLES IN DATABASE:', tableNames);

    const [demoRows] = await pool.query('SELECT * FROM demo;');
    console.log('demo rows:', demoRows);
  } catch (err) {
    console.error('Error inspecting database:', err.message);
  } finally {
    await pool.end();
  }
}

inspect();
