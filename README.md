# CreditApp

A Phoenix app for credit applications: user registration, survey, salary input, PDF summary generation, and email delivery. Built with Elixir, LiveView, pdf_generator, and Swoosh.

## Features
- Survey form.
- Salary calculation and credit limit.
- PDF generation and email attachment.
- Flash messages and local email testing.

### Instructions to Run CreditApp Locally

#### 1. Unpack the Archive
- Extract the `credit_app` folder from the archive to a directory (e.g., `C:\Projects\credit_app` on Windows, `~/Projects/credit_app` on Ubuntu/macOS).
- Navigate to the project folder:
  ```bash
  cd path/to/credit_app
  ```

#### 2. Install Prerequisites
You need Elixir, Node.js, wkhtmltopdf, and SQLite3 installed. Follow the steps for your operating system.

##### Windows
1. **Elixir and Erlang**:
   - Download and run the Elixir installer from [elixir-lang.org](https://elixir-lang.org/install.html).
   - Verify:
     ```cmd
     elixir --version
     ```
     Look for: `Elixir 1.15.0` or higher.

2. **Node.js**:
   - Download the LTS version (16 or higher) from [nodejs.org](https://nodejs.org).
   - Install and add to PATH.
   - Verify:
     ```cmd
     node --version
     ```
     Look for: `v16.x.x` or higher.

3. **wkhtmltopdf** (for PDFs):
   - Download from [wkhtmltopdf.org](https://wkhtmltopdf.org/downloads.html).
   - Install and add to PATH (e.g., `C:\Program Files\wkhtmltopdf\bin`).
   - Verify:
     ```cmd
     wkhtmltopdf --version
     ```

4. **SQLite3**:
   - Download tools from [sqlite.org](https://www.sqlite.org/download.html).
   - Add `sqlite3.exe` to PATH (e.g., `C:\sqlite`).
   - Verify:
     ```cmd
     sqlite3 --version
     ```

##### Ubuntu
1. **Elixir and Erlang**:
   ```bash
   sudo apt update
   sudo apt install -y elixir
   ```
   - Verify:
     ```bash
     elixir --version
     ```

2. **Node.js**:
   ```bash
   curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
   sudo apt install -y nodejs
   ```
   - Verify:
     ```bash
     node --version
     ```

3. **wkhtmltopdf**:
   ```bash
   sudo apt install -y wkhtmltopdf
   ```
   - Verify:
     ```bash
     wkhtmltopdf --version
     ```

4. **SQLite3**:
   ```bash
   sudo apt install -y sqlite3
   ```
   - Verify:
     ```bash
     sqlite3 --version
     ```

##### macOS
1. **Install Homebrew** (if not installed):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Elixir and Erlang**:
   ```bash
   brew install elixir
   ```
   - Verify:
     ```bash
     elixir --version
     ```

3. **Node.js**:
   ```bash
   brew install node
   ```
   - Verify:
     ```bash
     node --version
     ```

4. **wkhtmltopdf**:
   ```bash
   brew install wkhtmltopdf
   ```
   - Verify:
     ```bash
     wkhtmltopdf --version
     ```

5. **SQLite3**:
   ```bash
   brew install sqlite
   ```
   - Verify:
     ```bash
     sqlite3 --version
     ```

#### 3. Install Project Dependencies
In the `credit_app` folder, run:
```bash
mix deps.get
mix deps.compile
cd assets && npm install && cd ..
```

#### 4. Set Up the Database
The app uses SQLite3. Initialize the database:
```bash
mix ecto.setup
```

#### 5. Build Assets and Compile
Compile the app and assets:
```bash
mix assets.build
mix compile
```

#### 6. Run tests
Run tests:
```bash
mix test
```

#### 6. Start the Application
Run the Phoenix server:
```bash
mix phx.server
```

#### 8. Access the App
- Open a browser and go to `http://localhost:4000`.
- Follow these steps:
  1. Visit `/users/new` to create a user (enter name and email).
  2. Check for the flash message `"User created successfully."` on `/survey/:id`.
  3. Complete the survey form.
  4. Go to `/salary/:id`, enter income and expenses, and submit.
  5. Check for the flash message `"Congratulations, you have been approved..."` on `/`.
  6. Visit `http://localhost:4000/dev/mailbox` to see the emailed PDF.

#### 9. Troubleshooting
- **App Doesn’t Start**:
  - Check prerequisites:
    ```bash
    elixir --version
    node --version
    wkhtmltopdf --version
    sqlite3 --version
    ```
  - Run with verbose output:
    ```bash
    mix compile --force --verbose
    ```
  - Share errors with the archive recipient.

- **Flash Messages Missing**:
  - Ensure the browser isn’t blocking JavaScript (needed for LiveView).
  - Check server logs:
    ```bash
    tail -f log/dev.log
    ```

- **PDF Not Generated**:
  - Verify `wkhtmltopdf --version`.
  - Check logs for `PDF Debug` output (if added to `lib/credit_app/pdf.ex`).

- **Email Not Sent**:
  - Visit `http://localhost:4000/dev/mailbox`.
  - Check logs for `Email Debug` output (if added to `lib/credit_app/email.ex`).

#### 10. Notes
- **Port Conflicts**: If `http://localhost:4000` is unavailable, check for port 4000 usage:
  - Windows: `netstat -an | findstr 4000`
  - Ubuntu/macOS: `ss -tuln | grep 4000`
  - Change port in `config/dev.exs` if needed (e.g., `http: [port: 4001]`).
- **Windows PATH**: Restart your terminal after adding `wkhtmltopdf` or `sqlite3` to PATH.
- **Database**: The SQLite database (`credit_app_dev.db`) is created in the project folder. Ensure write permissions.
- **Archive Contents**: Ensure the archive includes:
  - `mix.exs`
  - `lib/credit_app/*`
  - `lib/credit_app_web/*`
  - `config/*`
  - `assets/*`
