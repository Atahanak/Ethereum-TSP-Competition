/*
    A   B   C   D   E   F   G   H   I   J   K
    A 0   29  20  21  16  31  100 12  4   31  18
    B 29  0   15  29  28  40  72  21  29  41  12
    C 20  15  0   15  14  25  81  9   23  27  13
    D 21  29  15  0   4   12  92  12  25  13  25
    E 16  28  14  4   0   16  94  9   20  16  22
    F 31  40  25  12  16  0   95  24  36  3   37
    G 100 72  81  92  94  95  0   90  101 99  84
    H 12  21  9   12  9   24  90  0   15  25  13
    I 4   29  23  25  20  36  101 15  0   35  18
    J 31  41  27  13  16  3   99  25  35  0   38
    K 18  12  13  25  22  37  84  13  18  38  0
*/


//check date logic

pragma solidity ^0.5.6;

contract TSP {
    uint256[] graph;
    uint256 length;
    //deadline date
    //adderess of the current best solution
    //cost and path of the current best solution
    constructor(uint256[] memory input_graph, uint256 input_length) public {
        length = input_length;
        graph = input_graph;
    }
    function getCoordinate(uint256 x, uint256 y) public returns (uint256){
        //require(x < length-1 && y < length-1);
        return graph[length*x + y];
    }
    function sqrt(){
        
    }
    function validate_solution(){
        //check for default
    }
    function upload_solution() payable{
        
    }
    function payout(){

    }
    //front end
    function display_GraphAndSolution(){
        
    }
}