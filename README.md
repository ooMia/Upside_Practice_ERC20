1. `Template.sol`: 기존에 잘 정리된 인터페이스를 참조하여 틀을 다듬었다.
2. `Custom.sol`: 추가로 customize된 내용을 담아 래퍼 인터페이스 `_Ixx`로 정의했다.
4. `ERC20.sol:_ERC20`: Test1을 기반으로 기초 ERC20 구현체를 만들었다.
5. `ERC20.sol:ERC20`: 기존 구현체를 abstract 처리하고, nonce와 permit을 반영한 최종 구현체를 만들었다.
6. permit 기반의 approve를 위해 새로운 래퍼 함수 approveFrom을 추가했다.
7. 이벤트 출력도 사양에 포함되어 있어서 추가했다.

![image](https://github.com/user-attachments/assets/0ff791eb-7eed-4687-b8a5-754594cc2cf6)
