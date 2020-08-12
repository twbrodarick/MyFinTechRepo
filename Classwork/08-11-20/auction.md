# Auction - Mars Property

You are a smart contract engineer on a team of elite developers hired by the martian land foundation to build a system that will crowdfund the development of a new colony on Mars. To accomplish this goal and help humanity thrive on Mars, you have communicated with your project manager, gathered the necessary business requirements, and have decided to leverage an Open Auction Smart Contract

## Simple Open Auction

The general idea of the following simple auction contract is that everyone can send their bids during a bidding period. The bids already include sending money/ether in order to bind the bidders to their bid. If the highest bid is raised, the previously highest bidder gets her money back. After the end of the bidding period, the contract has to be called manually for the beneficiary to receive their money - contracts cannot activate themselves

### Requirements

1) Now open Remix and create a new contract named MartianAuction.sol. Begin by adding the pragma and contract declarations.

2) Define the variables that the contract will need to track its internal state:

* An address payable public beneficiary will be used to track the beneficiary of the contract.

* An address public highestBidder will be used to keep track of the address of the current highestBidder.

* A uint public highestBid will be used to track the current highest bid amount of the highest bidder.

3) Auction funds are all stored together in the contract's wallet; we need an easy way to keep track of who paid what. We are going to track this with a mapping that maps a bidder's address to the amount that they bid.

4) We need a way to set when an auction's bidding period has closed, and the auction has ended. We are going to track this with a pubic bool named ended.

5) This contract will serve as a backend store of information for an auction to easily communicate with our frontend, we have to define some events.

* Whenever the highest bid amount increases, we are going to call the HighestBidIncreased event and log the address of the bidder and the amount.

* Whenever an auction has ended, we are going to call AuctionEnded and log the winner and the winning bid amount.

6) Upon deployment of a new instance of the MartianAuction contract, a beneficiary or the person hosting the auction must be set. Here we are going to define a constructor that will set the beneficiary.

7) An auction requires a method of bidding on an item within the auction. Bidders will bid on the auction with the value sent, and the value will only be refunded if the auction is not won.

8) Inside the bid function, we are going to add a require to check if a sent bid is less than the current highest bid. If it is less, then we are going to send it back.

9) We are going to add a second check inside our bid function that will check that bool value to see if the auction has ended.

10) Add an if statement to check if there has been a previous bidder. Inside the body of the if statement, add the current highestBidder to the pendingReturns mapping and map the current value of highestBid to that bidder's address. If the bid is higher than the current bid and the auction has not ended then the next line of code will continue to execute. Now we need to save the previous bidders info so that they can withdraw their funds from the contract since they've been outbid. Before we can do this, we need to check that there has first been a previous bidder. This is done by checking if the highestBid is not equal to 0. To complete our bid function, we need to set the new highestBidder equal to the sender parameter that was passed and the highestBidder equal to the amount sent to the bid function, e.g., msg.value.Finally we emit the HighestBidIncreased event and pass it those two values as well.

11) Currently, we have a way to bid and even outbid other bidders. As you may remember, when a bidder is outbid, the amount that they originally bid is stored in pendingReturns. Now we need to create a way for them to return that amount to their account.

12) Inside the withdraw function, we are first going to check the current amount that the person who is calling the withdraw function, e.g., msg.sender has deposited into the contract. If the amount is not greater than 0, then there is nothing to withdraw, and we return true. It is important to set this to zero because the recipient can call this function again as part of the receiving call before send returns.

13) For ease of use, let's define a new function named pendingReturn, this function will accept a sender's address and returns that sender's corresponding pendingReturn amount via the pendingReturns mapping.

14) Lastly, we need some way to end the auction. Let's define a new function named auctionEnd. Inside the body of the auctionEnd contract:

* We are going to first check for the condition of whether or not the auction has ended by negating the ended variable with the ! operator.

* A second require is defined to check if the msg.sender attempting to end the auction is equal to the beneficiary running the auction.

* Next, we are going to set ended equal to true to end the auction if it hasn't already.

