from dataclasses import dataclass, field
from typing import Optional
from datetime import datetime

@dataclass
class User:
    name: str
    last_name: str
    cellphone: str
    email: str
    validated_email: bool = False
    validated_cellphone: bool = False
    status: bool = False


    def is_active(self):
        return self.status

    def activate(self):
        if self.validated_email and self.validated_cellphone:
            self.status = True

    def get_full_name(self):
        return f"{self.name} {self.last_name}"

    def verify_email(self):
        self.validated_email = True

    def verify_cellphone(self):
        self.validated_cellphone = True
