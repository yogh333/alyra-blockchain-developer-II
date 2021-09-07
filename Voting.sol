// Voting.sol
// SPDX-License-Identifier: MIT

pragma solidity <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/Counters.sol";

contract Voting is Ownable {
    
    struct Voter {
        bool isRegistered;
        bool hasVoted;
        uint votedProposalId;
    }

    struct Proposal {
        string description;
        uint voteCount;
    }
    
    enum WorkflowStatus {
        RegisteringVoters,
        ProposalsRegistrationStarted,
        ProposalsRegistrationEnded,
        VotingSessionStarted,
        VotingSessionEnded,
        VotesTallied
    }

	event VoterRegistered(address voterAddress);
    event ProposalsRegistrationStarted();
    event ProposalsRegistrationEnded();
    event ProposalRegistered(uint proposalId);
    event VotingSessionStarted();
    event VotingSessionEnded();
    event Voted (address voter, uint proposalId);
    event VotesTallied();
    event WorkflowStatusChange(WorkflowStatus previousStatus, WorkflowStatus newStatus);
    
    using Counters for Counters.Counter;
    Counters.Counter private proposalId;
    
	string private ballotName;
	mapping(address => Voter) private voters;
	mapping(uint => Proposal) private proposals;
	
	uint256 private winningProposalId;
	
	WorkflowStatus private status;
	
	constructor(string memory _ballotName) {
	    ballotName = _ballotName;
	    status = WorkflowStatus.RegisteringVoters;
	}
	
	function whitelist(address _user) public onlyOwner() {
	    require(status == WorkflowStatus.RegisteringVoters, "Voters cannot be registered at this moment");
	    require(_user != address(0), "zero address cannot be whitelisted");
        require(!voters[_user].isRegistered, "This user is already whitelisted !");
	    voters[_user].isRegistered = true;
	    
	    emit VoterRegistered(_user);
	}
	
	function isWhitelisted(address _user) public view returns (bool _flag){
        return voters[_user].isRegistered;	    
	}
	
	function startProposalRegistration() public onlyOwner() {
	    require(status == WorkflowStatus.RegisteringVoters);
	    status = WorkflowStatus.ProposalsRegistrationStarted;
	    
	    uint256 i;
	    for (i = 0; i < proposalId.current(); i++){
	        proposals[i].description = "";
	        proposals[i].voteCount = 0;
	    }
	    proposalId.reset();
	    
	    emit ProposalsRegistrationStarted();
	    emit WorkflowStatusChange(WorkflowStatus.RegisteringVoters, WorkflowStatus.ProposalsRegistrationStarted);
	}
	
	function registerProposal(string memory _description) public {
	    require(voters[msg.sender].isRegistered, "user is not registered as a voter");
	    require(status == WorkflowStatus.ProposalsRegistrationStarted, "Proposal registration time is over");
	    
	    uint256 id = proposalId.current();
	    proposalId.increment();
	    
	    proposals[id].description = _description;
	    proposals[id].voteCount = 0;
	    
	    emit ProposalRegistered(id);
	}
	
	function endProposalRegistration() public onlyOwner() {
	    require(status == WorkflowStatus.ProposalsRegistrationStarted);
	    status = WorkflowStatus.ProposalsRegistrationEnded;
	    emit ProposalsRegistrationEnded();
	    emit WorkflowStatusChange(WorkflowStatus.ProposalsRegistrationStarted, WorkflowStatus.ProposalsRegistrationEnded);
	}
	
	function startVotingSession() public onlyOwner() {
	    require(status == WorkflowStatus.ProposalsRegistrationEnded);
	    status = WorkflowStatus.VotingSessionStarted;
	    
	    emit VotingSessionStarted();
	    emit WorkflowStatusChange(WorkflowStatus.ProposalsRegistrationEnded, WorkflowStatus.VotingSessionStarted);
	}
	
	function voteProposal(uint256 id) public {
	    require(status == WorkflowStatus.VotingSessionStarted);
	    require(voters[msg.sender].isRegistered, "user is not registered as a voter");
	    require(!voters[msg.sender].hasVoted, "user has already voted");
	    require(id < proposalId.current(), "proposal does not exist");
	    
	    voters[msg.sender].votedProposalId = id;
	    voters[msg.sender].hasVoted = true;
	    
	    proposals[id].voteCount += 1;
	    
	    emit Voted(msg.sender, id);
	    
	}
	
	function endVotingSession() public onlyOwner() {
	    require(status == WorkflowStatus.VotingSessionStarted);
	    status = WorkflowStatus.VotingSessionEnded;
	    
	    emit VotingSessionEnded();
	    emit WorkflowStatusChange(WorkflowStatus.VotingSessionStarted, WorkflowStatus.VotingSessionEnded);
	}
	
	function countVotes() public onlyOwner() {
	    require(status == WorkflowStatus.VotingSessionEnded);
	    
	    uint i;
	    
	    winningProposalId = 0;
	    uint maxVoteCount = proposals[0].voteCount;
	    for (i = 1; i < proposalId.current(); i++) {
	        if (proposals[i].voteCount > maxVoteCount){
	            winningProposalId = i;
	            maxVoteCount = proposals[i].voteCount;
	        }
	            
	    }
	    
	    status = WorkflowStatus.VotesTallied;
	    emit VotesTallied();
	    emit WorkflowStatusChange(WorkflowStatus.VotingSessionEnded, WorkflowStatus.VotesTallied);
	}


    function getWinningProposal() public view returns (uint256 id, string memory description) {
        require(status == WorkflowStatus.VotesTallied);
        
        return (winningProposalId, proposals[winningProposalId].description);
    }
}