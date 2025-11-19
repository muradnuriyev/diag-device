# Relay Diagnostic System (YD)

This repository contains a complete stack for a relay diagnostics system:

- **Dataset desktop app** (`dataset/datasetYD.py`)  
  Reads measurements from a microcontroller over a serial port and stores them in a MySQL database `yd_information_package`.
- **Backend API** (`project/diagnostic-be/app.py`)  
  Flask application that aggregates data from MySQL and exposes it via REST endpoints.
- **Web UI** (`project/diagnostic-ui`)  
  React/TypeScript/Vite interface for operators.
- **Databases and Docker setup**  
  SQL dumps and Docker configuration for MySQL + phpMyAdmin.

The project in its current state implements the most important scenarios:

- operator login with username/password;
- real‑time monitoring of alarms and warnings (Home page);
- interval analysis of currents and other parameters (Interval analysis page);
- note taking for operators (Note page, database `yd_note_workers`).

Some other UI tabs were planned but are only partially implemented.

---

## Repository structure

- `dataset/datasetYD.py` – desktop app (Tkinter) for reading packets from the microcontroller and writing them to the `yd_information_package` database.
- `project/diagnostic-be/app.py` – Flask backend API.
- `project/diagnostic-ui` – front‑end (React + TypeScript + Vite + Tailwind).
- `yd_information_package.sql` – dump of the measurement database (table `yd_1` with data, plus stored procedures).
- `yd_user_db.sql` – dump of the user database (logins/passwords).
- `docker/`
  - `docker-compose.yml` – MySQL + phpMyAdmin.
  - `docker/mysql-init/*.sql` – initialization scripts:
    - `01-init-yd_user_db.sql` – creates `yd_user_db` and imports the dump.
    - `02-init-yd_information_package.sql` – creates `yd_information_package` and imports the dump.
    - `02b-create-yd_tables.sql` – creates tables `yd_2` … `yd_58` using `yd_1` as a template.
    - `03-init-yd_note_workers.sql` – creates `yd_note_workers` and its main table.

---

## High‑level architecture

### 1. Data acquisition (dataset app)

The `dataset/datasetYD.py` application:

- connects to MySQL:
  - `host='localhost'`
  - `user='root'`
  - `password=''`
  - `database='yd_information_package'`
- searches for the first available serial port (`list_ports.comports()`), opens it (9600 baud);
- continuously reads lines, decodes them and splits by `/`;
- expects exactly 31 values per packet:
  - the first value is the YD number (`yd_value`);
  - builds a table name `yd_<yd_value>`;
  - executes `INSERT` into the corresponding `yd_N` table.

Each row in `yd_N` contains:

