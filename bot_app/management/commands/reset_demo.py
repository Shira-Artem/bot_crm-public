"""Rebuild the isolated public demo database and load synthetic records."""

from django.conf import settings
from django.core.management.base import BaseCommand, CommandError
from django.core.management import call_command
from django.db import connection

from demo.schema import create_schema
from demo.seed import seed_demo


class Command(BaseCommand):
    help = "Recreate the local DEMO schema and load synthetic CRM data."

    def handle(self, *args, **options):
        db = settings.DATABASES["default"]
        if (not settings.DEMO_MODE or db["ENGINE"] != "django.db.backends.mysql"
                or db["NAME"] != "bot_crm_demo"
                or db["USER"] != "demo"):
            raise CommandError("reset_demo requires DEMO_MODE and the dedicated bot_crm_demo database/user.")
        tables = create_schema()
        # The structure dump already contains current Django-owned tables.
        call_command("migrate", fake=True, interactive=False, verbosity=0)
        seed_demo()
        self.stdout.write(self.style.SUCCESS(f"Rebuilt {tables} tables and loaded synthetic DEMO data."))
