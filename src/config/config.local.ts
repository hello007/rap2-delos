import { IConfigOptions } from "../types";

let config: IConfigOptions = {
  version: '2.3',
  serve: {
    port: 1888,
  },
  keys: ['some secret hurr'],
  session: {
    key: 'rap2:sess',
  },
  db: {
    dialect: 'mysql',
    host: '192.9.210.89',
    port: 3306,
    username: 'root',
    password: 'root123456',
    database: 'RAP2_DELOS_APP_LOCAL',
    pool: {
      max: 5,
      min: 0,
      idle: 10000,
    },
    logging: false
  },
  redis: {
    isRedisCluster: false,
    host: '192.9.200.183',
    port: 6379,
    auth_pass: 'foobared'
  },
  mail: {
    host: 'smtp-mail.outlook.com',
    port: 587,
    secure: false,
    auth: {
      user: '',
      pass: ''
    }
  },
  mailSender: '',
}

export default config