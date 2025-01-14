from ape import accounts, project 


def main():
    account = accounts.load("monerochanDeployREAL")
    print(f"using address {account.address}")
    storage_contract = account.deploy(
    project.OnchainImg,
    sender=account,
    publish=True,
    gas_limit=5_000_000  # Adjust the gas limit
    )
    
    print(f"onchain storage deployed at address: {storage_contract.address}")