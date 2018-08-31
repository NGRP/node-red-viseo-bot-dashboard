# Server for VISEO Bot Dashboard

### Configuration

The server does not use environement variables. All its settings are inside `${PROJECT_ROOT}/config/config.json`

The repository contains a `config.sample.json` in the same folder, to show how to write the configuration file.

The configuration file has a strict white-list validation system. If the file contains unknown field, or on one the field is not properly filled, the server will not start and an exception will be thrown explaining the reason.


### Start

Install the dependencies :
```shell
$ npm install
```

The server can be started with the following :
```shell
$ npm start
```

```shell
$ node index.js
```

Test can be run with the `package.json` test script

```shell
$ npm test
```

Linter for all javascript files :
```shell
$ npm run lint
```

### Info

Most of the server use (or will use) HAPI modules, since they are meant to work together.
