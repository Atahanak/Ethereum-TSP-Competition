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
/*
    0   1   2   3

0   0   3   6   1

1   3   0   5   2

2   6   5   0   10

3   1   2   10  0

[0, 3, 6, 1, 3, 0, 5, 2, 6, 5, 0, 10, 1, 2, 10, 0], 4
*/
pragma solidity ^0.5.6;

contract TSP {

    uint256[] graph;
    uint256 length;
    uint256 best_solution;
    address payable winner;
    uint closing_time;
    bool finished;
    uint256 prize = 20 ether;
    //deadline date

    constructor(uint256[] memory input_graph, uint256 input_length, uint deadline) payable public {
        length = input_length;
        graph = input_graph;
        winner = address(uint160(address(this))); //put contract address as the winner
        closing_time = now + deadline;
        finished = false;
        best_solution = 1000000; //temporary number will be changed
    }
    function getCoordinate(uint256 x, uint256 y) public view returns (uint256){
        require(x < length && y < length);
        return graph[length*x + y];
    }
    function hasClosed() public view returns (bool) {
        return now > closing_time;
    }
    /*function sqrt(){
        
    }*/
    function validate_solution (uint256[] memory solution) private returns(bool) {
        require(solution.length == length && !hasClosed());
        
        uint256[] memory visited = new uint256[](length/256 + 1);
        uint256 solLength = 0;
        bool isCorrect = true;
        visited[solution[0] / 256] |= (1 << (solution[0] & 255)); // mark starting node as visited
        
        for(uint256 i = 1; i < length && isCorrect; i++){ // go over the solution
            if( visited[solution[i] / 256] & (1 << (solution[i] & 255)) > 0){ //check if visited
                isCorrect = false;
            }
            else{
                visited[solution[i] / 256] |= (1 << (solution[i] & 255)); //mark as visited
                solLength += getCoordinate(solution[i-1], solution[i]); //calculate the total sum
            }
        }
        solLength += getCoordinate(solution[0], solution[length-1]); //the distance from last node to start
        
        /*uint256 bitVectorCheckNum = (1 << 255) + ((1 << 255) - 1); //helper number 
        for(uint256 i = 0; i < visited.length && isCorrect; i++){ //check if all nodes are visited
            if(visited[i] != bitVectorCheckNum){
                isCorrect = false;
            }
        }*/ //not needed since length and visited check gurantees that all nodes are visited
        
        if(isCorrect){ //check the correctness of the solution
            if(solLength < best_solution){
                best_solution = solLength; //update solution
                return true;
            }
        }
        return false;
    }
    
    function reward() public {
        require(!finished && hasClosed());
        finished = true;
        winner.transfer(prize);
    }
    //FRONT END CONNECTION
    //********************************************************
    function upload_solution (uint256[] memory solution) public payable{
        require(msg.value > 1 ether && !hasClosed());
        if(validate_solution(solution)){
            winner = msg.sender;//update winner address
        }
    }
    function getGraph()public view returns(uint256[] memory){
        return graph;
    }
    function getSolution() public view returns(uint256){
        return best_solution;   
    }
    function getAddress() public view returns(address){
        return winner;
    }
    //********************************************************
}