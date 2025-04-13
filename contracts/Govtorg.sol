// SPDX-License-Identifier: MIT
pragma solidity^0.8.13;
import "./Base.sol";
import "./AadhaarZKVerifier.sol";

contract Govtorg is Base {
    // Struct to hold govt org details
    struct GovtOrg {
        string govtOrgEmailId;
        string govtOrgPassword;
        string govtOrgName;
        string govtOrgIdNum;
        string govtOrgLocation;
        string govtOrgHeadQuarters;
        uint govtOrgContactNum;
    }

    // Mapping to store GovtOrg details by address
    mapping(address => GovtOrg) public govtorgDetails;
    AadhaarZKVerifier public verifier;
    // Other state variables
    string public govorg_Name;
    string public govorg_IdNum;
    string public govorg_Location;
    string public govorg_HQ;
    uint public govorg_ContactNum;
    uint public govorg_UserRequestedCount;
    
    uint public d1;
    uint public d2;

    // Modifier for only signed-in GovtOrg
    modifier onlySignedInGovtOrg {
        require(govtorgLoginStatus[msg.sender] == 1);
        _;
    }

    // Function to register a government organization
    function registerGovtOrg(
        string memory _govtOrgEmailId, 
        string memory _govtOrgPassword,
        string memory _govtOrgName,
        string memory _govtOrgIdNum,
        string memory _govtOrgLocation,
        string memory _govtOrgHeadQuarters,
        uint _govtOrgContactNum
    ) public {
        require(govtorgRegisteredStatus[_govtOrgEmailId] == 0);
        require(govtorgRegisterStatus[msg.sender] == 0);
        require(userRegisterStatus[msg.sender] == 0);
        
        // Store govt org details in the mapping
        govtorgDetails[msg.sender] = GovtOrg(
            _govtOrgEmailId,
            _govtOrgPassword,
            _govtOrgName,
            _govtOrgIdNum,
            _govtOrgLocation,
            _govtOrgHeadQuarters,
            _govtOrgContactNum
        );

        // Additional registration logic
        addGovtLogin(_govtOrgEmailId, _govtOrgPassword);
        matchAddrToEmail[msg.sender] = _govtOrgEmailId;
        govtorgRegisteredStatus[_govtOrgEmailId] = 1;
        govtorgRegisterStatus[msg.sender] = 1;
        gov++;
        govtOrgsList[gov] = msg.sender;
        govtorgsCount++;
    }
    // Function to add govt org login credentials
    function addGovtLogin(string memory _addGovtorgEmailid, string memory _addGovtorgPassword) public {
        govtorgLogin[msg.sender] = GovtOrgLoginIDs(_addGovtorgEmailid, _addGovtorgPassword);
    }

    // Function to sign in a govt org
    function signinGovtorg(string memory _govorgname, string memory _govorgpassword) public {
        require(keccak256(abi.encodePacked(matchAddrToEmail[msg.sender])) == keccak256(abi.encodePacked(_govorgname)));
        require(keccak256(abi.encodePacked(govtorgLogin[msg.sender].userp)) == keccak256(abi.encodePacked(_govorgpassword)));
        require(govtorgLoginStatus[msg.sender] == 0);
        govtorgLoginStatus[msg.sender] = 1;
    }

    // Function to display govt org details
    function showGovtOrgDetails() public {
        require(govtorgLoginStatus[msg.sender] == 1);
        govorg_Name = govtorgDetails[msg.sender].govtOrgName;
        govorg_IdNum = govtorgDetails[msg.sender].govtOrgIdNum;
        govorg_Location = govtorgDetails[msg.sender].govtOrgLocation;
        govorg_HQ = govtorgDetails[msg.sender].govtOrgHeadQuarters;
        govorg_ContactNum = govtorgDetails[msg.sender].govtOrgContactNum;
    }

    // Getter functions for govt org details
    function getGovorgName() public view returns(string memory) {
        return govorg_Name;
    }

    function getGovorgIdNum() public view returns(string memory) {
        return govorg_IdNum;
    }

    function getGovorgLocation() public view returns(string memory) {
        return govorg_Location;
    }

    function getGovorgHq() public view returns(string memory) {
        return govorg_HQ;
    }

    function getGovorgContactnum() public view returns(uint) {
        return govorg_ContactNum;
    }

    // Function to get the count of govt orgs
    function getGovtOrgsCount() public view returns(uint) {
        return govtorgsCount;
    }

    function isUserRegistered(address user) public view returns (bool) {
        return userRegisterStatus[user] == 1;
    }

    // Function to request documents from a govt org
    function requestDocsFromGovOrg(address requestUser, uint a, uint b) public view returns (bool){
        // ===Rajes=== directly checking the zkp verification
        // require(userRegisterStatus[requestUser] == 1,"User is not registered");
        docsRequestedDB[requestUser][msg.sender] = DocsRequestedDatabase(a, b);
        // ===Rajes=== calling the zkp for generating the witness and proof
        // return verifier.isVerified(requestUser);
    }

    // Getter functions for d1 and d2
    function getd1() public view returns(uint) {
        return d1;
    }

    function getd2() public view returns(uint) {
        return d2;
    }
}
