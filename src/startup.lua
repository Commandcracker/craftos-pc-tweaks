print("Hello, world!")
os.shutdown()
-- Using shutdown is preferred, because it will quit the program faster than shell.exit() and
-- It makes it possible to exit the program with any error code by using os.shutdown(error_code)
