from brownie import accounts, config, network


def get_account(index=None):
    if index:
        return accounts[index]
    if network.show_active() in ["development"]:
        return accounts[0]
    return accounts.add(config["wallets"]["from_key"])
