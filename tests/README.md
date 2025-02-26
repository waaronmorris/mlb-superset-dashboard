# Testing Documentation

This directory contains tests for various components of the MLB Stats & Fantasy Baseball Analytics platform.

## Test Categories

1. **Data Validation Tests**
   - Schema validation
   - Data type checks
   - Null value handling
   - Data consistency checks

2. **ETL Pipeline Tests**
   - MLB Stats API integration
   - Data transformation accuracy
   - Load performance
   - Error handling

3. **Database Tests**
   - PostgreSQL connection and queries
   - DuckDB performance and accuracy
   - Redis caching validation
   - Data persistence checks

4. **Integration Tests**
   - Superset dashboard functionality
   - API endpoint validation
   - Service communication
   - Authentication flows

## Running Tests

```bash
# Run all tests
make test

# Run specific test categories
make test-data
make test-etl
make test-db
make test-integration

# Run with coverage report
make test-coverage
``` 