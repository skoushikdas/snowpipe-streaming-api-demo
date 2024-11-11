import unittest
from unittest.mock import patch, MagicMock
from ingestion.session.spark.session_singleton import SparkSessionSingleton
from ingestion.utils.logging.log_util import Logger  # Assuming this is your logging utility
from ingestion.load.snowflake.write_stream.write_stream import JavaAdapter  # Adjust the path if needed

class TestJavaAdapter(unittest.TestCase):
    @patch('ingestion.session.spark.session_singleton.SparkSessionSingleton.get_spark_session')
    def setUp(self, mock_get_spark_session):
        # Mock the Spark session and JVM
        self.mock_spark = MagicMock()
        self.mock_jvm = MagicMock()
        self.mock_spark.jvm = self.mock_jvm
        mock_get_spark_session.return_value = self.mock_spark
        
        # Initialize JavaAdapter with the mocked Spark session and JVM
        self.java_adapter = JavaAdapter("com.example.JavaClass")
    
    @patch('ingestion.load.snowflake.write_stream.write_stream.getattr')
    @patch('ingestion.utils.logging.log_util.Logger')  # Adjust if the Logger import path differs
    def test_invoke_method_success(self, mock_logger, mock_getattr):
        # Mock the Java method that will be invoked
        mock_method = MagicMock(return_value="Java method result")
        mock_getattr.return_value = mock_method

        # Call invoke_method and verify the result
        result = self.java_adapter.invoke_method("someMethod", "arg1", "arg2")
        self.assertEqual(result, "Java method result")

        # Verify method invocation and logging behavior
        mock_getattr.assert_called_with(self.java_adapter.java_class, "someMethod")
        mock_method.assert_called_once_with("arg1", "arg2")
        mock_logger.info.assert_called_with(f"Calling method someMethod from {self.java_adapter.java_class}")

    @patch('ingestion.load.snowflake.write_stream.write_stream.getattr')
    @patch('ingestion.utils.logging.log_util.Logger')
    def test_invoke_method_exception(self, mock_logger, mock_getattr):
        # Simulate an exception when invoking the Java method
        mock_getattr.side_effect = Exception("Java method error")

        with self.assertRaises(Exception) as context:
            self.java_adapter.invoke_method("someMethod", "arg1")
        
        # Verify that the error was logged and re-raised
        mock_logger.error.assert_called_with("Error invoking Java method someMethod: Java method error")
        self.assertEqual(str(context.exception), "Java method error")
