pragma solidity 0.8.7;

contract SimpleStorage {
   uint data;

   function set(uint x) public {
       data = x;
   }

   function get() public view returns (uint) {
       return data;
   }
}