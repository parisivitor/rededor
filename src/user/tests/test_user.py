import pytest
from user.domain.user import User


def test_constructor():
    user = User(name='Vitor', last_name='Parisi', cellphone='19993551501', email='parisivitor95@gmail.com')

    assert user.name == 'Vitor'
    assert user.last_name == 'Parisi'
    assert user.get_full_name() == 'Vitor Parisi'
    assert user.email == 'parisivitor95@gmail.com'
    assert user.cellphone == '19993551501'
    assert not user.validated_cellphone
    assert not user.validated_email
    assert not user.is_active()

def test_verify_email_cellphone_and_status_active():
    user = User(name='Vitor', last_name='Parisi', cellphone='19993551501', email='parisivitor95@gmail.com')
    user.verify_email()
    user.verify_cellphone()
    user.activate()

    assert user.validated_cellphone
    assert user.validated_email
    assert user.is_active()
