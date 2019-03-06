# 搭建生产版本及运行过程
> 当前项目已经修正，可以直接打包运行（标注日期：2019年3月6日）
## 配置文件
打包前，如需修改，见 /src/config/config.***.ts  
打包成dist文件夹后，如需修改，见 /dist/config/config.***.js 
## 数据库
### 执行创建数据库脚本
CREATE DATABASE IF NOT EXISTS RAP2_DELOS_APP DEFAULT CHARSET utf8 COLLATE utf8_general_ci
> 其中，数据库名称需要与config.***.ts中的db中的database值保持一致，生产现在的数据库名称为 rap， 开发测试数据库为 RAP2_DELOS_APP。

> 有可能会自动创建表结构，但推荐还是从其他环境导入sql创建表，可参考同级的rap2_delos_app.sql。

## 打包&运行
> 1. 执行npm run build，打包到dist
> 2. 将dist文件夹、package.json、tsconfig.json上传到服务器
> 3. 执行npm install (待验证是否需要安装所有依赖，还是只装一个pm2即可)
> 4. 执行npm start

## 停止服务
> 执行 npm run clent 即可

## 测试
> 在浏览器中访问ip:port（如http://192.9.200.183:18888/），出现 Hello RAP! 字样表示服务器么问题。


# RAP2-DELOS 开源社区版本 (后端API服务器)

[![Build Status](https://travis-ci.org/thx/rap2-delos.svg?branch=master)](https://travis-ci.org/thx/rap2-delos)

RAP2是在RAP1基础上重做的新项目，它包含两个组件(对应两个Github Repository)。

* rap2-delos: 后端数据API服务器，基于Koa + MySQL[link](http://github.com/thx/rap2-delos)
* rap2-dolores: 前端静态资源，基于React [link](http://github.com/thx/rap2-dolores)

### Resources

* [Official Site 官网: rap2.taobao.org](http://rap2.taobao.org)
* 钉钉群ID: 11789704
* [热心网友提供的部署文档，供参考](https://github.com/thx/rap2-delos/issues/119)

## 部署

### 环境要求
* Node.js 8.9.4+
* MySQL 5.7+
* Redis 4.0+

### 开发模式

#### 安装MySQL和Redis服务器

请自行查找搭建方法，mysql/redis配置在config.*.ts文件中，在不修改任何配置的情况下，
redis会通过默认端口 + 本机即可正常访问，确保redis-server打开即可。

#### 启动redis-server

```sh
redis-server
```

后台执行可以使用nohup或pm2，这里推荐使用pm2，下面命令会安装pm2，并通过pm2来启动redis缓存服务

```bash
npm install -g pm2
npm run start:redis
```

#### 先创建创建数据库

```bash
mysql -e 'CREATE DATABASE IF NOT EXISTS RAP2_DELOS_APP DEFAULT CHARSET utf8 COLLATE utf8_general_ci'
```

#### 初始化

```bash
npm install
```

confirm configurations in /config/config.dev.js (used in development mode)，确认/config/config.dev.js中的配置(.dev.js后缀表示用于开发模式)。

#### 安装 && TypeScript编译

```bash
npm install -g typescript
npm run build
```

#### 初始化数据库表

```bash
npm run create-db
```

#### 执行mocha测试用例和js代码规范检查
```bash
npm run check
```

#### 启动开发模式的服务器 监视并在发生代码变更时自动重启
```bash
npm run dev
```

### 生产模式

```sh
# 1. 修改/config/config.prod.js中的服务器配置
# 2. 启动生产模式服务器
npm start

```

## Dockerfile (本地源码通过docker运行）
```sh
# 1. 安装docker
# 2. 修改docker-compose.xml中的配置。默认使用mysql和redis的镜像。可修改为自己的配置
# 3. 通过源码运行。
        docker-compose up -d
# 4. 第一次运行需要手动初始化mysql数据库。分别执行以下命令：
        docker exec -it rap2-delos sh
    // 登录成功以后执行：
        node scripts/init
    // 执行完毕后退出
        exit
    // 如果仍然有问题，重新启动
        docker-compose down
    // 重新运行
        docker-compose up -d
```


## Author
* 版权: 阿里妈妈前端团队
* 作者:
  * RAP2 2017/10前版本作者为[墨智(@Nuysoft)](https://github.com/nuysoft/), [mockjs](mockjs.com)的作者。
  * 2017/10之后版本开发者
    * [霍雍(Bosn)](http://github.com/bosn/)，[RAP1](http://github.com/thx/RAP)作者，RAP最早的创始人。
    * [承虎(alvarto)](http://github.com/alvarto/)

### Tech Arch

* 前端架构(rap2-dolores)
    * React / Redux / Saga / Router
    * Mock.js
    * SASS / Bootstrap 4 beta
    * server: nginx
* 后端架构(rap2-delos)
    * Koa
    * Sequelize
    * MySQL
    * Server
    * server: node
