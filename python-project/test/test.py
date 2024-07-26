import pytest
from src.main import greet

def test_greet():
    assert greet("World") == "Hello, World!"
    assert greet("Jenkins") == "Hello, Jenkins!"
