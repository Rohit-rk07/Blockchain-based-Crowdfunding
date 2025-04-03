// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";

contract CrowdFunding is Ownable {
    struct Campaign {
        address owner;
        string title;
        string description;
        uint256 target;
        uint256 deadline;
        uint256 amountCollected;
        string image;
        address[] donators;
        uint256[] donations;
        bool isActive; // added isActive flag
    }

    mapping(uint256 => Campaign) public campaigns;

    uint256 public numberOfCampaigns = 0;

    function createCampaign(
        address _owner,
        string memory _title,
        string memory _description,
        uint256 _target,
        uint256 _deadline,
        string memory _image
    ) public returns (uint256) {
        require(
            _deadline > block.timestamp,
            "The deadline should be a date in the future."
        );

        Campaign storage campaign = campaigns[numberOfCampaigns];
        campaign.owner = _owner;
        campaign.title = _title;
        campaign.description = _description;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.amountCollected = 0;
        campaign.image = _image;
        campaign.isActive = true; // setting isActive to true

        numberOfCampaigns++;

        return numberOfCampaigns - 1;
    }
    
    function donateToCampaign(uint256 _id) public payable {
        uint256 amount = msg.value;

        Campaign storage campaign = campaigns[_id];
        campaign.donators.push(msg.sender);
        campaign.donations.push(amount);
        (bool sent, ) = payable(campaign.owner).call{value: amount}("");
        if (sent) {
            campaign.amountCollected = campaign.amountCollected + amount;
        }
    }

    function getDonators(
        uint256 _id
    ) public view returns (address[] memory, uint256[] memory) {
        return (campaigns[_id].donators, campaigns[_id].donations);
    }

    // Function to mark a campaign as inactive (end the campaign)
    function endCampaign(uint256 _id) public {
        require(msg.sender == campaigns[_id].owner, "Only owner can end the campaign.");
        campaigns[_id].isActive = false;
    }

    // Function to get all active campaigns
    function getCampaigns() public view returns(Campaign[] memory){
        Campaign[] memory allCampaigns = new Campaign[](numberOfCampaigns); 
        uint256 activeCount = 0;

        for(uint i = 0; i < numberOfCampaigns; i++) {
            if (campaigns[i].isActive) {
                allCampaigns[activeCount] = campaigns[i];
                activeCount++;
            }
        }

        // Resize the array to only include active campaigns
        Campaign[] memory activeCampaigns = new Campaign[](activeCount);
        for (uint i = 0; i < activeCount; i++) {
            activeCampaigns[i] = allCampaigns[i];
        }

        return activeCampaigns;
    }
}
