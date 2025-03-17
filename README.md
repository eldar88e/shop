# Test E-commerce Project

This is a test e-commerce project built with Ruby on Rails. Below are the necessary steps to set up and run the application.

## Requirements

- **Ruby version:** 3.4.2
- **Rails version:** 8.0.2
- **Database:** PostgreSQL
- **Dependencies:** Redis, Vite, StimulusReflex, ViewComponent, Turbo, Stimulus

## Installation

1. Clone the repository:
   ```sh
   git clone git@github.com:eldar88e/shop.git
   cd shop
   ```

2. Install dependencies:
   ```sh
   bundle install
   yarn install
   ```
3. Set up environment variables:
    ```sh
    cp .env.example .env
    ```
    Edit .env with the appropriate values.

4. Set up the database:
   ```sh
   rails db:prepare
   ```

5. Start the development server:
   ```sh
   rails server
   ```

## Gemfile Overview

### Core Gems
- `rails` - Ruby on Rails framework
- `puma` - Web server for Rails
- `pg` - PostgreSQL database adapter
- `dotenv` - Loads environment variables
- `slim-rails` - Slim templating engine
- `rails-i18n` - Internationalization support

### Frontend & JavaScript
- `vite_rails` - Vite.js integration
- `turbo-rails` - Hotwire Turbo for seamless updates
- `stimulus-rails` - Stimulus.js framework

### Caching
- `redis` - Required for caching and WebSockets

### WebSockets & Real-time Features
- `stimulus_reflex` - Enables real-time interactivity
- `view_component` - Encapsulated UI components
- `action-cable-redis-backport` - Redis-based Action Cable support
- `redis-session-store` - Session storage in Redis

### Development & Testing
- `pry` - Debugging tool
- `bullet` - Detects N+1 queries
- `brakeman` - Security vulnerability scanner
- `rubocop-rails-omakase` - Ruby code linter
- `web-console` - Interactive debugging console

### Deployment
- `kamal` - Deployment automation tool

## Deployment Instructions

1. Set up the production environment.
2. Configure database and Redis connections.
3. Use Kamal for deployment automation.

## Notes

This is a test project, and some features might be subject to change. Contributions and improvements are welcome!
