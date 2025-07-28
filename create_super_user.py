import logging
import os
import sys

from django.contrib.auth import get_user_model

logger = logging.getLogger(__name__)

User = get_user_model()

username = os.getenv("DJANGO_SUPERUSER_USERNAME")
first_name = os.getenv("DJANGO_SUPERUSER_FIRST_NAME")  # Optional
last_name = os.getenv("DJANGO_SUPERUSER_LAST_NAME")  # Optional
email = os.getenv("DJANGO_SUPERUSER_EMAIL")
password = os.getenv("DJANGO_SUPERUSER_PASSWORD")

if not all([username, email, password]):
    logger.error(
        "Missing required environment variables: "
        "DJANGO_SUPERUSER_USERNAME, DJANGO_SUPERUSER_EMAIL, DJANGO_SUPERUSER_PASSWORD"
    )
    sys.exit(1)

super_user = User.objects.filter(username=username, is_superuser=True).first()
if super_user:
    logger.warning(f"Superuser '{username}' already exists!")
else:
    super_user = User.objects.create_superuser(
        username=username,
        email=email,
        password=password,
        first_name=first_name or "",
        last_name=last_name or "",
    )
    logger.info(f"Superuser '{username}' with email '{email}' has been created successfully.")
