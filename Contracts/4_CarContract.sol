/*
Problem: Write a smart contract which has a struct car that includes
car model, year and owner.
Create an array of struct cars to obtain the car data.
Contract must have 3 functions
1) func to register a new car
2) admin can change the ownership of the car
3) show the car details on a specific index of array 4) User can transfer the ownership of car
Use the proper error handling, naming convention and function type
*/

pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "hardhat/console.sol";
import "../contracts/3_Ballot.sol";

// 4_CarContract.sol
contract CarContract {
    address public admin;
    struct Car {
        uint32 carModel;
        uint32 carYear;
        address carOwner;
    }

    constructor() {
        // Sets the admin when Contract is deployed
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin);
        _;
    }
    // Array of Struct Car
    Car[] public CarsArray;

    // 1) func to register a new car
    function NewCar(uint32 _carModel, uint32 _carYear) public {
        require(_carModel != 0 && _carYear != 0, "Values are zero");
        CarsArray.push(Car(_carModel, _carYear, msg.sender));
    }

    // 2) admin can change the ownership of the car
    function changeOwnershipAdmin(uint32 _index, address _carNewOwner)
        public
        onlyAdmin
    {
        require(
            _index < (CarsArray.length) && _index >= 0,
            "Wrong index, Out of bound"
        );
        require(_carNewOwner != address(0));
        CarsArray[_index].carOwner = _carNewOwner;
    }

    // 3) show the car details on a specific index of array
    function CarDetail(uint256 _index)
        public
        view
        returns (
            uint32,
            uint32,
            address
        )
    {
        require(
            _index < (CarsArray.length) && _index >= 0,
            "Wrong index, Out of bound"
        );
        Car storage car = CarsArray[_index];
        return (car.carModel, car.carYear, car.carOwner);
    }

    // 4) User can transfer the ownership of car
    function changeOwnershipUser(uint32 _index, address _carNewOwner) public {
        require(
            msg.sender == CarsArray[_index].carOwner,
            "You are not the owner of this car!"
        );
        require(
            _index < (CarsArray.length) && _index >= 0,
            "Wrong index, Out of bound"
        );
        require(_carNewOwner != address(0));
        CarsArray[_index].carOwner = _carNewOwner;
    }
}
