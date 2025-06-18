# Cash Register System

A Ruby on Rails application that implements a cash register system with product catalog and discount management.

## Features

- Product catalog with pricing
- Flexible discount system supporting:
  - Buy One Get One Free discounts
  - Fixed amount discounts
  - Percentage-based discounts
- Shopping basket functionality
- Real-time price calculations

## Requirements

- Ruby 3.3.6
- Rails 8.0.2
- SQLite3
- Bundler

## Setup Instructions

### 1. Clone and Install Dependencies

```bash
# Clone the repository
git clone <repository-url>
cd test_cash_register

# Install Ruby gems
bundle install
```

### 2. Database Setup

```bash
# Create and migrate the database
rails db:create
rails db:migrate

# Load sample data (includes products and discounts)
rails db:seed
```

The seed data includes:
- **Green Tea** (GR1) - €3.11 with Buy One Get One Free discount
- **Strawberries** (SR1) - €5.00 with €0.50 off when buying 3 or more
- **Coffee** (CF1) - €11.23 with 33.33% off when buying 3 or more

### 3. Run the Application

```bash
# Start the Rails server
rails server
```

The application will be available at `http://localhost:3000`

## Usage

1. Select quantities for each product
2. Click "Checkout" to see the calculated total with applicable discounts

## Project Structure

- `app/controllers/checkout_controller.rb` - Handles checkout flow
- `app/services/pricing_service.rb` - Calculates totals and line items
- `app/services/discount_service.rb` - Applies discount logic based on product and quantity
- `app/models/product.rb` - Product model
- `app/models/discount.rb` - Discount model
- `db/seeds.rb` - Sample data for testing


## Running Tests

```bash
# Run all tests
rails test

# Run specific test files
rails test test/controllers/checkout_controller_test.rb
rails test test/services/pricing_service_test.rb
rails test test/services/discount_service_test.rb

# Run model tests
rails test test/models/
```
