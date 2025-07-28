from django.core.cache import cache
from django.db import OperationalError, connections
from django.test import TestCase
from django_redis import get_redis_connection


class ConnectionTests(TestCase):
    def test_database_connection(self):
        """Test that the default database connection can be established."""
        db_conn = connections["default"]
        try:
            db_conn.cursor()
        except OperationalError:
            self.fail("Database connection failed!")

    def test_redis_connection(self):
        """Test that the Redis connection can be established."""
        try:
            # Test using Django's cache framework
            cache.set("test_key", "test_value", timeout=10)
            value = cache.get("test_key")
            self.assertEqual(value, "test_value")
            # Test direct Redis connection
            redis_conn = get_redis_connection("default")
            redis_conn.ping()
        except Exception as e:
            self.fail(f"Redis connection failed: {str(e)}")