- general info (`YD`, `YD_Info`, `Package_Num`, `Timestamp`);
- control parameters (`RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `BlokKontakt`, `Block_Contact_N`);
- voltages (`U_AB`, `U_BC`, `U_AC`, `V_of_Device`);
- currents (`CurrentValue1..CurrentValue10`, `Current_Accident_A/B/C`);
- `Conversion_Period` and other fields.

The app also has a simple Tkinter UI where you can:

- start/stop data collection;
- open a window with buttons `yd_1` … `yd_58` and view raw table contents.

### 2. Databases

There are three MySQL databases:

1. **`yd_information_package`**
   - Tables `yd_1` … `yd_58` – measurement tables per relay line.
   - Populated by the dataset app.

2. **`yd_user_db`**
   - Table `users` – user login data:
     - `username`, `password`, `fullName`, `Vezife` (position), `Sahe` (area/section), etc.
   - Used by the login page in the web UI.

3. **`yd_note_workers`**
   - Table `yd_note_workers` – operator notes:
     - `Sahe`, `FullName`, `Note`, `timestamp`.
   - Used by the Note page in the web UI.

### 3. Backend API (Flask, `project/diagnostic-be`)

The backend sets up three MySQL connection pools (for each database) and exposes data via HTTP.

Key parts:

- CORS is enabled for `http://localhost:5173` (the Vite dev server).
- Connection configs:
  - host: `localhost`
  - user: `root`
  - password: empty
  - databases: `yd_user_db`, `yd_information_package`, `yd_note_workers`.

#### Main endpoints

- `POST /login`  
  Authenticates a user against `yd_user_db.users`.  
  Returns:
  - message (`Login successful` / `Invalid login credentials`);
  - user info (includes `Sahe` pulled from the database).

- `GET /alarms`  
  Aggregates alarms across all tables `yd_1..yd_58`.  
  For every record it:
  - checks `V_of_Device` thresholds,
  - checks `Temperature`,
  - uses `RightTurn`/`LeftTurn` to detect track switch problems,
  - uses `SOBS3AP`, `SOBS_Lost_Of_Control`, `NumOfControl`, `Package_Num`, `Conversion_Period`, and others;
  - builds a list of alarm objects with:
    - `TableNumber` (e.g. `YD-01`),
    - `AlarmDescription`,
    - `Timestamp`,
    - specific field values that triggered the alarm.

  The Home page uses this endpoint to show the latest alarms.

- Metadata and helper endpoints for analytics:

  - `GET /table_numbers` – list of YD table numbers.
  - `GET /timestamps/<int:table_number>` – available timestamps for `yd_<table_number>`.

- Time‑series endpoints (used by Current/Interval analysis pages):

  - `GET /current_values_data/<table>/<from_timestamp>/<to_timestamp>`
  - `GET /current_accident_values_data/<table>/<from_timestamp>/<to_timestamp>`
  - `GET /u_all_data/<table>/<from_timestamp>/<to_timestamp>`
  - `GET /v_of_device_data/<table>/<from_timestamp>/<to_timestamp>`
  - `GET /temperature_data/<table>/<from_timestamp>/<to_timestamp>`
  - `GET /block_contact_n_data/<table>/<from_timestamp>/<to_timestamp>`
  - `GET /block_contact_data/<table>/<from_timestamp>/<to_timestamp>`
  - `GET /conversion_period_data/<table>/<from_timestamp>/<to_timestamp>`
  - `GET /num_of_control_data/<table>/<from_timestamp>/<to_timestamp>`
  - `GET /kurbel_data/<table>/<from_timestamp>/<to_timestamp>`
  - `GET /sobs_lost_of_control_data/<table>/<from_timestamp>/<to_timestamp>`

  Each of these endpoints queries `yd_information_package` and returns an array of records tailored for charts (timestamp + one or more fields).

- Notes:
  - `POST /store_note` – store a note into `yd_note_workers.yd_note_workers`.
  - `GET /get_notes` – list notes (used by the Note page).

### 4. Frontend (React/Vite, `project/diagnostic-ui`)

Routing is defined in `src/App.tsx` using `react-router-dom`:

- `/login` – login page.
- `/auth/*` – protected area wrapped by `AuthLayout`.

Important routes:

1. **Login page (`/login`)**
   - Sends credentials to `POST http://localhost:5000/login`.
   - On success navigates to `/auth/home`.

2. **Home page (`/auth/home`, `HomePage.tsx`)**
   - Polls `GET http://localhost:5000/alarms` every ~1.5 seconds.
   - Shows list of alarms with timestamp, YD table number, and description.
   - On new incoming alarm:
     - shows toast notification (`react-toastify`);
     - plays a sound (`notification.mp3`);
     - highlights warnings via icon color (`AiFillWarning`).

3. **Interval Analysis (`/auth/interval-analysis`, `IntervalAnalysisPage.tsx`)**
   - UI:
     - select YD table number (`yd_1..yd_58`);
     - select `from` / `to` timestamps (values come from `/timestamps/<table>`).
   - On clicking the confirm button:
     - calls multiple backend endpoints:
       - `current_values_data`, `current_accident_values_data`;
       - `u_all_data`, `v_of_device_data`, `temperature_data`;
       - `block_contact_n_data`, `block_contact_data`;
       - `conversion_period_data`, `num_of_control_data`, `kurbel_data`;
       - `sobs_lost_of_control_data`.
     - renders several charts using `recharts`:
       - DC supply voltage;
       - internal temperature;
       - currents (10 channels);
       - fault currents per phase;
       - counts of control loss, switching, etc.;
       - block contact state and other metrics.

4. **Current Analysis (`/auth/current-analysis`)**
   - Uses the same family of endpoints to show current values in a more compact layout (snapshot / shorter interval).

5. **Notes (`/auth/note`)**
   - Allows operator to create and view notes (stored in `yd_note_workers`).

Other pages (`History`, `Help`, `TechnicalProsPlan`, `IQ3Journal`) exist in the router and UI, but their business logic is incomplete and may require additional backend work.

---

## Running MySQL and phpMyAdmin via Docker

The recommended way to run the databases is using Docker.

### Requirements

- Docker and Docker Compose installed.
- Ports:
  - `3306` – MySQL;
  - `8080` – phpMyAdmin.

### Start services

From the repo root:

```bash
docker compose up -d
```

This will:

- start `diag-mysql` (MySQL 8.0);
- on first run, automatically:
  - create and populate `yd_user_db` from `yd_user_db.sql`;
  - create and populate `yd_information_package` from `yd_information_package.sql`;
  - create tables `yd_2..yd_58` from `yd_1`;
  - create `yd_note_workers` with its table;
- start `diag-phpmyadmin` on `http://localhost:8080`.

Login to phpMyAdmin:

- server: `mysql` (from inside Docker network) or `localhost` in the browser;
- user: `root`;
- password: **empty**.

Check containers:

```bash
docker compose ps
```

You should see `diag-mysql` and `diag-phpmyadmin` in `Up` state.

---

## Running the backend (Flask API)

The backend expects MySQL to be available at `localhost:3306` with user `root` and an empty password (the Docker compose file is configured for this).

### Install dependencies

Run once:

```bash
python -m pip install flask flask-cors mysql-connector-python
```

### Start the server

```bash
cd project/diagnostic-be
python app.py
```

You should see something like:

```text
 * Running on http://127.0.0.1:5000
```

Make sure `docker compose up -d` has been run before this step, otherwise the backend will fail to connect to MySQL.

---

## Running the frontend (React/Vite)

### Install Node dependencies

```bash
cd project/diagnostic-ui
npm install
```

### Development server

```bash
npm run dev
```

By default, Vite uses `http://localhost:5173`.  
The frontend sends requests to the backend using `API_BASE_URL`:

- configured via `VITE_API_BASE_URL` in a `.env` file, or
- defaults to `http://localhost:5000` if not set.

### Production build

```bash
npm run build
```

Build output lives in `project/diagnostic-ui/dist`.

---

## Running the dataset application

The dataset app is independent from the web stack but uses the same MySQL.

### Requirements

- Python with:
  - `pyserial`
  - `mysql-connector-python`

Install:

```bash
python -m pip install pyserial mysql-connector-python
```

### Start

```bash
cd dataset
python datasetYD.py
```

Steps:

1. Ensure MySQL is running (`docker compose up -d`).
2. Connect the microcontroller to the PC.
3. Press the “Start” button in the dataset UI to begin logging.

New records will appear in `yd_information_package.yd_<N>` tables and will then be visible in the web UI (Home and Interval analysis).

---

## What is currently working

- **Login** via `yd_user_db.users`.
- **Home** page:
  - visible list of current alarms from `yd_information_package`;
  - toast notifications and sound for new alarms.
- **Interval analysis**:
  - fetching and charting historical measurements for a given YD in a time interval.
- **Current analysis**:
  - real‑time or short‑interval view of currents and other parameters.
- **Notes**:
  - storing and viewing notes in `yd_note_workers`.

Other tabs exist but may be incomplete or stubbed.

---

## Typical end‑to‑end startup sequence

1. Start databases:

   ```bash
   docker compose up -d
   ```

2. Start backend:

   ```bash
   cd project/diagnostic-be
   python app.py
   ```

3. Start frontend:

   ```bash
   cd project/diagnostic-ui
   npm install      # first time only
   npm run dev
   ```

4. Optionally start dataset:

   ```bash
   cd dataset
   python datasetYD.py
   ```

At this point:

- databases are running in Docker;
- backend is available at `http://localhost:5000`;
- frontend is available at `http://localhost:5173`;
- dataset app (if running) continuously feeds new measurements into MySQL.

---

## Possible future improvements

- Implement full backend logic for the remaining UI tabs (`History`, `Help`, `TechnicalProsPlan`, `IQ3Journal`).
- Add Docker images for backend and frontend so that the entire system can be started with a single `docker compose up` (including API and UI).
- Move database credentials (`root` / empty password, hosts, ports) into environment variables instead of hard‑coding.
- Provide a “simulation mode” for development that generates synthetic measurement data without a real microcontroller.

This README is intended to be a high‑level map of the system so that someone new can understand how the microcontroller, MySQL databases, backend, and web UI fit together and where to continue development.
