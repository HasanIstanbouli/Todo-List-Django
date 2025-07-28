import os

port = os.environ.get("TODO_BACKEND_PORT")
bind = f"0.0.0.0:{port}"
# Replace the hard coded value with the cpu_count() after this issue is resolved:
# https://bugs.python.org/issue36054, which was mentioned here:
# https://github.com/benoitc/gunicorn/issues/2028
# threads = multiprocessing.cpu_count() * 2
threads = 3
