"""Shared demo safeguards for the public CRM."""

from django.conf import settings
from django.http import JsonResponse


DEMO_UNAVAILABLE = "Функция недоступна в демонстрационном режиме"


def unavailable_response():
    return JsonResponse({"success": False, "error": DEMO_UNAVAILABLE}, status=403)


class DemoLoginMiddleware:
    """Use the existing specialist session and role checks without changing views."""

    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        if settings.DEMO_MODE and request.session.get("specialist_id") != settings.DEMO_DIRECTOR_ID:
            request.session["specialist_id"] = settings.DEMO_DIRECTOR_ID
            request.session["specialist_name"] = "Демо Директор"
            request.session["is_director"] = True
        return self.get_response(request)
