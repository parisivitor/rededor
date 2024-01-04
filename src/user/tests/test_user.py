import unittest
from dataclasses import is_dataclass
from user.domain.user import User

class TestUser(unittest.TestCase):
    def test_is_a_dataclass(self):
        self.assertTrue(is_dataclass(User))


    def test_constructor(self):
        user = User(name='Vitor', last_name='Parisi', cellphone='19993551501', email='parisivitor95@gmail.com')

        self.assertEqual(user.name, 'Vitor')
        self.assertEqual(user.last_name, 'Parisi')
        self.assertEqual(user.get_full_name(), 'Vitor Parisi')
        self.assertEqual(user.email, 'parisivitor95@gmail.com')
        self.assertEqual(user.cellphone, '19993551501')
        self.assertFalse(user.validated_cellphone)
        self.assertFalse(user.validated_email)
        self.assertFalse(user.is_active())


    def test_verify_email_cellphone_and_status_active(self):
        user = User(name='Vitor', last_name='Parisi', cellphone='19993551501', email='parisivitor95@gmail.com')
        user.verify_email()
        user.verify_cellphone()
        user.activate()

        self.assertTrue(user.validated_cellphone)
        self.assertTrue(user.validated_email)
        self.assertTrue(user.is_active())

    def test_to_fail(self):
        user = User(name='Vitor', last_name='Parisi', cellphone='19993551501', email='parisivitor95@gmail.com')
        self.assertEqual(user.name, 'Vitor')
