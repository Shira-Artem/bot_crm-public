"""Build the demo schema from the checked-in structure-only MySQL dump.

The source dump has no data, but contains host-specific trigger definers and
RocksDB session commands.  Extract table DDL only, remove old AUTO_INCREMENT
values, and let MySQL resolve forward foreign-key references after all tables
exist.  This deliberately never reads a production data dump.
"""

import re
from pathlib import Path

from django.conf import settings
from django.db import connection


SOURCE = Path(settings.BASE_DIR) / "structure.sql"


def table_ddl():
    source = SOURCE.read_text(encoding="utf-8")
    for match in re.finditer(r"(?ms)^CREATE TABLE `([^`]+)` \(.*?^\) ENGINE=.*?;", source):
        name, ddl = match.group(1), match.group(0)
        ddl = re.sub(r" AUTO_INCREMENT=\d+", "", ddl)
        if name == "orders":
            # Current CRM actions also use advance and completed states.
            ddl = ddl.replace(
                "enum('CANCELLED','CONFIRMED','INIT','SHIPPED')",
                "enum('CANCELLED','CONFIRMED','INIT','SHIPPED','ADVANCE','COMPLETED')",
            )
        yield name, ddl


def create_schema():
    tables = list(table_ddl())
    if len(tables) < 69:
        raise RuntimeError(f"Incomplete schema extraction: {len(tables)} tables")
    with connection.cursor() as cursor:
        cursor.execute("SET FOREIGN_KEY_CHECKS=0")
        try:
            for name, _ in reversed(tables):
                cursor.execute(f"DROP TABLE IF EXISTS `{name}`")
            for _, ddl in tables:
                cursor.execute(ddl)
        finally:
            cursor.execute("SET FOREIGN_KEY_CHECKS=1")
    return len(tables)
