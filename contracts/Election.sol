// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

contract Election {
    uint256 constant private PAGE_SIZE = 15;

    struct Candidate {
        uint256 id;
        string leadName;
        string viceName;
        string imageUrl;
        string vision;
        string mission;
    }

    struct Vote {
        uint256 candidateId;
        address voter;
        bytes32 previousVoteHash;
    }

    struct User {
        uint256 id;
        address ethAddress;
        bool isAdmin;
    }

    mapping(uint256 => Candidate) public candidates;
    uint256 public candidatesCount;

    mapping(string => Vote[]) public tpsData;
    mapping(string => bool) public tpsTrack;
    uint256 public tpsTrackCount;
    string[] public tpsIds;
    mapping(address => User) public userData;
    mapping(address => bool) public userExists;
    mapping(address => bool) public voters; // Global voters mapping

    uint256 public userCount;

    constructor() public {
        candidatesCount = 0;
        userCount = 0;
        tpsTrackCount = 0;
    }

    function addCandidate(
        string memory _leadName,
        string memory _viceName,
        string memory _imageUrl,
        string memory _vision,
        string memory _mission
    ) public {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _leadName, _viceName, _imageUrl, _vision, _mission);
    }

    function getCandidates() public view returns (Candidate[] memory) {
        Candidate[] memory candidateList = new Candidate[](candidatesCount);

        for (uint256 i = 1; i <= candidatesCount; i++) {
            candidateList[i - 1] = candidates[i];
        }

        return candidateList;
    }

    function addUser(address _ethAddress, bool _isAdmin) public {
        require(!userExists[_ethAddress], "User already exists");
        userCount++;
        userData[_ethAddress] = User(userCount, _ethAddress, _isAdmin);
        userExists[_ethAddress] = true;
    }

    function vote(uint256 _candidateId, string memory _tpsId) public {
        require(!voters[msg.sender], "You have already voted"); // Global check
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID");

        bytes32 previousVoteHash = bytes32(0);
        if (tpsData[_tpsId].length > 0) {
            previousVoteHash = tpsData[_tpsId][tpsData[_tpsId].length - 1].previousVoteHash;
        }

        bytes32 currentVoteHash = keccak256(abi.encodePacked(_candidateId, msg.sender, previousVoteHash));
        Vote memory newVote = Vote({
            candidateId: _candidateId,
            voter: msg.sender,
            previousVoteHash: previousVoteHash
        });

        if (tpsTrack[_tpsId] != true) {
            tpsTrack[_tpsId] = true;
            tpsIds.push(_tpsId);
            tpsTrackCount++;
        }

        tpsData[_tpsId].push(newVote);
        voters[msg.sender] = true; // Mark voter as having voted globally
    }


    function validateVotes(string memory _tpsId) public view returns (bool) {
        uint256 voteCount = tpsData[_tpsId].length;
        uint256 validVotes = 0;

        for (uint256 i = 0; i < voteCount; i++) {
            Vote memory currentVote = tpsData[_tpsId][i];
            bytes32 calculatedHash = keccak256(abi.encodePacked(currentVote.candidateId, currentVote.voter, currentVote.previousVoteHash));

            if (calculatedHash == currentVote.previousVoteHash || i == 0) {
                validVotes++;
            }
        }

        return (validVotes * 100) >= (voteCount * 51); // Check if valid votes are more than 51% of total votes
    }

    function getUsers(uint256 _page) public view returns (User[] memory) {
        uint256 startIndex = (_page - 1) * PAGE_SIZE;
        uint256 endIndex = startIndex + PAGE_SIZE;
        if (endIndex > userCount) {
            endIndex = userCount;
        }

        User[] memory userList = new User[](endIndex - startIndex);
        uint256 index = 0;

        for (uint256 i = startIndex + 1; i <= endIndex; i++) {
            if (userExists[userData[address(i)].ethAddress]) {
                userList[index] = userData[address(i)];
                index++;
            }
        }
        return userList;
    }

    function getUserByAddress(address _ethAddress) public view returns (User memory) {
        return userData[_ethAddress];
    }

    function getWinner() public view returns (Candidate memory) {
        uint256 maxVotes = 0;
        Candidate memory winningCandidate;

        // Loop through each candidate
        for (uint256 i = 1; i <= candidatesCount; i++) {
            uint256 candidateVotes = 0;

            // Loop through each TPS
            for (uint256 j = 0; j < tpsTrackCount; j++) {
                string storage tpsId = tpsIds[j];
                uint256 voteCount = tpsData[tpsId].length;

                // Validate votes in the TPS
                if (!validateVotes(tpsId)) {
                    revert("Invalid votes detected in TPS");
                }

                // Calculate the vote count for the candidate in this TPS
                for (uint256 k = 0; k < voteCount; k++) {
                    if (tpsData[tpsId][k].candidateId == i) {
                        candidateVotes++;
                    }
                }
            }

            // Update winning candidate if necessary
            if (candidateVotes > maxVotes) {
                maxVotes = candidateVotes;
                winningCandidate = candidates[i];
            }
        }

        return winningCandidate;
    }
}