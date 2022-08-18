from brownie import config, network, NuestroToken
import scripts.utils as utils


def desplegar():
    nuestro_token = NuestroToken.deploy(
        "Nuestro Token",
        "NTKN",
        18,
        {"from": utils.get_account()},
        publish_source=config["networks"][network.show_active()].get(
            "publish_source")
    )
    return nuestro_token


def main():
    nuestro_token = desplegar()
    print("Desplegado!!")
    print("Direccion:", nuestro_token.address)
    print("Nomber:", nuestro_token.name())
    print("Simbolo:", nuestro_token.symbol())
