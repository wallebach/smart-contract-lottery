// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

/**
 * @title Sample Raffle Contract
 * @author wallebach
 * @notice This contract is for creating a sample raffle
 */
contract Raffle {
    /**
     * Errors
     */
    error Raffle__NotEnoughEthSent();

    uint256 private immutable i_entranceFee;
    uint256 private immutable i_interval;
    address payable[] private s_players;
    uint256 private s_lastTimestamp;

    /**
     * Events
     */
    event EnteredRaffle(address indexed player);

    constructor(uint256 entranceFee, uint256 interval) {
        i_entranceFee = entranceFee;
        i_interval = interval;
    }

    function enterRaffle() public payable {
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnoughEthSent();
        }
        s_lastTimestamp = block.timestamp;
        s_players.push(payable(msg.sender));
        emit EnteredRaffle(msg.sender);
    }

    function pickWinner() public {
        if ((block.timestamp - s_lastTimestamp) < i_interval) {
            revert();
        }
    }

    /**
     * Getter functions
     */
    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }
}
