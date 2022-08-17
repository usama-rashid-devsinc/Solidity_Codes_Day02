// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "hardhat/console.sol";
import "../contracts/3_Ballot.sol";

contract Todos {
    struct Todo {
        string text;
        bool completed;
    }

    // An array of 'Todo' structs
    Todo[] public todos;

    function create(string calldata _text) public {
        require((bytes(_text).length > 0), "Empty String");
        todos.push(Todo(_text, false));
    }

    function get(uint256 _index)
        public
        view
        returns (string memory text, bool completed)
    {
        require(_index < (todos.length), "Wrong index");
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }

    // update text
    function updateText(uint256 _index, string calldata _text) public {
        require(_index < (todos.length), "Wrong index");
        Todo storage todo = todos[_index];
        todo.text = _text;
    }

    // update completed
    function toggleCompleted(uint256 _index) public {
        require(_index < (todos.length), "Wrong index");
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }
}
