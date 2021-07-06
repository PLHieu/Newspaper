const knex = require('knex')({
    client: 'mysql2',
    connection: {
        host: 'localhost',
        user: 'root',
        password: 'root',
        database: 'newspaper',
        port: 8889
    },
    pool: {
        min: 0,
        max: 50
    }
});

module.exports = knex;