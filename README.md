# KubeCrab

Rails app for user friendly Kubernetes deployment.

## Features
- **Marketplace** - Users can deploy their crabs with a simple click
- **Templates** - Admins define crab template which will become available in the marketplace
- **Engines** - The templates are executed with an engine current engine supported is Kubernetes
- **Custom Engines** - Add your own custom engine i.e. docker, terraform etc.

## Local development with devcontainer

If you don't like to install ruby locally you can use a devcontainer which runs in docker.
Most editors support devcontainers right out of the box but some editors like VSCode need an extension.

### VSCode

To use a devcontainer with VSCode you need to install an extension:
  - https://code.visualstudio.com/docs/devcontainers/tutorial#_install-the-extension

## Local development

Using rbenv is a clean, reliable way to install and manage Ruby versions

1. Install rbenv using one of the following approaches.

   ### Homebrew

   On macOS, we recommend installing rbenv with [Homebrew](https://brew.sh).

   ```sh
   brew install rbenv ruby-build libpq
   export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
   ```
   Libpq needs to be in your path so ruby can use pg_config to build the pg gem.

   ### Linux

   On linux, we recommand installing rbenv from git.

   Clone rbenv into `~/.rbenv`.

   ```sh
   git clone https://github.com/rbenv/rbenv.git ~/.rbenv
   ```

2. Set up your shell to load rbenv.

   ```sh
   ~/.rbenv/bin/rbenv init
   ```

3. Install Ruby 3.3.5, make it global and check version

   ```sh
   rbenv install 3.3.5
   rbenv global 3.3.5
   ruby -v
   ```

4. Run bundle install

   ```sh
   bundle install
   ```

5. Run the rails development server and you can access it via http://localhost:3000

   ```sh
   bundle exec bin/dev
   ```

7. Start the migration for Ruby on Rails and seed the database from a second terminal.

   ```sh
   bundle exec rails db:prepare
   bundle exec rails db:seed
   ```

## Credentials && Encryption

When creating the docker image make sure you have created the credentials file first.

   ```sh
   bundle exec rails credentials:edit
   ```

By default it generates a secret_key_base used by Rails for encrypt cookies etc.

Since we use attribute encryption you need to run the following command and add the output to the credentials:

   ```sh
   bundle exec rails db:encryption:init

   [copy output]

   bundle exec rails credentials:edit

   [paste output]
   ```

## Deployment

### Build docker image

   ```sh
   docker build -t kubecrab .
   ```

### Run kubecrab

   ```sh
   docker run -v kubecrab:/rails/storage -e RAILS_MASTER_KEY=$(cat config/master.key) -ti kubecrab
   ```

### Run kubecrab worker

   ```sh
   docker run -v kubecrab:/rails/storage -e RAILS_MASTER_KEY=$(cat config/master.key) -ti kubecrab bin/jobs
   ```
