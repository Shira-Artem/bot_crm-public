"""Deterministic, entirely invented CRM records for the public demo."""

from datetime import datetime, time, timedelta

from django.db import connection
from django.utils import timezone


def seed_demo():
    now = timezone.localtime().replace(tzinfo=None, microsecond=0)
    today = now.date()
    first_names = ["Анна", "Михаил", "Елена", "Павел", "Мария", "Игорь", "Ольга", "Денис", "Наталья", "Артём", "Вера", "Роман"]
    last_names = ["Примерова", "Тестов", "Демина", "Образцов", "Модельная", "Учебный", "Вымышленная", "Пробный", "Макетова", "Демонстрационный", "Сценарная", "Тестовый"]
    cities = ["Москва", "Казань", "Тверь", "Самара", "Пермь", "Тула", "Калуга", "Воронеж"]
    company_names = ["ООО «Демо Маркет»", "ООО «Пример Сервис»", "ООО «Макет Торг»", "ООО «Тест Кафе»", "ООО «Учебный Склад»", "ООО «Сценарий»", "ООО «Витрина»", "ООО «Образец Плюс»", "ООО «Проба»", "ООО «Демо Логистика»"]
    product_names = ["Касса Атол 30Ф", "Фискальный накопитель 36 мес.", "Подключение ОФД", "Сканер штрихкода", "Настройка маркировки"]
    task_titles = ["Продлить договор ОФД", "Проверить срок ФН", "Подготовить КП", "Настроить кассу", "Обновить карточку клиента", "Уточнить реквизиты", "Связаться с клиентом"]
    chat_topics = ["Подключение кассы", "Продление ОФД", "Замена ФН", "Настройка маркировки", "Вопрос по договору", "Помощь с отчётом"]

    with connection.cursor() as cursor:
        def add(table, **values):
            columns = ", ".join(f"`{key}`" for key in values)
            placeholders = ", ".join(["%s"] * len(values))
            cursor.execute(f"INSERT INTO `{table}` ({columns}) VALUES ({placeholders})", list(values.values()))
            return cursor.lastrowid

        specialists = [
            (1, "Демо Директор", 1, "director", 1),
            (2, "Анна Сервисная", 1, "specialist", 0),
            (3, "Максим Консультант", 2, "specialist", 0),
            (4, "Елена Бухгалтер", 3, "specialist", 0),
            (5, "Павел Документы", 4, "specialist", 0),
            (6, "Ольга Партнёр", 5, "partner", 0),
        ]
        for pk, name, profession, role, is_director in specialists:
            add("specialists", id=pk, name=name, profession=profession, role=role,
                is_director=is_director, login=f"demo_{pk}", phone=f"+70000000{pk:03d}")

        for i in range(1, 37):
            add("users", id=i, first_name=first_names[(i-1) % len(first_names)],
                last_name=last_names[(i-1) % len(last_names)],
                phone=f"+7000001{i:04d}", email=f"client{i:02d}@demo.example",
                city=cities[(i-1) % len(cities)], inn=f"000000{i:06d}",
                org_name=company_names[(i-1) % len(company_names)],
                address=f"{cities[(i-1) % len(cities)]}, Демо улица, {i}",
                is_verified=i % 4 != 0, we_added=1, added_by_specialist_id=1,
                created_at=now-timedelta(days=i*3), updated_at=now-timedelta(days=i % 9))

        for i, name in enumerate(company_names, 1):
            add("companies", id=i, name=name, inn=f"00000000{i:02d}",
                phone=f"+7000002{i:04d}", email=f"company{i:02d}@demo.example",
                address=f"{cities[(i-1) % len(cities)]}, Примерная улица, {i}",
                description="Учебная компания для публичной демонстрации CRM",
                added_by_specialist_id=1)
            add("company_contacts", company_id=i, contact_id=i, role="Контактное лицо")

        for i in range(1, 29):
            owner = {"client_id": i} if i <= 20 else {"company_id": i-20}
            expiry = today + timedelta(days=([-5, 7, 23][i-1] if i <= 3 else 45 + (i * 17) % 180))
            kkt_id = add("client_kkt", kkt_slot=f"DEMO-KKT-{i:03d}",
                name=f"Торговая точка {i}", address=f"{cities[i % len(cities)]}, Демо проспект, {i}",
                kkt_model="Атол 30Ф" if i % 2 else "Эвотор 7.3",
                kkt_serial_number=f"DEMO-SN-{i:05d}", fn_serial_number=f"DEMO-FN-{i:05d}",
                fn_expires_at=expiry, ofd_expires_at=expiry+timedelta(days=55),
                mark_expires_at=expiry+timedelta(days=110), marking_enabled=i % 2,
                ofd_name="Учебный ОФД", created_at=now-timedelta(days=i*4), **owner)
            add("client_fn", kkt_id=kkt_id, fn_expires_at=datetime.combine(expiry, time.min))
            add("client_ofd", kkt_id=kkt_id, ofd_expires_at=datetime.combine(expiry+timedelta(days=55), time.min))
            if i % 2:
                add("client_mark", kkt_id=kkt_id, mark_expires_at=datetime.combine(expiry+timedelta(days=110), time.min))

        for i, name in enumerate(product_names, 1):
            add("equipment", id=i, name=name, price=[18900, 13900, 4900, 6200, 7800][i-1], count=25)

        for i in range(1, 27):
            amount = 4900 + (i % 8) * 3200
            status = ["CONFIRMED", "SHIPPED", "INIT", "CANCELLED"][i % 4]
            created = now-timedelta(days=i*2)
            add("orders", id=i, user_id=i, company_id=(i % 10)+1 if i % 3 == 0 else None,
                specialist_id=2+(i % 4), amount=amount, status=status,
                source=["manual", "telegram", "max"][i % 3],
                description=f"Демонстрационная сделка: {product_names[i % 5]}",
                author_name="Демо Директор", created_at=created, updated_at=created,
                paid_at=created+timedelta(hours=2) if status in ("CONFIRMED", "SHIPPED") else None)
            add("order_items", order_id=i, qty=1, price=amount,
                equipment_id=(i % 5)+1, legacy_item_title=product_names[i % 5], created_at=created)

        statuses = ["awaiting_assignment", "in_progress", "postponed", "done"]
        for i in range(1, 22):
            status = statuses[i % 4]
            created = now-timedelta(days=i)
            add("tasks", id=i, title=f"{task_titles[i % len(task_titles)]} — клиент {i}",
                description="Тестовая задача для демонстрации рабочего процесса.",
                created_by=1, director_id=1, assignee_id=2+(i % 4) if status != "awaiting_assignment" else None,
                client_id=i, status=status, priority=["low", "medium", "high"][i % 3],
                deadline=now+timedelta(days=(i % 9)-3), created_at=created,
                completed_at=created+timedelta(hours=4) if status == "done" else None,
                postponed_until=now+timedelta(days=3) if status == "postponed" else None)
            add("task_clients", task_id=i, client_id=i)
            add("task_history", task_id=i, actor_id=1, action_type="created",
                new_status="awaiting_assignment", comment="Создано в DEMO", created_at=created)
            if status != "awaiting_assignment":
                add("task_history", task_id=i, actor_id=2+(i % 4), action_type="status_changed",
                    old_status="awaiting_assignment", new_status=status, created_at=created+timedelta(hours=2))

        for i in range(1, 14):
            status = ["active", "pending", "closed", "consultation"][i % 4]
            created = now-timedelta(days=i)
            add("support_chats", id=i, client_user_id=i+5, specialist_id=2+(i % 4),
                profession=1+(i % 4), category=chat_topics[i % len(chat_topics)],
                request_type="support", status=status,
                source=["telegram", "max", "manual"][i % 3], created_at=created,
                accepted_at=created+timedelta(minutes=8) if status != "pending" else None,
                closed_at=created+timedelta(hours=4) if status == "closed" else None)
            add("support_chat_messages", chat_id=i, sender=0,
                text=f"Здравствуйте! Подскажите, пожалуйста, по теме: {chat_topics[i % len(chat_topics)].lower()}.",
                created_at=created)
            add("support_chat_messages", chat_id=i, sender=1,
                text="Здравствуйте! Проверяем данные и поможем вам.", created_at=created+timedelta(minutes=10))

        for code, name in [("task", "Задача"), ("deadline", "Срок обслуживания"), ("chat", "Чат"), ("order", "Сделка")]:
            add("notification_types", code=code, name=name)
        for i in range(1, 18):
            kind = 1+(i % 4)
            add("notifications", type_id=kind, title=f"Демо уведомление #{i}",
                message=f"Проверьте {['задачу', 'срок ФН', 'чат', 'сделку'][kind-1]} клиента {i}.",
                client_id=i, priority=["low", "medium", "high"][i % 3],
                created_at=now-timedelta(hours=i*5),
                deadline_date=today+timedelta(days=i-7) if kind == 2 else None)

        for code, name, color in [("meeting", "Встреча", "#667eea"), ("service", "Сервис", "#10b981"), ("deadline", "Срок", "#f59e0b")]:
            add("calendar_event_categories", code=code, name=name, color=color)
        for i in range(1, 16):
            add("calendar_events", event_date=today+timedelta(days=i-8),
                event_time=time(10+(i % 7), 0), title=f"{['Встреча', 'Обслуживание', 'Продление'][i % 3]} — DEMO {i}",
                description="Вымышленное событие календаря", category_id=1+(i % 3),
                client_id=i, created_by=1)

        for i in range(1, 111):
            add("bot_events", user_id=1+(i % 36), event_type=["start", "menu", "order", "support"][i % 4],
                name=["open", "click", "view", "submit"][i % 4],
                ts=now-timedelta(days=i % 30, hours=i % 12))

        for i in range(1, 7):
            add("referral_codes", id=i, code=f"DEMO{i:04d}", owner_name=f"Демо партнёр {i}",
                owner_note="Вымышленная реферальная программа", is_active=1, user_id=i)
            add("referral_activations", user_id=i+12, referral_code_id=i,
                raw_text=f"DEMO{i:04d}", scan_source="manual", verification_status="verified",
                source_platform="telegram")

        for i in range(1, 21):
            account_id = add("loyalty_accounts", owner_type="client", owner_id=i)
            points = 100+(i % 5)*75
            add("loyalty_balances", account_id=account_id, available_amount=points,
                total_earned=points)
            add("loyalty_transactions", account_id=account_id, direction="credit", amount=points,
                event_type="demo_purchase", idempotency_key=f"demo-seed-{i}",
                description="Начисление DEMO баллов")
            add("user_loyalty_profile", user_id=i, rating=100+i*3,
                tier="silver" if i % 4 == 0 else "bronze", total_orders=1+(i % 3),
                total_spent_rub=4900+i*1100, last_activity_at=now-timedelta(days=i))

        add("partner_financial_profile", specialist_id=6, base_revenue_pct=50, rating=120)
        add("partner_salary_periods", specialist_id=6, period_month=today.strftime("%Y-%m"),
            status="draft", gross_revenue_rub=48000, effective_pct=50,
            base_salary_rub=24000, final_salary_rub=24000)
        add("partner_rating_events", specialist_id=6, delta=20, reason="monthly_review",
            comment="Демонстрационный рейтинг", rating_before=100, rating_after=120)
