import pytest
import os
from pathlib import Path

@pytest.fixture(scope="session")
def test_env():
    """Setup test environment variables"""
    os.environ['TESTING'] = 'true'
    os.environ['DB_HOST'] = 'localhost'
    os.environ['REDIS_HOST'] = 'localhost'
    # Add other test environment variables as needed

@pytest.fixture(scope="session")
def test_data_dir():
    """Provide path to test data directory"""
    return Path(__file__).parent / 'data'

@pytest.fixture(autouse=True)
def setup_test_env(test_env):
    """Automatically setup test environment for all tests"""
    yield 