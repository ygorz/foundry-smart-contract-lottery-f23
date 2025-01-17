// unit
// integrations
// forked
// staging

// fuzzing
// stateful fuzzing

// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test} from "forge-std/Test.sol";
import {HelperConfig} from "script/HelperConfig.s.sol";
import {CreateSubscription, FundSubscription, AddConsumer} from "script/Interactions.s.sol";
import {VRFCoordinatorV2_5Mock} from "@chainlink/contracts/src/v0.8/vrf/mocks/VRFCoordinatorV2_5Mock.sol";

contract Interactions is Test {
    HelperConfig helperConfig = new HelperConfig();
    HelperConfig.NetworkConfig config = helperConfig.getConfig();

    function setUp() external {
        CreateSubscription createSubscription = new CreateSubscription();
        FundSubscription fundSubscription = new FundSubscription();

        (config.subscriptionId, config.vrfCoordinator) = createSubscription
            .createSubscriptionUsingConfig();

        fundSubscription.fundSubscription(
            config.vrfCoordinator,
            config.subscriptionId,
            config.link,
            config.account
        );
    }

    function testCreateSubscriptionCreatesASubscriptionId() public view {
        assert(config.subscriptionId != 0);
    }
}
