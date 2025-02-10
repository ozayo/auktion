# Project Setup Guide

This guide will help you set up the project on your local machine, including the backend, frontend, and PostgreSQL database.

## Prerequisites

Before you begin, ensure you have the following installed:

- [Node.js](https://nodejs.org/) (v14 or later)
- [npm](https://www.npmjs.com/) (comes with Node.js)
- [PostgreSQL](https://www.postgresql.org/download/) (version 15 or higher)
- [Git](https://git-scm.com/downloads)

## Step 1: Clone the Repository

Open your terminal and run the following command to clone the repository:

```bash
git clone https://github.com/ozayo/auktion.git
```

```bash
cd your-repo-name
```


## Step 1: Set Up the Frontend (NextJS)

1. **Navigate to the frontend directory:**

   ```bash
   cd ../frontend
   ```

2. **Install dependencies:**

   ```bash
   npm install
   ```



## Step 2: Set Up the Backend (Strapi)

1. **Navigate to the backend directory:**

   ```bash
   cd backend
   ```

2. **Install dependencies:**

   ```bash
   npm install
   ```


## Step 3: Set up the PostgreSQL database and load DB Backup

In this step, we will create a new database on our computer and load the backed-up project database from the `/db` folder into this newly created database.

We assume that PostgreSQL is installed on your computer and that you can use `psql` commands.

1. **Create a new PostgreSQL database:**

Open your terminal and run the following command to create a new PostgreSQL database:

  ```bash
  psql -U your_username -c "CREATE DATABASE your_database_name;"
  ```


2. **Load Database Backup:**

Open your terminal and run the following command to load the backup into your PostgreSQL database:

  ```bash
  psql -U your_username -d your_database_name -f /path/to/your/db/backup.sql
  ```
Replace /path/to/your/db/backup.sql with the actual path to your SQL backup file.



## Step 4: Fix and Check .env files

If your not sure about .env files content ask to project admin for details.

1. **Backend .env file**

Create a `.env` file in the `/backend/` directory and add the following environment variables:

  ```env
  # Server
  HOST=0.0.0.0
  PORT=1337

  # Secrets
  APP_KEYS=<your-app-keys>
  API_TOKEN_SALT=<your-api-token-salt>
  ADMIN_JWT_SECRET=<your-admin-jwt-secret>
  TRANSFER_TOKEN_SALT=<your-transfer-token-salt>

  # Database
  DATABASE_CLIENT=postgres
  DATABASE_HOST=127.0.0.1 
  DATABASE_PORT=5432
  DATABASE_NAME=your_database_name
  DATABASE_USERNAME=your_db_username
  DATABASE_PASSWORD=your_db_password
  DATABASE_SSL=false
  JWT_SECRET=your-jwt-secret
  ```

2. **Frontend .env.local file**

Create a `.env.local` file in the `/frontend/` directroy and add the following;

  ```env
  NEXT_PUBLIC_API_URL=http://localhost:1337
  ```

## Step 5: Start backend & frontend services

If you have successfully completed all the steps above, you should be able to run the application with the commands below.

1. **Make sure your DB is working**

You can check whether the database is working or not with the code you will write in the terminal below:

  ```bash
  brew services list
  ```
If you see an output like `postgresql@15 started ...` in the terminal, it means the database is running.

2. **Start the backend server:**

Start the Strapi backend with

   ```bash
   npm run develop 
   ```

  The backend should now be running on `http://localhost:1337`.

3. **Start the frontend server:**

   ```bash
   npm run dev
   ```

  The frontend should now be running on `http://localhost:3000`.



## Troubleshooting

- If you encounter any issues, ensure that your PostgreSQL server is running and that the connection details in your `.env` files are correct.
- Remember that both the frontend and backend services need to be running at the same time.
- Check the console for any error messages and refer to the documentation for the specific libraries or frameworks you are using.

## Documantation links

**Backend**
- [Strapi Developer Doc](https://docs.strapi.io/dev-docs/intro)
- [Strapi User Doc](https://docs.strapi.io/user-docs/intro) all about using Strapi's admin panel.

**Frontend**
- [NextJS Doc](https://nextjs.org/docs)

**Project Doc**

-  [Project Doc](https://github.com/ozayo/auktion/issues/14) Detailed information about customizable areas in the project.

**PostgreSQL**

- [PostgreSQL](https://www.postgresql.org/)
- [PostgreSQL Download](https://www.postgresql.org/download/)
- [How to install PostgreSQL on a Mac with Homebrew](https://www.moncefbelyamani.com/how-to-install-postgresql-on-a-mac-with-homebrew-and-lunchy/)
- [psql commands](https://www.postgresql.org/docs/current/app-psql.html)

## Conclusion

You have successfully set up the project on your local machine. You can now start developing and testing the application. If you have any questions or need further assistance, feel free to reach out.


