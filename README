# Icecast Directory
This is the new directory software to power [dir.xiph.org](http://dir.xiph.org), but is currently
undergoing testing at [dir-test.xiph.org](http://dir-test.xiph.org).

## Installation

Get a recent node version, like v5.x.

Install all dependencies with:

```
npm install
```

Create a postgres user:

```sql
CREATE USER diruser WITH PASSWORD 'dirpass';
```

And Database:

```sql
CREATE DATABASE xiphdirectory;
GRANT ALL PRIVILEGES ON DATABASE xiphdirectory to diruser;
```

Now login as the newly created user, change to the right database:

```
\c xiphdirectory
```

and load the create_tables.sql file:

```
\i create_tables.sql
```

Now you are ready to run the server with:

```
node app.js
```
