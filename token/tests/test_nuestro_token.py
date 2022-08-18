import pytest
from brownie import exceptions
from web3 import Web3

import scripts.utils as utils
from scripts.desplegar import desplegar


def test_desplegar():
    nuestro_token = desplegar()
    balance = nuestro_token.balanceOf(utils.get_account())
    balance_esperado = 0
    assert balance == balance_esperado


def test_mint():
    nuestro_token = desplegar()
    account = utils.get_account()

    balance_a_mintear = Web3.toWei(1, "ether")
    nuestro_token.mint(account, balance_a_mintear, {"from": account})

    balance = nuestro_token.balanceOf(account)
    assert balance == balance_a_mintear


def test_ownership():
    nuestro_token = desplegar()
    owner_account = utils.get_account()
    nonowner_account = utils.get_account(1)

    balance_a_mintear = Web3.toWei(1, "ether")
    # Esta linea returna "True" si al llamar
    # a la funcion obtenemos un revert ("VirtualMachineError")
    with pytest.raises(exceptions.VirtualMachineError):
        nuestro_token.mint(
            owner_account,
            balance_a_mintear,
            {"from": nonowner_account}
        )


def test_transfer():
    nuestro_token = desplegar()
    owner_account = utils.get_account()
    nonowner_account = utils.get_account(1)

    balance_a_mintear = Web3.toWei(1, "ether")
    nuestro_token.mint(
        owner_account,
        balance_a_mintear,
        {"from": owner_account}
    )
    nuestro_token.transfer(
        nonowner_account,
        balance_a_mintear,
        {"from": owner_account}
    )

    balance = nuestro_token.balanceOf(nonowner_account)
    assert balance == balance_a_mintear
