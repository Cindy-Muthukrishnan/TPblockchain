//Code fonctionnel qui complile

pragma solidity ^0.4.26;


// SPDX-License-Identifier: GPL-3.0

import "./Ownable.sol";
import "./SafeMath.sol";
import "./Whitelist.sol";


contract Election  {

using SafeMath for uint256;

    // Modele Candidat
    struct Candidate {
        // uint candidateId;
    
        string name;        // Nom du candidat
        uint voteCount;    // Nombre de votes du candidat
    }

    // Modele Voteur
    struct Voter {
        bool authorized;   //Uniquement certaines personnes autorisées à voter
        bool voted;        //On verifie qui a voté. Un seul vote par personne
        uint vote;         // Pour qui la personne a voté
    }
    
    modifier ownerOnly(){
        _;
        require(msg.sender==owner);
    }

    //Nom de l'election
    string public electionName; 
    uint public totalVotes;
    address public owner;

     Candidate[] public candidates;
     mapping(address=>Voter) public voters;
   
    // Ajouter un candidat
    function addCandidate(string _name) ownerOnly public {
        candidates.push(Candidate(_name, 0));       
    }

    // Nombre de candidats // Marche pas
    function getNumCandidate() public returns(uint ) {
        return candidates.length;
    }



    //Autoriser quelqu'un à voter // Marche pas
    function authorize(address _person) ownerOnly public {
        voters[_person].authorized = true;
    }

    //Création d'un event pour le votedEvent 
    event votedEvent (address indexed _candidateId); 
    
    // Fonction voter
    function vote (uint _candidateId) public {

         // On vérifie que la personne n'a pas déjà voter
        require(!voters[msg.sender].voted);


        // On vérifie que la personne est bien autorisée à voter
        require(!voters[msg.sender].authorized);

        // On enregistre le vote de la personne
        voters[msg.sender].voted = true;

        // On met à jour le compteur du vote du candidat qui a eu une voix en plus
        candidates[_candidateId].voteCount ++;

        // Le nombre de vote émis par candidat
        // emit votedEvent (uint _candidateId);

        // Incrementation du nombre total de vote 
        totalVotes += 1; 
    }

}
