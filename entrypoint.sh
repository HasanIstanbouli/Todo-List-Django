#!/bin/sh
# Check if an argument was provided
if [ $# -eq 0 ]; then
    echo "Running Django migrations..."
    python manage.py migrate --noinput || exit 1
    if [ "$IS_DEBUG" = "true" ]; then
        echo "Starting Django development server (DEBUG mode)..."
        python manage.py runserver 0.0.0.0:"${TODO_BACKEND_PORT}" || exit 1
    else
        echo "Creating superuser..."
        python manage.py shell < create_super_user.py || exit 1
        echo "Collecting static files..."
        python manage.py collectstatic --noinput
        echo "Starting Gunicorn server (PRODUCTION mode)..."
        gunicorn Todo_List.wsgi:application -c gunicorn.conf.py || exit 1
    fi
fi

# Get the argument
ARGUMENT=$1
# Run the appropriate command based on the argument
case $ARGUMENT in
    "celery")
        echo "Starting Celery worker..."
        celery -A Todo_List.celery worker --loglevel=info
        ;;
    "celery-beat")
        echo "Starting Celery beat scheduler..."
        celery -A Todo_List.celery beat --loglevel=info
        ;;
    *)
        echo "Invalid argument: $ARGUMENT"
        echo "Usage: $0 {celery|celery-beat}"
        exit 1
        ;;
esac