* Finally, we are going to transfer the highestBid amount to the beneficiary using the .transfer address method.

### Tip

It is a good guideline to structure functions that interact with other contracts (i.e., they call functions or send Ether) into three phases:

1) Checking conditions

2) Performing actions (potentially changing conditions)

3) Interacting with other contracts

If these phases are mixed up, the other contract could callback into the current contract and modify the state or cause effects (ether payout) to be performed multiple times.

If functions called internally include interaction with external contracts, they also have to be considered interaction with external contracts.

### Auction Contract Complete

Congratulations, we have just built a MartianAuction contract; you may have very well just secured mankind's future.

## Mars Token

We are going to be creating an ERC721 token with the ticker MARS. Only one entity will be allowed to create the tokens, and that entity in this example is called the "Martian Land Foundation." Assume this foundation is a global initiative from the governments of the world and is responsible for the terraforming and fundraising of Martian Land Development.

For every token that the Martian Land Foundation mints, an Auction contract will be created. This auction contract will become the new owner of the token and will allow the public to bid on that piece of land. In the spirit of humanity, some landmarks will be marked as "sovereign" and will become permanently owner-less.

The Martian Land Foundation can end the auctions at any time.

### Requirements

Open up Remix and create a new file called MartianMarket.sol.

In this contract, we are simply defining an ERC721 token contract called MartianMarket with the ticker of MARS. Each MARS token will represent a plot of land/landmark on Mars.

We are importing the MartianAuction code as well since we will want to create a new auction for every new token.

We are setting the ERC721 contract as Ownable using the OpenZeppelin library, as the Martian Land Foundation will be solely responsible for the management of the tokens, and we'll want to restrict some of our functions using the onlyOwner modifier that OpenZeppelin provides.

Just like the last ERC721 implementations we did, we need to keep track of unique token IDs using the OpenZeppelin counter library. This will allow us to make sure that every ID we generate is unique, regardless if any tokens have been "burned" or removed from circulation.

Then, save the Martian Land Foundation's address as the contract deployer (msg.sender) and set it to payable.

We are going to be creating a new MartianAuction contract for every token_id that we register into the system.

During the minting process, we will create a Martian Auction contract in this mapping at the corresponding token_id. The foundation_address will be the initial owner of the token, but we will add functionality to transfer the ownership once the auction is ended.

We need to add a landRegistered modifier in order to check whether or not a token exists before operating on it.

This is done by calling the _exists function that is built into OpenZeppelin's ERC721 library and returning the message Land not registered! if it doesn't. We can attach this modifier to any function that we expect a token to exist with, like bidding on an auction, or transferring ownership of land.

Create a function that creates a new MartianAuction contract in the slot of the auctions mapping that belongs to the specified token_id. By passing in the foundation_address, we set the foundation as the beneficiary of the auction. In other words, the funds raised from this auction will go to the foundation_address.  We can now reference this auction contract later as long as we know the token_id it relates to.

Create a function to register the land where we are creating a new token_id by incrementing our counter and capturing the latest value.

Then, we are calling the ERC721 _mint function, setting the foundation_address as the initial owner, and creating it at the token_id that we just generated.

Like all ERC721 tokens, we pass in a token URI into the _setTokenURI function. We can set this to what we'd like later.

Finally, we call the createAuction function to create a new MartianAuction auction contract for our new token. We will use the results of this to manage the initial public (not the foundation) ownership of the tokens.

Create a function to end the auction, we are using our landRegistered modifier to check if the token was minted yet.

Then, we fetch the MartianAuction contract from the auctions mapping, and store it in a variable temporarily called auction.

We then call the auction.auctionEnd() function against the auction we fetched.

Once we end the auction, we then perform a safeTransferFrom that is built into the ERC721 library. This function accepts from, to, and token_id as the parameters. We are passing the token's owner by calling owner(). We can also use foundation_address here. Then, we send the token to the address that auction.highestBidder() returns.

We need to add a function to tell whether or not an auction has ended.

We need to add a function to tell the highest bid.

We need to add a function to tell the pending returns.

We need to add a function to place a bid.

