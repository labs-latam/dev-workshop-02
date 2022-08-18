# dev-workshop-02
Charla Developer II  
**Introduccion a Brownie y ERC20**

## Brownie
- [Repo](https://github.com/eth-brownie/brownie)
- Instalacion: `pip install eth-brownie`
- Crear un proyecto en blanco: `brownie init <nombre-del-proyecto>`
- Ver los networks disponibles: `brownie networks list`

### Comandos de Testing
- Corre una sola funcion en la prueba: `brownie test -k <nombre funcion>`
- Corre una python shell despues de una prueba fallida que contiene la memoria (y valores de las variables) de la prueba: `brownie test --pdb`
- Obten mas detalles en consola durante la prueba: `brownie test -s`

## Enlaces de Interes
- [ERC20](https://ethereum.org/es/developers/docs/standards/tokens/erc-20/)
- [Open Zeppelin](https://docs.openzeppelin.com/)
- [Frameworks de Desarrollo](https://ethereum.org/es/developers/local-environment/)
- [Solidity VSCode](https://marketplace.visualstudio.com/items?itemName=JuanBlanco.solidity)
- [Infura (proveedor nodo)](https://infura.io/)